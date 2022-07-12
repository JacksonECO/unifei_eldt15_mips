module extend(
	input enable,
	input [15:0] dataIn,
	output reg [31:0] dataOut
);

	always @(*) begin
		if(enable) begin
			if(dataIn[15])
				dataOut = {16'b1111111111111111,dataIn[15:0]};
			else
				dataOut = {16'b0,dataIn[15:0]};		
		end
		else dataOut = 0;
	end
	
endmodule
