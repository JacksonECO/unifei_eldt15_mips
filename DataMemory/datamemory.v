/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module datamemory 
    #(
        // 1k de word de 32 bits
        parameter data_WIDTH = 32,
        parameter ADDR_WIDTH = 10
    )
    (
        input [31:0] ADDR,
        input RW_RD,	// RW_RD = 0 -> escrita => RW_RD = 1 -> leitura;
        input CLK,
        input [data_WIDTH-1:0] din,
        output reg [data_WIDTH-1:0] dout
    );

	// [32] X [1024]
	reg [data_WIDTH-1:0] memData [0:(1<<ADDR_WIDTH)-1];
	
	initial begin
		memData[2] = 32'd2001;
		memData[3] = 32'd4001;
		memData[4] = 32'd5001;
		memData[5] = 32'd3001;
	end
	
	
	always@(posedge CLK) begin
		if (~RW_RD) // ~RW_RD = escrita
			memData[ADDR-32'h4b00] <= din;
		else 		// RW_RD = leitura
			dout <= memData[ADDR-32'h4b00];
	end
endmodule
