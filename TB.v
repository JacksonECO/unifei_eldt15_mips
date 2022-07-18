`timescale 1ns/100ps

module TB();
	
	reg CLK;
	// reg CLK_SYS, CLK_MUL;
	reg RST;
	wire [31:0] ADDR, Data_BUS_WRITE;
	// reg  [31:0] writeBack;
	reg  [31:0] Data_BUS_READ;
	wire CS, WR;

    // Variáves externas
    reg [9:0] PcPointer;
    reg CLK_SYS, CLK_MUL;
    reg [31:0] B1Out, writeBack, CTRL3Out;
	
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
		$init_signal_spy("/TB/DUT/CTRL3Out","CTRL3Out",1);
		// $init_signal_spy("DUT/CLK_MUL","CLK_MUL",1);
		// $init_signal_spy("DUT/WriteBack","writeBack",1);
				
		CLK = 0;
		RST = 0;
		Data_BUS_READ = 32'h1DAA;
		#200 RST = 1;

        #1000 $stop;
	end
	
	
	
	always #6 CLK =~CLK;
		
endmodule 