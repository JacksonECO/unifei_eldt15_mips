module Control(clk,St,rst,M,K,Idle,Done,Load,Sh,Ad);
		output reg Idle, Done, Load, Sh, Ad;
		input  clk, St, rst, M, K;
		
		reg [1:0] estado;
		parameter s0 = 2'b00,s1 = 2'b01,s2 = 2'b10,s3 = 2'b11;
		

		
		always @(posedge clk, negedge rst) begin
				if(~rst)
					estado <= s0;
				else
					casez(estado)
						s0:
							if(St)
								estado <= s1;
							else
								estado <= s0;
						s1:
								estado <= s2;
						s2:
							if(K)
								estado <= s3;
							else
								estado <= s1;
						s3:
							estado <= s0;
							
						default:
							estado <= s2;
					endcase
		end

		always @(estado, St, M) begin
			case(estado)
				s0: begin
					Done <= 1'b0;
					Sh <= 1'b0;
					Ad <= 1'b0;
					if(St) begin
						Idle <= 1'b0;
						Load <= 1'b1;
					end
					else   begin
						Idle <= 1'b1;
						Load <= 1'b0;
					end
				end
				s1: begin
					Idle <= 1'b0;
					Done <= 1'b0;
					Sh <= 1'b0;
					Load <= 1'b0;
					if(M) begin
						Ad <= 1'b1;
					end
					else   begin
						Ad <= 1'b0;
					end
				end
				s2: begin
					Idle <= 1'b0;
					Done <= 1'b0;
					Sh <= 1'b1;
					Load <= 1'b0;
					Ad <= 1'b0;
				end
				s3: begin
					Idle <= 1'b0;
					Done <= 1'b1;
					Sh <= 1'b0;
					Load <= 1'b0;
					Ad <= 1'b0;
				end
			endcase
		end
		
endmodule
