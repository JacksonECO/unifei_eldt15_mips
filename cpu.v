/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1

Avaliação (responda em forma de comentários no módulo TOP MIPS_CPU):
Após a implementação e verificação do correto funcionamento do circuito, 
responda (respostas dentro do módulo MIPS_CPU como comentários):

a) Qual a latência do sistema?

Resp: A latência do sistema é de 5 ciclos de clock, que equivale a 714.285714 ns.

b) Qual o throughput do sistema?

Resp: O throughput  do sistema é de 32 bits por período de clock, após o quinto ciclo

c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer 
para o multiplicador e para o sistema? (Indique a FPGA utilizada)

Resp: A frequência máxima de operação do multiplicador seguindo o Time Quest Timing 
Analizer é de 302.11 MHz porém a frequência restritiva é de 250 MHz, já a do sistema é de 52.4 MHz. A FPGA utilizada foi a CYCLONE IV
EP4CGX150DF31I7AD.

d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)

Resp: A FPGA utilizada foi a CYCLONE IV EP4CGX150DF31I7AD e a máxima frequência de 
operação do sistema é de 8.88558824 MHz, que é um 34 avos da frequência máxima do multiplicador, porém por conta da frequência restritiva nosso sistema rodamos em 7 MHz 

e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente 
(se executada em sequência ininterrupta)? Por quê? O que pode ser feito para que a 
expressão seja calculada corretamente?

Resp: A instrução não é executada corretamente por conta do pipeline hazzard. 
Esse problema acontece por conta do write back, que adiciona um atraso na execução 
de algumas instruções, uma vez que a informação deve passar por toda pipeline para 
poder voltar para os registros. Se alguma instrução tentar utilizar uma informação de 
alguma operação que ainda não foi finalizada ou gravada no registerfile, ocorrerá um 
erro lógico por uso de um valor incorreto ou lixo de memória. Podemos resolver isso 
adicionando “bolhas”, ou seja, funções de espera, como NOP ou outra função que não 
interfira no funcionamento da pipeline.

f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas 
com metaestabilidade? Por que?

Resp: Não haverá metaestabilidade, pois o clk do Multiplicador será um múltiplo de clk 
da CPU. Por essa razão, não haverá defasagem entre os clocks e portanto não ocorrerá 
metaestabilidade.

g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, 
é eficiente em termos de velocidade? Por que?

Resp: A aplicação do multiplicador não é eficiente, pois demanda 34 pulsos de clock para 
executar a multiplicação e devolvê-la à pipeline, o que exige que o sistema seja pelo 
menos 34 vezes mais lento que a velocidade máxima do multiplicador, tornando-o 
ineficiente.

h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais 
rápido (frequência de operação maior). Para cada modificação sugerida, qual a nova 
latência e throughput do sistema?

Resp: Uma possível alteração, seria modificar a implementação do multiplicador a 
deixá-lo com menor latência consequentemente aumentando a velocidade máxima da 
pipeline. Essa alteração aumentaria a frequência máxima do clock do sistema, 
porém, não alteraria a latência e o throughput em função do número de clocks, 
mas diminuiria o período de clock, diminuindo a latência e aumentando o throughput 
em função do tempo.
*/

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
	(*keep=1*) wire CLK_SYS;
	(*keep=1*) wire CLK_MUL;
	
	//-- Wires Instruction Fetch
	(*keep=1*) wire [9:0] PcPointer;
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
	(*keep=1*) wire [31:0] B1Out;
	wire [31:0] CTRL2Out;
	wire [31:0] MultOut;
	wire [31:0] ARegFileOut;
	wire [31:0] BRegFileOut;
	
	//-- Wires Memory
	wire ADDROut;
	wire [31:0] MOut;
	wire [31:0] D2Out;
	(*keep=1*) wire [31:0] CTRL3Out;
	wire [31:0] dataMemOut;
	
	
	//-- Wires Write Back
	(*keep=1*) wire [31:0] writeBack;
	
	
	//-- COMPOSIÇÃO DO SINAL DE CONTROLE
	// Controle = {{8'b0},{extend_ctrl},{mul_ctrl},{rs},{rt},{rd},{wr_reg_file},{wr},{mux_wb},{mux_reg},{mux_alu},{alu_ctrl}};

	assign CS = ADDROut;
	assign Data_BUS_WRITE = B1Out;
	assign WR_RD = CTRL2Out[5];
	assign ADDR = D1Out;
	
	//-- PLL
	PLL PLL(.areset(0),.inclk0(CLK),.c0(CLK_MUL),.c1(CLK_SYS),.locked(locked));

	
	//-- Instruction Fetch - Etapa 1
	pc pc1(.clk(CLK_SYS), .rst(Rst), .count(PcPointer));
	instructionmemory INST(.Addr(PcPointer),.clk(CLK_SYS), .Instruction(InstructionOut));
	
	
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
	Register regM(.clk(CLK_SYS), .rst(Rst), .D({31'b0,ADDROut}), .Q(MOut));
    mux mux3(.data1(dataMemOut), .data2(Data_BUS_READ), .sel(MOut[0]), .out(Mux3Out));
	Register regD2(.clk(CLK_SYS), .rst(Rst), .D(D1Out), .Q(D2Out)); 
	Register ctrlReg3(.clk(CLK_SYS), .rst(Rst), .D(CTRL2Out), .Q(CTRL3Out));
	
	//-- WriteBack  - Etapa 5
	mux mux4(.data1(D2Out), .data2(Mux3Out), .sel(CTRL3Out[4]), .out(writeBack));
	registerfile regFile(.clk(CLK_SYS), .rst(Rst), .dataIn(writeBack), .rd(CTRL3Out[11:7]), .we(CTRL3Out[6]), .rs(ControlOut[21:17]),
         .rt(ControlOut[16:12]), .A(ARegFileOut), .B(BRegFileOut));
	
	
endmodule