`timescale 1ns / 1ps

module tb_top;

	//signals tb needs to provide to sm
	logic clk;
	logic reset;
	logic confirm;
	logic [31:0] pattern;
	logic [31:0] pattern_rb;
	logic [31:0] count;
	logic [31:0] address;
	
	//outputs from sm
	logic [63:0] bit_flip_count;
	logic [31:0] generated_word;
	logic [31:0] generated_address;
	logic [3:0]	 state;
	logic 		 write;
	logic			 read;
	
	//internal reg to ease testing
	logic			 ready;		//testcase sets to 1 when its "done" with previous commmnd, 0 upon getting a new command
	
	//internal tracker of # of flipped bits generated
	static integer		 flipped_bits;
	static integer		 read_count;
	static integer		 write_count;
	
	//instantiation of DUT
	mem_test_sm 	
						#(
							.ADDR_WIDTH(32),		//address width in bits
							.WORD_WIDTH(32),		//word width in bits
							.ROW_WIDTH (12),		//row bits in address
							.ROW_POS   (10),		//pos of row bits in address
							.COL_WIDTH (10),		//col bits in address
							.COL_POS	  (0 )		//pos of col bits in address
						)
						dut(
							.clk(clk),
							.reset(reset),
							.confirm(confirm),
							.pattern(pattern),
							.pattern_rb(pattern_rb),
							.count(count),
							.address(address),
							
							.bit_flip_count(bit_flip_count),
							.gen_word(generated_word),
							.gen_address(generated_address),
							.state(state),
							.write(write),
							.read(read)
						);
						
	//create a clock signal
	initial begin
	clk <= 1'b0;
		forever begin
		#1 clk = ~clk;
		end
	end
	
	//tasks
	task wait_cycles(int cycles); //waits for cycles of clk
		repeat(cycles) begin
		@(posedge clk);
		@(negedge clk);
		end
	endtask

	task do_reset(); //resets sm
		reset <= 'b0;
		wait_cycles(5);
		reset <= 'b1;
		wait_cycles(5);
		reset <= 'b0;
		write_count = 0;
		read_count = 0;
		flipped_bits = 0;
	endtask
	
	task do_write(); //simulate write to mem
		confirm <= 'b0;
		wait_cycles($urandom_range(1,10));
		confirm <= 'b1;
		wait_cycles(1);
		confirm <= 'b0;
		write_count++;
	endtask
	
	task do_read(); //simulate read to mem
		confirm <= 'b0;
		wait_cycles($urandom_range(1,5));
		pattern_rb = pattern;
		//we need to sometimes generate a flipped bit when counting
		if($urandom_range(1,20) == 1) begin
			automatic integer num_of_flips = $urandom_range(1,1);
			for(int i = 0; i < num_of_flips; i++) begin
				automatic integer pos = $urandom_range(0,31);
				pattern_rb[pos] = pattern_rb[pos] ^ 1'b1;
				flipped_bits++;
			end
		end
		wait_cycles(1);
		confirm <= 'b1;
		wait_cycles(1);
		confirm <= 'b0;
		read_count++;
	endtask

	//do test
	initial begin
		//setup before start
		pattern <= 32'hffffffff;
		address <= 32'h000aaaaa;
		count	  <= 32'd100000;
		pattern_rb <= 'b0;
		confirm <= 'b0;
		
		//reset and start state machine
		do_reset();
		
		//we need to loop here until state enters finished, providing fake reads and writes
		while(state != 4'd5) begin
			if(write) begin
				$display("beginning write=%0d time=%0t addr=0x%0h word=0x%0h",write_count, $time, generated_address, generated_word);
				do_write();
			end
			else if(read) begin
				$display("beginning read=%0d time=%0t addr=0x%0h",read_count, $time, generated_address);
				do_read();
			end
			if(state == 4'd7)
				flipped_bits = 0;

			wait_cycles(1);
		end
		$display("finished expected=%0d actual=%0d", flipped_bits, bit_flip_count);
		$finish;
	end
	endmodule