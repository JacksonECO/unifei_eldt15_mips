`timescale 1ns/100ps

module ADDRDecoding_TB();
	wire CS;
	reg [31:0] ADDR;
	
	ADDRDecoding DUT(
		.CS(CS),
		.ADDR(ADDR)
	);
	
	integer i;
	initial begin
		for(i = 32'h4af0; i <= 16'h4b0f; i = i + 1)
		    #20 ADDR = i;
        for(i = 32'h4ef0; i <= 16'h4f0f; i = i + 1)
		    #20 ADDR = i;	
	end
	
endmodule