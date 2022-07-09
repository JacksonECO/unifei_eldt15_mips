module ACC(clk,rst,Load,Sh,Ad,lsb,msb,saida,M);
		input clk, rst, Load, Sh, Ad;
		input [15:0] lsb;
		input [16:0] msb;
		output [31:0] saida;
		output M;
		
		reg [32:0] mem;
		
		assign saida = mem[31:0];
		assign M = mem[0];
		
		always @(posedge clk, negedge rst) begin
				if(~rst) mem <= 33'd0;
				else
					case({Load,Ad,Sh})
							3'b100: mem <= {17'd0,lsb};
							3'b010: mem <= {msb,mem[15:0]};
							3'b001: mem <= {1'b0,mem[32:1]};
							default: mem <= mem;
					endcase
		end
		
endmodule
