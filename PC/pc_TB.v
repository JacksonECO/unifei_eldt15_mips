`timescale 1ns/10ps

module pc_TB();

	reg rst, clk;
	wire [9:0] count;
	
	
	pc DUT(		
		.rst(rst),
		.clk(clk),
		.count(count)	
	);

	initial 
	begin
		clk = 0;
		rst = 1;
		
		#10 rst = 0;
		
		#100 rst = 1;
		#50 rst = 0;
		
		#1000 $stop;
	end

	always #5 clk = ~clk;

endmodule 
