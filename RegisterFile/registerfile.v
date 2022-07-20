/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module registerfile 
	#(
		parameter n_register = 32
	)
	(
		input [31:0] dataIn,
		input we,
		input clk, rst,
		input [4:0] rs,rt,rd,
		output reg [31:0] A,B
	);

	integer i;
	
	reg [31:0] register [0:n_register-1];
	
	always @ (negedge clk, negedge rst)
		if(~rst)
			for(i = 0; i < n_register; i = i+1)
				register[i] = 32'b0;
		else if (we) 
			register[rd] <= dataIn;
	
	always @ (posedge clk) begin
		A <= register[rs];
		B <= register[rt];
	end

endmodule
