`timescale 1ns/10ps

module Register_TB();

	reg rst, clk;
	reg [31:0] D;
	wire [31:0] Q;
		
	Register DUT(
		.rst(rst),
		.clk(clk),
		.D(D),
		.Q(Q)
	);
		
		
	initial begin
		clk = 0;
		rst = 1;	
		D = 0;
		#10 rst = 0;
		
		#500 rst = 1;
		#100 rst = 0;

		#500 $stop;
	end
		
	always #20 clk = ~clk;
	
	always #20 D = D + 1;
	
endmodule
