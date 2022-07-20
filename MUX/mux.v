/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module mux(
		input [31:0] data1, data2,
		input sel,
		output reg [31:0] out
	);
	
	always begin
		if(sel) out <= data2;
		else out <= data1;
	end

endmodule
