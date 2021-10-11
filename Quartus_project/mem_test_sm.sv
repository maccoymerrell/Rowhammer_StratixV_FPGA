
//timescale here for sim
`timescale 1ns / 1ps



module mem_test_sm
	#(
	  parameter ADDR_WIDTH = 'd64,		//address width in bits
	  parameter WORD_WIDTH = 'd64,		//word width in bits
	  parameter ROW_WIDTH  = 'd12,		//row bits in address
	  parameter ROW_POS    = 'd10,		//pos of row bits in address
	  parameter COL_WIDTH  = 'd10,		//col bits in address
	  parameter COL_POS	  = 'd0,			//pos of col bits in address
	  parameter MEM_TEST_SM_START   			= 4'd0, //start state, loads input pattern/address into registers
	  parameter MEM_TEST_SM_INITIALIZE_MEM	= 4'd1, //initializes target mem area
	  parameter MEM_TEST_SM_HAMMER_MEM		= 4'd2, //generates reads to mem to hammer
	  parameter MEM_TEST_SM_READ_MEM			= 4'd3, //reads target mem area back
	  parameter MEM_TEST_SM_TALLY_MEM		= 4'd4, //tally all bit flips in word
	  parameter MEM_TEST_SM_FINISH			= 4'd5 //finish
	)
	(	
	//these should be gotten from registers on startup
	input [WORD_WIDTH-1:0] pattern,		//pattern written to address
	input [ADDR_WIDTH-1:0] address,		//target address for attack (row)
	input [31:0]		   	count,		//how many hammers to generate
	
	//supplied by upper-level module
	input						clk,			//clock that drives the circuit we are injecting instructions into
	input						reset,		//reset to start state machine
	input						confirm,		//bit stops/starts machine when generating addressses
	input [WORD_WIDTH-1:0] pattern_rb, //pattern read back from address
	
	//supplied to upper-level module
	output [ADDR_WIDTH-1:0] gen_address,//address to generate read/write to
	output [WORD_WIDTH-1:0] gen_word,	//word to be written to address
	output						write,		//indicates write over read. 1 = write, 0 = read
	output  [3:0]				state,		//state the machine is in
	
	//written to registers on termination
	output [63:0]				bit_flip_count			//total number of recorded bit flips
	);
	
	//output signal registers
	logic [ADDR_WIDTH-1:0] gen_address_r;	//register for generated address
	
	//state tracking
	logic [31:0] count_r;						//current # of hammers done
	logic [3:0]  state_r;						//state of state machine
	logic 		 direction_r;					//direction of hammer ("left" or "right" attack)
	logic [COL_WIDTH-1:0] word_r;				//current word being read/written to
	logic [1:0]  word_q_r;						//current quarter of word
	
	//data recording
	logic [63:0] bit_flip_count_r;			//total bit flips recorded
	
	//state machine logic
	always_ff@(posedge clk) begin
		if(reset) begin
			gen_address_r <= 'b0;
			count_r		  <= 'b0;
			state_r		  <= 'b0;
			word_r		  <= 'b0;
			word_q_r		  <= 'b0;
			bit_flip_count_r <= 'b0;
		end
		else begin
			//state transitions
			case(state_r)
				MEM_TEST_SM_START: begin
					state_r <= MEM_TEST_SM_INITIALIZE_MEM;
				end
				MEM_TEST_SM_INITIALIZE_MEM: begin //once all words in target row have been written to, advance
					if((word_r < {COL_WIDTH{1'b1}}) & confirm) begin
						state_r <= MEM_TEST_SM_INITIALIZE_MEM;
					end
					else begin
						state_r <= MEM_TEST_SM_HAMMER_MEM;
					end
				end
				MEM_TEST_SM_HAMMER_MEM: begin //once all hammers done, advance
					if((count_r == count) & confirm) begin
						state_r <= MEM_TEST_SM_READ_MEM;
					end
					else begin
						state_r <= MEM_TEST_SM_HAMMER_MEM;
					end
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
				if(COL_POS == 1'b0) begin
					gen_address_r <= {address[ADDR_WIDTH-1:COL_WIDTH],word_r};
				end
				else if(COL_POS + COL_WIDTH == ADDR_WIDTH) begin
					gen_address_r <= {word_r, address[COL_POS - 1:0]};
				end
				else begin
					gen_address_r <= {address[ADDR_WIDTH-1:COL_POS + COL_WIDTH], word_r, address[COL_POS-1:0]};
				end
			end
			else if(state_r == MEM_TEST_SM_HAMMER_MEM) begin
				if(ROW_POS == 1'b0) begin
					gen_address_r <= direction_r ? {address[ADDR_WIDTH-1:ROW_WIDTH],address[ROW_WIDTH-1:0] - 'b1} :
															 {address[ADDR_WIDTH-1:ROW_WIDTH],address[ROW_WIDTH-1:0] + 'b1};
				end
				else if(ROW_POS + ROW_WIDTH == ADDR_WIDTH) begin
					gen_address_r <= direction_r ? {address[ADDR_WIDTH-1:ROW_POS] - 'b1, address[ROW_POS - 1:0]} :
															 {address[ADDR_WIDTH-1:ROW_POS] + 'b1, address[ROW_POS - 1:0]};
				end
				else begin
					gen_address_r <= direction_r ? {address[ADDR_WIDTH-1:ROW_POS + ROW_WIDTH], address[ROW_POS + ROW_WIDTH-1:ROW_POS] - 'b1, address[ROW_POS-1:0]} : 
															 {address[ADDR_WIDTH-1:ROW_POS + ROW_WIDTH], address[ROW_POS + ROW_WIDTH-1:ROW_POS] + 'b1, address[ROW_POS-1:0]};
				end
			end
			else if(state_r == MEM_TEST_SM_TALLY_MEM) begin
				gen_address_r <= gen_address_r;
			end
			else begin
				gen_address_r <= 'b0;
			end
			
			//word_r
			if(state_r == MEM_TEST_SM_INITIALIZE_MEM | state_r == MEM_TEST_SM_READ_MEM) begin
				if((word_r == {COL_WIDTH{1'b1}}) & confirm) begin
					word_r <= 'b0;
				end
				else begin
					word_r <= word_r + {{(COL_WIDTH-1){1'b0}},1'b1};
				end
			end
			else begin
				word_r <= 'b0;
			end
			
			//word_q_r
			if(state_r == MEM_TEST_SM_TALLY_MEM) begin
				if(word_q_r == 2'b11) begin
					word_q_r <= 'b0;
				end
				else begin
					word_q_r <= word_q_r + 2'b01;
				end
			end
			else begin
				word_q_r <= 'b0;
			end
			
			//count_r
			if(state_r == MEM_TEST_SM_HAMMER_MEM) begin
				if((count_r == {32{1'b1}}) & confirm) begin
					count_r <= 'b0;
				end
				else begin
					count_r <= count_r + 32'd1;
				end
			end
			else begin
				count_r <= 'b0;
			end
			
			//total bit flips bit_flip_count_r
			if(state_r == MEM_TEST_SM_TALLY_MEM) begin
				for(int i = 0; i < (WORD_WIDTH/4); i++) begin
					if(pattern[i + (word_q_r * (WORD_WIDTH/4))] ^ pattern_rb[i + (word_q_r * (WORD_WIDTH/4)]) begin
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
		end
	end
	
	//comb logic
	assign direction_r = count_r[0];
	
	//output assignments
	assign write = (state_r == MEM_TEST_SM_INITIALIZE_MEM);
	assign gen_word = pattern;
	assign gen_address = gen_address_r;//address to generate read/write to
	assign state = state_r;		//state the machine is in
	assign bit_flip_count = bit_flip_count_r;			//total number of recorded bit flips
	
endmodule
	