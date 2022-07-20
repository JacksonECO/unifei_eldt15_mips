/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module multiplicador(Produto, Idle, Done, clk, rst, St, Multiplicador, Multiplicando);
		output	[31:0] Produto;
		output	Idle, Done;
		input 	St, clk, rst; 
		input	[15:0] Multiplicador, Multiplicando;
		
		wire	K, M, Load, Sh, Ad;
		wire	[16:0]soma_out;
		wire	[15:0]soma_in;

		//assign Produto = Multiplicador * Multiplicando;

		
		 assign soma_in = Produto[31:16];
		
		 Counter	counter_mult(.entrada(Load), .clk(clk), .rst(rst), .saida(K));
		 ACC		acc_mult(.clk(clk),.rst(rst),.Load(Load),.Sh(Sh),.Ad(Ad),.lsb(Multiplicador),.msb(soma_out),.saida(Produto), .M(M));
		 Adder		adder_mult(.add1(Multiplicando), .add2(soma_in), .soma(soma_out));
		 Control	control_mult(.clk(clk), .St(St), .rst(rst), .M(M), .K(K), .Idle(Idle), .Done(Done), .Load(Load), .Sh(Sh), .Ad(Ad));
		
endmodule
