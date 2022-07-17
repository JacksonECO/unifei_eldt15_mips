module instructionmemory(Instruction, Addr);
	input [9:0] Addr;
	output [31:0] Instruction;
	
	reg [31:0] Instruction_reg;
	reg [31:0] mem[0:1023];
	
	initial begin
		//         |6' num |5' rs|5' rt|   16' offset      |
		mem[0] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[1] = 32'b010000_01111_00000_0100_1011_0000_0010;	//Load A no reg0 - 00000
		mem[2] = 32'b010000_01111_00001_0100_1011_0000_0011;	//Load B no reg1 - 00001 
		mem[3] = 32'b010000_01111_00010_0100_1011_0000_0100;	//Load C no reg2 - 00010
		mem[4] = 32'b010000_01111_00011_0100_1011_0000_0101;	//Load D no reg3 - 00011
					//|6' num |5' rs|5' rt|5' rd|5' 10|6' code|
		mem[5] = 32'b001111_00000_00001_00100_01010_110010;	//Mult reg0 e reg1 e salva no reg4 
		mem[6] = 32'b001111_00010_00011_00101_01010_100000;	//Add  reg2 e reg3 e salva no reg5
		mem[7] = 32'b001111_00100_00101_00110_01010_100010;	//Sub  reg4 e reg5 e salva no reg6
					//|6' num |5' rs|5' rt|   16' offset      |
		mem[8] = 32'b010001_01111_00110_0100_1110_1111_1111;	//Store reg6 no Addr Hx4EFF	
		
		//corrigindo o pipeline hazzard
		
					//|6' num |5' rs|5' rt|   16' offset      |
		mem[9]  = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[10] = 32'b010000_01111_00000_0100_1011_0000_0010;	//Load A no reg0 - 00000
		mem[11] = 32'b010000_01111_00001_0100_1011_0000_0011;	//Load B no reg1 - 00001 
		mem[12] = 32'b010000_01111_00010_0100_1011_0000_0100;	//Load C no reg2 - 00010
		mem[13] = 32'b010000_01111_00011_0100_1011_0000_0101;	//Load D no reg3 - 00011
		mem[14] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[15] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
					//|6' num |5' rs|5' rt|5' rd|5' 10|6' code|
		mem[16] = 32'b001111_00000_00001_00100_01010_110010;	//Mult reg0 e reg1 e salva no reg4 
		mem[17] = 32'b001111_00010_00011_00101_01010_100000;	//Add  reg2 e reg3 e salva no reg5
					//|6' num |5' rs|5' rt|   16' offset      |
		mem[18] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[19] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[20] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
					//|6' num |5' rs|5' rt|5' rd|5' 10|6' code|
		mem[21] = 32'b001111_00100_00101_00110_01010_100010;	//Sub  reg4 e reg5 e salva no reg6
					//|6' num |5' rs|5' rt|   16' offset      |
		mem[22] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[23] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[24] = 32'b010000_01111_00000_0000_0000_0000_0000;	//"NOP"
		mem[25] = 32'b010001_01111_00110_0100_1110_1111_1111;	//Store reg6 no Addr Hx4EFF	
		//end
		
	
	end
	
	assign Instruction = Instruction_reg;
	
	always @(Addr) begin
	
		Instruction_reg <= mem[Addr];
	
	end

endmodule
