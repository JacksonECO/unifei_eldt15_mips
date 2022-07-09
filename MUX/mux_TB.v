`timescale 1ns/10ps
module mux_TB();
	
	reg [31:0] data1, data2;
	reg sel;
	wire [31:0]out;
	
	mux DUT(
		.out(out),
		.data1(data1),
		.data2(data2),
		.sel(sel)
	);
	
	
	initial begin
		data1 = 32'h0;
		data2 = 32'hFFF;
		
		sel = 0;
		#100 $stop;
		
	end
	
	always begin
		#3  data1 = data1 +1;
		data2 = data2 -1;
	end
	
	always #2 sel = !sel;

endmodule
