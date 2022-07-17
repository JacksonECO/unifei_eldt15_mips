/* 
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1

Avaliação (responda em forma de comentários no módulo TOP MIPS_CPU):
Após a implementação e verificação do correto funcionamento do circuito, 
responda (respostas dentro do módulo MIPS_CPU como comentários):

a) Qual a latência do sistema?

Resp: A latência do sistema é de 5 ciclos de clock, que equivale a 599.245655 ns.

b) Qual o throughput do sistema?

Resp: O throughput  do sistema é de um período de clock, após o quinto ciclo,
que equivale a 119.849131 ns

c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer 
para o multiplicador e para o sistema? (Indique a FPGA utilizada)

Resp: A frequência máxima de operação do multiplicador seguindo o Time Quest Timing 
Analizer é de 283.69 MHz, já a do sistema é de __ MHz.A FPGA utilizada foi a CYCLONE IV
EP4CGX150DF31I7AD.

d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)

Resp: A FPGA utilizada foi a CYCLONE IV EP4CGX150DF31I7AD e a máxima frequência de 
operação do sistema é de 8.3438 MHz, que é um 34 avos da frêquencia máxima do multiplicador

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
em função do tempo.*/


module cpu (
        input  CLK, RST, 
        input  [31:0] Data_BUS_READ,
        output [31:0] ADDR, Data_BUS_WRITE,
        output CS, WR
    );

	wire CLK_SYS, CLK_MUL;
	wire [31:0] WriteBack;
	wire [9:0] wire_address;
	wire [31:0] wire_produto_out, wire_A, wire_B, wire_instruction, wire_D_out, wire_M_in, wire_reg_cs, wire_memory, wire_D_in, wire_alu, wire_mux_alu_in, wire_imm, wire_ctrl1, wire_ctrl2, wire_ctrl3, wire_ctrl4, wire_offset_ext;
	

    // Clock
    PLL PLL( 
        .areset(RST),
        .inclk0(CLK),
        .c0(CLK_MUL),
        .c1(CLK_SYS)
    );

    //Primeiro Estagio : Instruction Fetch 

    instructionmemory ProgramMemory (
        .Addr(wire_address),
        //.clk(CLK_SYS),
        .Instruction(wire_instruction)
    );

    pc PC (
        .rst(RST),
        .clk(CLK_SYS),
        .count(wire_address)
    );

    //Segundo Estagio : Instruction Decode

    registerfile RegisterFile (
        .dataIn(WriteBack),
        .we(wire_ctrl4[23]),
        .clk(CLK_SYS),
        .rst(RST),
        .rs(wire_ctrl1[14:10]),
        .rt(wire_ctrl1[9:5]),
        .rd(wire_ctrl4[4:0]), // Quinto Estagio
        .A(wire_A),
        .B(wire_B)
    );	

    control Control (
        .instruction(wire_instruction),  
        .out(wire_ctrl1)
    );

    extend Extend (
        .dataIn(wire_instruction[15:0]),
        .dataOut(wire_offset_ext),
        .enable(wire_ctrl1[20])
    );

    Register IMM (
        .rst(RST), 
        .clk(CLK_SYS),
        .D(wire_offset_ext),      
        .Q(wire_imm)	
    );

    Register CRTL1 (
        .rst(RST),
        .clk(CLK_SYS),
        .D({8'b0,wire_ctrl1}),      
        .Q(wire_ctrl2)	
    );

    //Terceiro Estagio : Execute

    mux Mux_Alu_In (
        .data1(wire_imm), //1
        .data2(wire_B), //0
        .sel(wire_ctrl2[19]),
        .out(wire_mux_alu_in)
    );

    Register CRTL2 (
        .rst(RST),
        .clk(CLK_SYS),
        .D(wire_ctrl2),      
        .Q(wire_ctrl3)	
    );

    alu ALU (
        .data1(wire_A),
        .data2(wire_mux_alu_in),
        .sel(wire_ctrl2[22:21]),
        .out(wire_alu)
    );

    mux Mux_Alu_Out (
        .data1(wire_alu), //1
        .data2(wire_produto_out), //0
        .sel(wire_ctrl2[18]),
        .out(wire_D_in)
    );

    multiplicador MUL(
        .St(wire_ctrl2[15]), 
        .clk(CLK_MUL), 
        .Produto(wire_produto_out),
        .Multiplicador(wire_A),
        .Multiplicando(wire_B)
    );

    Register D (
        .rst(RST),
        .clk(CLK_SYS),
        .D(wire_D_in),      
        .Q(ADDR)	
    );

    Register Reg_B2 (
        .rst(RST),
        .clk(CLK_SYS),
        .D(wire_B),      
        .Q(Data_BUS_WRITE)	
    );

    //Quarto Estagio : Memory

    assign WR = wire_ctrl3[16]; 
        
    datamemory DataMemory (
        .ADDR(ADDR[9:0]),
        .din(Data_BUS_WRITE),
        .RW_RD(wire_ctrl3[16]),
        .CLK(CLK_SYS),
        .dout(wire_memory)
    );

    mux Mux_Memory (
        .data1(Data_BUS_READ), //1
        .data2(wire_memory), //0
        .sel(wire_reg_cs), // ADDR Decoding
        .out(wire_M_in)
    );

    ADDRDecoding ADDRDecoding(
        .ADDR(ADDR),
        .CS(CS)
    );

    Register Reg_CS (
        .rst(RST),
        .clk(CLK_SYS),
        .D(CS),      
        .Q(wire_reg_cs)	
    );

    Register D2 (
        .rst(RST),
        .clk(CLK_SYS),
        .D(ADDR),      
        .Q(wire_D_out)	
    );

    Register CRTL3 (
        .rst(RST),
        .clk(CLK_SYS),
        .D(wire_ctrl3),      
        .Q(wire_ctrl4)	
    );

    // Quinto Estagio : Write Back

    mux Mux_WB (
        .data1(wire_M_in),  //1
        .data2(wire_D_out), //0
        .sel(wire_ctrl4[17]), // ADDR Decoding
        .out(WriteBack)
    );

endmodule
