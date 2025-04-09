// up or down counts max at 16
module upCounter #(parameter WIDTH = 5)
	(clk, reset, incr, decr, out);
	
	input logic clk, reset, incr, decr;
	output logic [WIDTH - 1: 0] out;
	
	always_ff @(posedge clk) begin
		if (reset) 
			out <= 0;
		else if (incr && out < 16)
			out <= out + 1;
		else if (decr &&  out > 0)
			out <= out - 1;
	end
endmodule


module upCounter_testbench #(parameter WIDTH = 5);
	logic clk, reset, incr, decr;
	logic [WIDTH -1: 0] out;
	 
	upCounter dut (clk, reset, incr, decr, out);
	

	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1;  @(posedge clk);
		reset <= 0;	 @(posedge clk);
		
		incr <= 1; repeat(20) @(posedge clk); // try to go past 16
		incr <= 0;
		decr <= 1; repeat(20) @(posedge clk); // try to go below 0
		decr <= 0;

		reset <= 1; @(posedge clk); // test mid-sequence reset
		reset <= 0;	
		incr <= 0;   @(posedge clk); 
		incr <= 0; 	 @(posedge clk);
		incr <= 1;   @(posedge clk);
		incr <= 1;   @(posedge clk);
		incr <= 0;   @(posedge clk);
		incr <= 0;   @(posedge clk);
		incr <= 1; repeat(7)  @(posedge clk);

		$stop;
	end
endmodule
		
	
		
		
		
		
		


	
	
	
	