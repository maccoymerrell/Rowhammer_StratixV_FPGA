
//timescale here for sim
`timescale 1ns / 1ps

module mem_test_sm
	#(
	  parameter ADDR_WIDTH = 'd64,		//address width in bits
	  parameter WORD_WIDTH = 'd64,		//word width in bits
	  parameter ROW_WIDTH  = 'd12,		//row bits in address
	  parameter ROW_POS    = 'd10,		//pos of row bits in address
	  parameter COL_WIDTH  = 'd10,		//col bits in address
	  parameter COL_POS	  = 'd1,			//pos of col bits in address
	  parameter MEM_TEST_SM_START   			= 4'd0, //start state, loads input pattern/address into registers
	  parameter MEM_TEST_SM_LOAD_COUNT		= 4'd8, //loads count value
	  parameter MEM_TEST_SM_LOAD_ADDRESS	= 4'd9, //loads address value
	  parameter MEM_TEST_SM_LOAD_PATTERN	= 4'd10,//loads pattern value
	  parameter MEM_TEST_SM_INITIALIZE_MEM	= 4'd1, //initializes target mem area
	  parameter MEM_TEST_SM_ADDRESS_RESET_0= 4'd6, //resets output address before hammering
	  parameter MEM_TEST_SM_HAMMER_MEM		= 4'd2, //generates reads to mem to hammer
	  parameter MEM_TEST_SM_ADDRESS_RESET_1= 4'd7, //resets output address after hammering
	  parameter MEM_TEST_SM_READ_MEM			= 4'd3, //reads target mem area back
	  parameter MEM_TEST_SM_TALLY_MEM		= 4'd4, //tally all bit flips in word
	  parameter MEM_TEST_SM_STOR_FLIPS		= 4'd11,//store the total bit flips (actual just enable writes)
	  parameter MEM_TEST_SM_FINISH			= 4'd5 //finish
	)
	(
	
	//supplied by upper-level module
	input							clk,						//clock that drives the circuit we are injecting instructions into
	input							reset,					//reset to start state machine
	input							wait_request,			//bit stops/starts machine when set high
	input							read_data_valid,		//bit stops state machine on read unless high
	input [WORD_WIDTH-1:0]  pattern_rb,    		//pattern read back from address
	
	//supplied to upper-level module
	output [ADDR_WIDTH-1:0] gen_address,	//address to generate read/write to
	output [WORD_WIDTH-1:0] gen_word,		//word to be written to address
	output						write,			//indicates write
	output						read,				//indicates read
	output [3:0]				state			//state the machine is in
	);
	
	//retrieved from memory on startup
	logic [WORD_WIDTH-1:0]  pattern;			//pattern written to address
	logic [ADDR_WIDTH-1:0]  address;			//target address for attack (row)
	logic [31:0]            count;			//how many hammers to generate
	
	//values to facilitate memory loading
	logic [63:0]				qdata;			//data read from memory
	logic [4:0]					raddr;			//address of data read from memory
	logic							wren;				//write enable
	
	//output signal registers
	logic  [ADDR_WIDTH-1:0] gen_address_r;	//register for generated address
	
	logic [31:0] count_r;						//current # of hammers done
	logic [3:0]  state_r;						//state of state machine
	logic 		 direction_r;					//direction of hammer ("left" or "right" attack)
	logic [COL_WIDTH-1:0] word_r;				//current word being read/written to
	logic [1:0]  word_q_r;						//current quarter of word
	
	//data recording
	logic  [63:0] 		bit_flip_count_r;//total bit flips recorded
	logic					confirm;
	
	//state machine logic
	always_ff@(posedge clk) begin
		if(reset) begin
			gen_address_r 	  <= 'b0;
			count_r		  <= 'b0;
			state_r		  <= 'b0;
			word_r		  <= 'b0;
			word_q_r		  <= 'b0;
			bit_flip_count_r <= 'b0;
			raddr <= 'b0;
			wren  <= 'b0;
		end
		else begin
			//state transitions
			case(state_r)
				MEM_TEST_SM_START: begin
					state_r <= MEM_TEST_SM_LOAD_COUNT;
				end
				MEM_TEST_SM_LOAD_COUNT: begin
					state_r <= MEM_TEST_SM_LOAD_ADDRESS;
				end
				MEM_TEST_SM_LOAD_ADDRESS: begin
					state_r <= MEM_TEST_SM_LOAD_PATTERN;
				end
				MEM_TEST_SM_LOAD_PATTERN: begin
					state_r <= MEM_TEST_SM_INITIALIZE_MEM;
				end
				MEM_TEST_SM_INITIALIZE_MEM: begin //once all words in target row have been written to, advance
					if((word_r == {COL_WIDTH{1'b1}}) & confirm) begin
						state_r <= MEM_TEST_SM_ADDRESS_RESET_0;
					end
					else begin
						state_r <= MEM_TEST_SM_INITIALIZE_MEM;
					end
				end
				MEM_TEST_SM_ADDRESS_RESET_0:begin
					state_r <= MEM_TEST_SM_HAMMER_MEM;
				end
				MEM_TEST_SM_HAMMER_MEM: begin //once all hammers done, advance
					if((count_r == count) & confirm) begin
						state_r <= MEM_TEST_SM_ADDRESS_RESET_1;
					end
					else begin
						state_r <= MEM_TEST_SM_HAMMER_MEM;
					end
				end
				MEM_TEST_SM_ADDRESS_RESET_1:begin
					state_r <= MEM_TEST_SM_READ_MEM;
				end
				MEM_TEST_SM_READ_MEM: begin //once all words in target row have been read from, advance
						if(confirm) begin
							state_r <= MEM_TEST_SM_TALLY_MEM;
						end
						else begin
							state_r <= MEM_TEST_SM_READ_MEM;
						end
				end
				MEM_TEST_SM_TALLY_MEM: begin
					if(word_q_r == 2'b11 & word_r == {COL_WIDTH{1'b1}}) begin
						state_r <= MEM_TEST_SM_FINISH;
					end
					else if(word_q_r == 2'b11) begin
						state_r <= MEM_TEST_SM_READ_MEM;
					end
					else begin
						state_r <= MEM_TEST_SM_TALLY_MEM;
					end
				end
				MEM_TEST_SM_FINISH: begin //loop indefinitely, wait for reset
					state_r <= MEM_TEST_SM_FINISH;
				end			
				default: begin
					state_r <= MEM_TEST_SM_FINISH;
				end
			endcase
			
			//now handle the logic for the wires
			//gen_address_r
			if(state_r == MEM_TEST_SM_INITIALIZE_MEM || state_r == MEM_TEST_SM_READ_MEM) begin
				gen_address_r[COL_WIDTH + COL_POS - 1 : COL_POS] <= word_r;
			end
			else if(state_r == MEM_TEST_SM_HAMMER_MEM) begin
				gen_address_r[ROW_WIDTH + ROW_POS - 1: ROW_POS] <= direction_r ? (gen_address_r[ROW_WIDTH + ROW_POS - 1: ROW_POS] - 1'b1) :
																									  (gen_address_r[ROW_WIDTH + ROW_POS - 1: ROW_POS] + 1'b1);
			end
			else if(state_r == MEM_TEST_SM_TALLY_MEM) begin
				gen_address_r <= gen_address_r;
			end
			else begin
				gen_address_r <= address;
			end
			//word_r
			if(state_r == MEM_TEST_SM_INITIALIZE_MEM | state_r == MEM_TEST_SM_READ_MEM | state_r == MEM_TEST_SM_TALLY_MEM) begin
				if(confirm & state_r != MEM_TEST_SM_TALLY_MEM) begin
					word_r <= word_r + {{(COL_WIDTH-1){1'b0}},1'b1};
				end
				else begin	
					word_r <= word_r;
				end
			end
			else begin
				word_r <= 'b0;
			end
			
			//word_q_r
			if(state_r == MEM_TEST_SM_TALLY_MEM) begin
				word_q_r <= word_q_r + 2'b01;
			end
			else begin
				word_q_r <= 'b0;
			end
			
			//count_r
			if(state_r == MEM_TEST_SM_HAMMER_MEM) begin
				if(confirm) begin
					count_r <= count_r + 32'd1;
				end
				else begin
					count_r <= count_r;
				end
			end
			else begin
				count_r <= 'b0;
			end
			
			//total bit flips bit_flip_count_r
			if(state_r == MEM_TEST_SM_TALLY_MEM) begin
				for(int i = 0; i < (WORD_WIDTH/4); i++) begin
					if(pattern[i + (word_q_r * (WORD_WIDTH/4))] ^ pattern_rb[i + (word_q_r * (WORD_WIDTH/4))]) begin
						bit_flip_count_r <= bit_flip_count_r + {{31{1'b0}},1'b1};
					end
				end
			end
			else if((state_r == MEM_TEST_SM_FINISH) | state_r == MEM_TEST_SM_READ_MEM) begin
				bit_flip_count_r <= bit_flip_count_r;
			end
			else begin
				bit_flip_count_r <= 'b0;
			end
			
			//load & initialization
			if(state_r == MEM_TEST_SM_START) begin
				raddr <= 5'b00000;
				address <= address;
				pattern <= pattern;
				count <= count;
			end
			else if(state_r == MEM_TEST_SM_LOAD_ADDRESS) begin
				raddr <= 5'b00001;
				address <= qdata[ADDR_WIDTH-1:0];
				count <= count;
				pattern <= pattern;
			end
			else if(state_r == MEM_TEST_SM_LOAD_COUNT) begin
				raddr <= 5'b00010;
				count <= qdata[31:0];
				address <= address;
				pattern <= pattern;
			end
			else if(state_r == MEM_TEST_SM_LOAD_PATTERN) begin
				pattern <= qdata[WORD_WIDTH-1:0];
				raddr <= 5'b00000;
				count <= count;
				address <= address;
			end
			else begin
				raddr <=2'b00011;
				count <= count;
				address <= address;
				pattern <= pattern;
			end
			
			//write result to mem
			if(state_r == MEM_TEST_SM_STOR_FLIPS) begin
				wren <= 1'b1;
			end
			else begin
				wren <= 1'b0;
			end
		end
	end
	
	//comb logic
	assign direction_r = count_r[0];
	assign confirm = !(wait_request || (!read_data_valid & state_r == MEM_TEST_SM_READ_MEM));
	
	//output assignments
	assign write = (state_r == MEM_TEST_SM_INITIALIZE_MEM);
	assign read  = (state_r == MEM_TEST_SM_READ_MEM || state_r == MEM_TEST_SM_HAMMER_MEM);
	assign gen_word = pattern;
	assign gen_address = gen_address_r;				//address to generate read/write to
	assign state = state_r;								//state the machine is in
	
	//module connections
	mem_loader	mem_loader_inst (
	.clock 		(clk),
	.data 		(bit_flip_count_r),
	.address 	(raddr),
	.wren 		(wren),
	.q 			(qdata)
	);
	
endmodule
	
