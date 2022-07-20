/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

`timescale 1ns/10ps
module mux_TB();
	
	reg [31:0] data1, data2;
	reg sel;
	wire [31:0]out;
	
	mux DUT(
		.out(out),
		.data1(data1),
		.data2(data2),
		.sel(sel)
	);
	
	
	initial begin
		data1 = 32'h0;
		data2 = 32'hFFF;
		
		sel = 0;
		#1000 $stop;
		
	end
	
	always begin
		#20  data1 = data1 +1;
		data2 = data2 -1;
	end
	
	always #40 sel = !sel;

endmodule
