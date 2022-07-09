`timescale 1ns/10ps
module multiplicador_TB();
	
	reg St, rst, clk;
	reg[15:0] Multiplicador, Multiplicando;
	wire Idle, Done;
	wire [31:0] Produto;
	
	multiplicador DUT (
		.St(St),
		.rst(rst),
		.clk(clk),
		.Multiplicador(Multiplicador),
		.Multiplicando(Multiplicando),
		.Idle(Idle), 
		.Done(Done),
		.Produto(Produto)
	);

	initial begin
		forever #1.5 clk = ~clk;
	end
	
	initial begin
		St  = 0;
		rst = 0;
		clk   = 0;
		Multiplicador = 5000;
		Multiplicando = 6000;
		#3;
		St=1;
		rst=1;
		#3;
		St=0;
		rst=1;
		#96;
		#3;
		St=1;
		rst=1;
		Multiplicador = 13;
		Multiplicando = 10;
		#3;
		St=0;
		#96;
		#3;
		St=1;
		rst=1;
		Multiplicador = 65535;
		Multiplicando = 65535;
		#3;
		St=0;
		#96;
		#3;
		St=1;
		rst=1;
		Multiplicador = 3;
		Multiplicando = 15;
		#3;
		St=0;
		#96;
		#3;
		St=1;
		rst=1;
		Multiplicador = 1;
		Multiplicando = 1;
		#3;
		St=0;
		#96;
		
	end
	
	initial #4000 $stop;
	
	

endmodule