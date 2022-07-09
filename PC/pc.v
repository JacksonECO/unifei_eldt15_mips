module pc (
	input rst, clk,
	output [9:0] count
);

	reg [9:0] PC_reg;	
	assign count = PC_reg;
	
	always @ (posedge clk, posedge rst)									
			if (rst) 
					PC_reg <= 10'b0;
			else 
					PC_reg <= PC_reg + 1'b1;
	
endmodule
