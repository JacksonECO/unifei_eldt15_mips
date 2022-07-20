/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

`timescale 1ns/100ps
module datamemory_TB();

	parameter data_WIDTH = 32;
	parameter ADDR_WIDTH = 10;

	reg[ADDR_WIDTH-1:0] ADDR;
	reg RW_RD;
	reg CLK;
	reg [data_WIDTH-1:0] din;
	wire [data_WIDTH-1:0] dout;

	integer i;

	datamemory DUT (
		.ADDR(ADDR),
		.RW_RD(RW_RD),
		.CLK(CLK),
		.din(din),
		.dout(dout)
	);

	initial begin
		CLK = 0;
		RW_RD = 0;
		ADDR = 0;
		din = 0;

		#20 RW_RD = 0;	// Escrever
		for(i=0; i<15; i=i+1) begin
			#80 ADDR = i;
			din = i;
		end
		
		RW_RD = 1; 	// Ler
		for(i=0; i<15; i=i+1) begin
			#80 ADDR = i;
		end
		
		#100 $stop;
	end

	always #40 CLK = ~CLK;
	
endmodule
