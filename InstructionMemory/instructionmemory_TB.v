`timescale 1ns/10ps
module instructionmemory_TB();

	reg clk;
	reg [9:0] Addr;
	wire [31:0] Instruction;


	instructionmemory DUT (
		.clk(clk),
		.Addr(Addr),
		.Instruction(Instruction)
	);
	
	
	initial begin
		Addr = 0;
		clk = 0;

		#500 $stop;
	end 

	always begin
		 #20 clk = ~clk;
		 Addr = Addr + 1;
	end
	
endmodule
