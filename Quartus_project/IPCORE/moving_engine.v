module moving_engine
(
      output [32:0]                          slowmem_addr,
      input                                  slowmem_waitrequest,
      output [3:0]                           slowmem_burstcount,
      output                                 slowmem_read,
      input [511:0]                           slowmem_readdata,
      input                                  slowmem_readdatavalid,
      output                                 slowmem_write,
      output [511:0]                          slowmem_writedata,
      output                                 slowmem_lock,
      output [32:0]                          fastmem_addr,
      input                                  fastmem_waitrequest,
      output [3:0]                           fastmem_burstcount,
      output                                 fastmem_read,
      input [511:0]                           fastmem_readdata,
      input                                  fastmem_readdatavalid,
      output                                 fastmem_write,
      output [511:0]                          fastmem_writedata,
      output                                 fastmem_lock,
      input [18:0]                           src_pg,
      input [18:0]                           des_pg,
      input                                  pg_update,
      output                                 in_process,
      input                                  AvlClk_i,
      input                                  Rstn_i
    );
  localparam IDLE = 2'b00;
  localparam TRANSFER = 2'b01;
  localparam CHECK_PAGE = 2'b10;
  wire mov_buf_rd;
  wire mov_buf_wr;
  wire [511:0] income;
  reg direction;
  wire [4:0] pndg_usedw;
  wire [5:0] mov_buf_usedw;
  reg [17:0] working_src;
  reg [17:0] working_des;
  wire [37:0] working_pgs;
  reg pndg_rdreq;
  reg [11:0] rd_pg_offset;
  reg [12:0] wr_pg_offset;
  wire [31:0] rd_address;
  wire [31:0] wr_address;
  wire read;
  reg write;
  wire [511:0] writedata;
  reg [1:0] rd_cur_state;
  reg [1:0] wr_cur_state;
  wire rd_waitrequest;
  wire wr_waitrequest;
  reg pre_mov_rd;
  reg pre_pndg_rdreq;

  //The direction decides which memory is the source and which is the 
  //destination.
  //Direction is 1 when data is read from slowmem and written to fastmem.
  assign slowmem_addr =  direction? rd_address : wr_address;
  assign slowmem_read = direction? read : 1'b0;
  assign slowmem_burstcount = direction? 4'h8 : 4'h1;
  assign slowmem_write = direction? 1'b0 : write;
  assign slowmem_writedata = writedata;
  assign fastmem_addr = direction? wr_address : rd_address;
  assign fastmem_read = direction? 1'b0 : read ;
  assign fastmem_burstcount = direction? 4'h1: 4'h8;
  assign fastmem_write = direction? write : 1'b0;
  assign fastmem_writedata = writedata;
  assign in_process = wr_cur_state[0] | rd_cur_state[0];
  assign rd_waitrequest = direction? slowmem_waitrequest : fastmem_waitrequest;
  assign wr_waitrequest = direction? fastmem_waitrequest : slowmem_waitrequest;
    

//Fifo of the pending page movement requests. Each entry are 38 bits, containing 
//the source page number (19 bits wide) and destination page number.

	scfifo	# (
	       .add_ram_output_register("OFF"),
		     .intended_device_family("Stratix V"),
		     .lpm_numwords(32),
		     .lpm_showahead("OFF"),
		     .lpm_type("dcfifo"),
		     .lpm_width(38),
		     .lpm_widthu(5),
		     .overflow_checking("ON"),
		     .underflow_checking("ON"),
		     .use_eab("ON")
		  ) 
   pndg_moves 
    ( 
				.rdreq (pndg_rdreq),
                                .clock (AvlClk_i),
				.wrreq (pg_update),
				.data ({src_pg,des_pg}),
				.usedw (pndg_usedw),
				.q (working_pgs),
				.aclr (~Rstn_i)
                              );
	scfifo	# (
	       .add_ram_output_register("OFF"),
		     .intended_device_family("Stratix V"),
		     .lpm_numwords(64),
		     .lpm_showahead("OFF"),
		     .lpm_type("dcfifo"),
		     .lpm_width(512),
		     .lpm_widthu(6),
		     .overflow_checking("ON"),
		     .underflow_checking("ON"),
		     .use_eab("ON")
		  ) 
   moving_buf 
    ( 
				.rdreq (mov_buf_rd),
                                .clock (AvlClk_i),
				.wrreq (mov_buf_wr),
				.data (income),
				.usedw (mov_buf_usedw),
				.empty (),
				.q (writedata),
				.full () ,
				.aclr (~Rstn_i),
				.almost_empty (),
				.almost_full (),
				.sclr ()
                              );

  assign income = direction? slowmem_readdata : fastmem_readdata; 
  assign mov_buf_wr = direction? slowmem_readdatavalid : fastmem_readdatavalid;
