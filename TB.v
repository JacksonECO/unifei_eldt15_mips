`timescale 1ns/1ns

module TB();
	
	reg CLK;
	reg RST;
	wire CS, WR;
	wire [31:0] ADDR, Data_BUS_WRITE;
	reg  [31:0] Data_BUS_READ;

    // Variáves externas
    reg [9:0] PcPointer;
    reg CLK_SYS, CLK_MUL;
    reg [31:0] B1Out, writeBack;
	
	cpu DUT (
        .CLK(CLK),
        .Rst(RST),
        .Data_BUS_READ(Data_BUS_READ),
        .ADDR(ADDR), 
        .Data_BUS_WRITE(Data_BUS_WRITE),
        .CS(CS),
        .WR_RD(WR)
	);
	
	initial begin
		$init_signal_spy("/TB/DUT/PcPointer","PcPointer",1);
		$init_signal_spy("/TB/DUT/CLK_SYS","CLK_SYS",1);
		$init_signal_spy("/TB/DUT/CLK_MUL","CLK_MUL",1);
		$init_signal_spy("/TB/DUT/B1Out","B1Out",1);
		$init_signal_spy("/TB/DUT/writeBack","writeBack",1);
				
		CLK = 0;
		RST = 0;
		Data_BUS_READ = 32'h1DAA;
		#200 RST = 1;

        #7000 $stop;
	end
	
	
	
	always #10 CLK =~CLK;
		
endmodule 