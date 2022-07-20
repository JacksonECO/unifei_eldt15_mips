/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module alu (
		input 	  [31:0] data1, data2,
		input 	  [1:0] sel,
		output reg signed [31:0] out
	);

	always case(sel)
			2'b00: out <= data1 + data2; // Soma
			2'b01: out <= data1 - data2; // Subtração
			2'b10: out <= data1 & data2; // AND
			2'b11: out <= data1 | data2; // OR
	endcase			

endmodule 