//The read request could only be asserted for one cycle. 
    always @ (posedge AvlClk_i or negedge Rstn_i ) begin
      if (~Rstn_i) 
        pndg_rdreq <= 1'b0;
        else if((rd_cur_state == IDLE) & (pndg_usedw > 5'h00) & (wr_cur_state == IDLE) & ~pndg_rdreq)
          pndg_rdreq <= 1'b1;
        else pndg_rdreq <= 1'b0;
      end
//We decide the direction, source page number and destination
//page number during the CHECK_PAGE stage.
    always @ (posedge AvlClk_i or negedge Rstn_i ) begin
      if (~Rstn_i ) begin 
                working_src <= 18'h00000;
                working_des <= 18'h00000;
                direction <= 1'b0;
              end
              else if(rd_cur_state == CHECK_PAGE) begin
                working_src <= working_pgs[36:19];
                working_des <= working_pgs[17:0];
                direction <= working_pgs[37];
          end
              else begin
                working_src <= working_src;
                working_des <= working_des;
                direction <= direction;
              end
        end

//The burstlength for each read request is 8.
//Thus we increment the offset within page by 8*512bit = 512Bytes.
//While the waitrequest is asserted, we need to keep addr constant.
    always @ (posedge AvlClk_i or negedge Rstn_i ) begin
      if (~Rstn_i) begin 
                rd_pg_offset <= 12'h000;
              end
              else if(rd_cur_state == CHECK_PAGE) 
                rd_pg_offset <= 12'h000;
              else if (rd_cur_state == TRANSFER) begin
                if (rd_pg_offset == 0)
                  rd_pg_offset <= rd_pg_offset + 12'd512;
                else if (rd_pg_offset < 12'd3584) begin
                  if(~rd_waitrequest)
                    rd_pg_offset <= rd_pg_offset + 12'd512;
                  else
                    rd_pg_offset <= rd_pg_offset;
                end
                else begin
                  if(~rd_waitrequest)
                    rd_pg_offset <= 12'h000;
                end
              end
              else rd_pg_offset <= 12'h000;
            end

//The read funcion FSM.
//It will transfer from IDLE to CHECK_PAGE when there is pending moves.
//The TRANSFER stage completes when the read offset reaches the end.

    always @ (posedge AvlClk_i or negedge Rstn_i ) begin
      if (~Rstn_i) begin
        rd_cur_state <= IDLE;
      end
        else
    begin
        case(rd_cur_state)
          IDLE :
            if( pndg_rdreq)
                rd_cur_state <= CHECK_PAGE;
            else
              rd_cur_state <= IDLE;
          CHECK_PAGE:
                rd_cur_state <= TRANSFER;


          TRANSFER:
            if((rd_pg_offset == 12'd3584) & ~rd_waitrequest) 
              rd_cur_state <= IDLE;
             else   rd_cur_state <= TRANSFER;
            
          default: rd_cur_state <= IDLE;
         endcase
     end
   end
   assign rd_address = {2'b00, working_src, rd_pg_offset};
//The write is a litte bit more complicated:
//We could only send read request to the moving data fifo
//when the waitrequest is deasserted.
//Since the fifo needs two cycles to return the data,
//we need to carefully sync the write signal with the arrival of data. 
  always @ (posedge AvlClk_i or negedge Rstn_i)
    begin
      if (~Rstn_i)
        write <= 1'b0;
      else write <= mov_buf_rd;
    end
      
  always @ (posedge AvlClk_i or negedge Rstn_i)
    begin
      if (~Rstn_i)
        pre_mov_rd <= 1'b0;
      else pre_mov_rd <= mov_buf_rd;
    end
  always @ (posedge AvlClk_i or negedge Rstn_i)
    begin
      if (~Rstn_i)
        pre_pndg_rdreq <= 1'b0;
      else pre_pndg_rdreq <= pndg_rdreq;
    end
  assign read = rd_cur_state[0];
  assign mov_buf_rd = (mov_buf_usedw > 6'h00) & ~wr_waitrequest & ~pre_mov_rd;
  
  //The write FSM is similar to the read FSM.
  always @ (posedge AvlClk_i or negedge Rstn_i)
    begin
      if (~Rstn_i) begin
        wr_cur_state <= IDLE;
      end
        else begin
        case(wr_cur_state)
          IDLE:
            if(mov_buf_usedw > 6'h00) 
                  wr_cur_state <= TRANSFER;
                else
                  wr_cur_state <= IDLE;
          TRANSFER:
                if ((wr_pg_offset == 13'hfc0) & ~wr_waitrequest & write) 
                  wr_cur_state <= IDLE;
                else 
                  wr_cur_state <= TRANSFER;
            default: wr_cur_state <= IDLE;
        endcase
      end
    end



  //While the waitrequest is asserted, we need to keep three signals constant:
  //The write, the writedata, and the address.

  always @ (posedge AvlClk_i or negedge Rstn_i)
    begin
      if (~Rstn_i) 
                  wr_pg_offset <= 13'h0000;
        else begin
        case(wr_cur_state)
          IDLE:
            if(mov_buf_usedw > 6'h00)
                  // If there are less than 32 entries in the data fifo.
              // The burst length will be all the entries we have in the fifo.
                  wr_pg_offset <= 13'h0000;
              
                else
                  wr_pg_offset <= wr_pg_offset;
                 
                TRANSFER:
                if ((wr_pg_offset == 13'hfc0) & ~wr_waitrequest & write) 
                  wr_pg_offset <= 13'h0000;

                else if(write & ~wr_waitrequest)
                   wr_pg_offset <= 13'd64 + wr_pg_offset;

                  else wr_pg_offset <= wr_pg_offset;
                
                default: begin
                  wr_pg_offset <= wr_pg_offset;
                end

        endcase
    end
  end
                  assign wr_address= {2'b00, working_des, wr_pg_offset[11:0]};

  endmodule







