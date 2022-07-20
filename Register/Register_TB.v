/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

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
		rst = 0;	
		D = 0;
		#10 rst = 1;
		
		#500 rst = 0;
		#100 rst = 1;

		#500 $stop;
	end
		
	always #20 clk = ~clk;
	
	always #20 D = D + 1;
	
endmodule
