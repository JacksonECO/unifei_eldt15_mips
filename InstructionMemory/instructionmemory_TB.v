`timescale 1ns/10ps
module instructionmemory_TB();

	reg [9:0] Addr;
	
	wire [31:0] Instruction;


	instructionmemory DUT (
		.Instruction(Instruction), 
		.Addr(Addr)
		
	);
	
	
	initial begin
		Addr = 0;
		#500 $stop;
	end 

	always #20 Addr = Addr + 1;
	
endmodule
