/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

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
		rst = 0;
		
		#10 rst = 1;
		
		#100 rst = 0;
		#50 rst = 1;
		
		#1000 $stop;
	end

	always #5 clk = ~clk;

endmodule 
