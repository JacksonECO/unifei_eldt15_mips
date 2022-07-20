module Register(
		input rst, clk,
		input [31:0] D,
		output reg  [31:0] Q
	);
		
	always @(posedge clk or negedge rst)
		if (~rst)
			Q <= 32'b0;
		else
			Q <= D;
	
endmodule 
