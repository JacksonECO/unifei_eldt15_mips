module pc (
	input rst, clk,
	output reg [9:0] count
);

	always @ (posedge clk or negedge rst)									
			if (~rst) 
					count <= 10'b0;
			else 
				if(clk) count <= count + 1'b1;
	
endmodule
