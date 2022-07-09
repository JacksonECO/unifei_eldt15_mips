`timescale 1ns/10ps
module instructionmemory_TB();

	reg [9:0] Addr;
	
	wire [31:0] Instruction;


	instructionmemory DUT (
		.Instruction(Instruction), 
		.Addr(Addr)
		
	);
	
	initial begin
		Addr=0;
		#10;
		Addr=1;
		#10;
		Addr=2;
		#10;
		Addr=3;
		#10;
		Addr=4;
		#10;
		Addr=5;
		#10;
		Addr=6;
		#10;
		Addr=7;
		#10;
		Addr=8;
		#10;
		Addr=9;
		#10;
		Addr=10;
		#10;
		Addr=11;
		#10;
		Addr=12;
		#10;
		Addr=13;
		#10;
		Addr=14;
		#10;
		Addr=15;
		#10;
		Addr=16;
		#10;
		Addr=17;
		#10;
		Addr=18;
		#10;
		Addr=19;
		#10;
		Addr=20;
		#10;
		Addr=21;
		#10;
		Addr=22;
		#10;
		Addr=23;
		#10;
		Addr=24;
		#10;
		Addr=25;
		
	end
	
	initial #500 $stop;
	
endmodule
