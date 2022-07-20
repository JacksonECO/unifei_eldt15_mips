/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module extend(
	input enable,
	input [15:0] dataIn,
	output reg [31:0] dataOut
);

	always @(*) begin
		dataOut = 0;
		if(enable) begin
			if(dataIn[15])
				dataOut = {16'b1111_1111_1111_1111,dataIn[15:0]};
			else
				dataOut = {16'b0,dataIn[15:0]};		
		end
	end
	
endmodule
