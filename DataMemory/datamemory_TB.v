`timescale 1ns/100ps
module datamemory_TB();

	parameter data_WIDTH = 32;
	parameter ADDR_WIDTH = 10;

	// Input Ports
	reg[ADDR_WIDTH-1:0] ADDR;
	reg RW_RD;
	reg CLK;
	reg [data_WIDTH-1:0] din;
	wire [data_WIDTH-1:0] dout;

	integer i = 0;

	// Device Under Test
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
		

		#20 RW_RD = 0;	// escrever
	
		// Varia o endereço e coloca um valor na entrada
		for(i=0; i<15; i=i+1) begin
			#80 ADDR = i;
			din = i;
		end
		
		RW_RD = 1; 	// ler
		// Varia o endereço 
		for(i=0; i<15; i=i+1) begin
			#80 ADDR = i;
		end
		
		#100 $stop;
	end

	always #40 CLK = ~CLK;
	
endmodule
