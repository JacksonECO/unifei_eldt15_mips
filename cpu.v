module cpu(
        input CLK, Rst,
        input [31:0] Data_BUS_READ,
        output [31:0] Data_BUS_WRITE,
        output CS,
        output WR_RD,
        output [31:0] ADDR
    ); 
	
	
	
	//-- Wires PLL
	wire locked;
	wire CLK_SYS, CLK_MUL;
	
	//-- Wires Instruction Fetch
	wire [9:0] PcPointer;
	wire [31:0] InstructionOut;

	//-- Wires Instruction Decode
	wire [31:0] ControlOut;
	wire [31:0] ExtendOut;
	wire [31:0] ImmediateOut;
	wire [31:0] CTRL1Out;
	
	//-- Wires execute
    wire Idle, Done;

	wire [31:0] Mux1Out, Mux2Out, Mux3Out; // Saidas dos mux
	wire [31:0] ALUOut;
	wire [31:0] D1Out;
	wire [31:0] B1Out;
	wire [31:0] CTRL2Out;
	wire [31:0] MultOut;
	wire [31:0] ARegFileOut;
	wire [31:0] BRegFileOut;
	
	//-- Wires Memory
	wire ADDROut;
	wire [31:0] MOut;
	wire [31:0] D2Out;
	wire [31:0] CTRL3Out;
	wire [31:0] dataMemOut;
	// wire [31:0] BusOut;
	// wire [31:0] ADDR;
	
	
	//-- Wires Write Back
	wire [31:0] writeBack;
	
	
	//-- COMPOSIÇÃO DO SINAL DE CONTROLE
	// Controlout = {{8'b0},{rs},{rt},{rd},{wr_reg_file},{wr},{mux_wb},{mux_reg},{mux_alu},{alu_ctrl}};
	// {[31:24], extend_ctrl [23], mul_ctrl [22], rs [21:17], rt [16:12], rd [11:7], wr_reg_file [6], wr [5], mux_wb [4], mux_reg [3], mux_alu [2], alu_ctrl [1:0]};
	
	assign CS = ADDROut;
	assign Data_BUS_WRITE = B1Out;
	assign WR_RD = CTRL2Out[5];
	assign ADDR = D1Out;
	
	//-- PLL
	PLL PLL(.areset(0),.inclk0(CLK),.c0(CLK_MUL),.c1(CLK_SYS),.locked(locked));

	
	//-- Instruction Fetch - Etapa 1
	pc pc1(.clk(CLK_SYS), .rst(Rst), .count(PcPointer));
	instructionmemory INST(.Addr(PcPointer), .Instruction(InstructionOut));
	
	
	//-- Intruction Decode - Etapa 2
	control ctrl(.instruction(InstructionOut), .out(ControlOut));
	extend ext1(.enable(Rst), .dataIn(InstructionOut[15:0]), .dataOut(ExtendOut));
	Register IMM(.clk(CLK_SYS), .rst(Rst), .D(ExtendOut), .Q(ImmediateOut));
	Register ctrlReg1(.clk(CLK_SYS), .rst(Rst), .D(ControlOut), .Q(CTRL1Out));
	
	
	//-- Execute - Etapa 3
	mux mux1(.data1(BRegFileOut), .data2(ImmediateOut), .sel(CTRL1Out[3]), .out(Mux1Out));
	mux mux2(.data1(MultOut), .data2(ALUOut), .sel(CTRL1Out[2]), .out(Mux2Out));
	multiplicador mult(.Multiplicando(ARegFileOut[15:0]),.Multiplicador(BRegFileOut[15:0]),
        .St(CTRL1Out[22]),.clk(CLK_MUL),.rst(Rst),.Produto(MultOut),.Idle(Idle),.Done(Done));
	alu alu(.data1(ARegFileOut), .data2(Mux1Out), .sel(CTRL1Out[1:0]), .out(ALUOut));
	Register regD1(.clk(CLK_SYS), .rst(Rst), .D(Mux2Out), .Q(D1Out));
	Register regB1(.clk(CLK_SYS), .rst(Rst), .D(BRegFileOut), .Q(B1Out));
	Register ctrlReg2(.clk(CLK_SYS), .rst(Rst), .D(CTRL1Out), .Q(CTRL2Out));
	
	
	//-- Memory - Etapa 4
	datamemory dataMem(.ADDR(D1Out), .RW_RD(CTRL2Out[5]), .CLK(CLK_SYS), .din(B1Out), .dout(dataMemOut));
	ADDRDecoding addr(.ADDR(D1Out), .CS(ADDROut));
    mux mux3(.data1(dataMemOut), .data2(Data_BUS_READ), .sel(ADDROut), .out(Mux3Out));
	Register regD2(.clk(CLK_SYS), .rst(Rst), .D(D1Out), .Q(D2Out)); //saida??
	Register regM(.clk(CLK_SYS), .rst(Rst), .D(Mux3Out), .Q(MOut));
	Register ctrlReg3(.clk(CLK_SYS), .rst(Rst), .D(CTRL2Out), .Q(CTRL3Out));
	
	//-- WriteBack  - Etapa 5
	mux mux4(.data1(D2Out), .data2(MOut), .sel(CTRL3Out[4]), .out(writeBack));
	registerfile regFile(.clk(CLK_SYS), .rst(Rst), .dataIn(writeBack), .rd(CTRL3Out[11:7]), .we(CTRL3Out[6]), .rs(ControlOut[21:17]),
         .rt(ControlOut[16:12]), .A(ARegFileOut), .B(BRegFileOut));
	
	
endmodule