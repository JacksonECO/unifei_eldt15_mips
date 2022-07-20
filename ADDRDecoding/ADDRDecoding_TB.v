/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

`timescale 1ns/100ps

module ADDRDecoding_TB();
	wire CS;
	reg [31:0] ADDR;
	
	ADDRDecoding DUT(
		.CS(CS),
		.ADDR(ADDR)
	);
	
	integer i;
	initial begin
		for(i = 32'h4af0; i <= 16'h4b0f; i = i + 1)
		    #20 ADDR = i;
        for(i = 32'h4ef0; i <= 16'h4f0f; i = i + 1)
		    #20 ADDR = i;	
	end
	
endmodule