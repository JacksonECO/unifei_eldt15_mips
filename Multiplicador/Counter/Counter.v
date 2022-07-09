module Counter(clk, rst, entrada, saida);
		output reg saida;
		input clk, rst, entrada;
		
		reg [4:0] C;
		
		always @(posedge clk, negedge rst) begin
				if(~rst) begin
					C<=5'b00000;
					saida<=1'b0;
				end
				else begin
						if(entrada) begin
							C<=5'b00000;
							saida<=1'b0;
						end
						else begin
								C <= C + 1'b1;
								if(C == 5'd30) saida <= 1'b1;
						end
				end
		end

endmodule
