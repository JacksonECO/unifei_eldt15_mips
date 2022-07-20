/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

`timescale 1ns/10ps

module alu_TB;

	reg  [31:0] data1, data2;
	reg  [1:0] sel;
	wire [31:0] out;	
	
	alu DUTalu (
		.data1(data1),
		.data2(data2),
		.sel(sel),
		.out(out)
	);
	
	
	initial #2000 $stop;
	
	always begin
		data1 = $random;
		data2 = $random;
		
		sel = 2'b00;
		#30 sel <= 2'b01;
		#30 sel <= 2'b10;
		#30 sel <= 2'b11;
		#30 $nop;
	end
		
endmodule
