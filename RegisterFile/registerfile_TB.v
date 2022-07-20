`timescale 1ns/10ps

module registerfile_TB();
	
	reg [31:0] dataIn;
	reg we;
	reg clk, rst;
	reg [4:0] rs,rt,rd;
	wire [31:0] A,B;


	registerfile DUT(
    	.dataIn(dataIn),  
		.we(we), 
		.clk(clk),
		.rst(rst),
		.rs(rs),
		.rt(rt),
		.rd(rd),
		.A(A),
		.B(B)
	);

	initial begin
		clk = 1;
		rst = 0;
		we = 0;
		rs = 0;
		rt = 30;
		rd = 1;
		dataIn = 32'h1002aaff;

		#20 rst = 1;

		#100 we = 1;
		#700 we = 0;
		#100 rst = 0;
		#100 $stop;

	end
	
	always  begin
		#20 clk = ~clk;
		dataIn = dataIn + 32'b10111001;
		rs = rs + 1;
		rt = rt + 1;
		rd = rd + 1;
	end
	
endmodule
