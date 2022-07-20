/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module pc (
	input rst, clk,
	output reg [9:0] count
);

	always @ (posedge clk or negedge rst)									
			if (~rst) 
				count <= 10'b0;
			else 
				count <= count + 1'b1;
	
endmodule
