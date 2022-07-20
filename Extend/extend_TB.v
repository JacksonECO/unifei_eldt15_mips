/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

`timescale 1ns/10ps

module extend_TB();

	reg enable;
	reg[15:0] dataIn;
	wire[31:0] dataOut;

	extend DUT(
		.enable(enable),
		.dataIn(dataIn),
		.dataOut(dataOut)
	);

	initial begin
		enable = 1;
		dataIn = 16'h58AC;
		
		#20 dataIn = 16'hAAAA;
		#20 dataIn = 16'h6666;
		#20 dataIn = 16'h6000;
		#20 enable = 0;
		#20 dataIn = 16'hAAAA;
		#20 dataIn = 16'h6666;
		
		#20 $stop;
		
	end

endmodule
