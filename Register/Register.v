/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module Register(
		input rst, clk,
		input [31:0] D,
		output reg  [31:0] Q
	);
		
	always @(posedge clk or negedge rst)
		if (~rst)
			Q <= 32'b0;
		else
			Q <= D;
	
endmodule 
