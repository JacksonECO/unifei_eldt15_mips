module mux(
		input [31:0] data1, data2,
		input sel,
		output reg [31:0] out
	);
	
	always begin
		if(sel) out <= data2;
		else out <= data1;
	end

endmodule
