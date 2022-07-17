module ADDRDecoding
    #(
        // Regra: A memória de dados tem 1kWord alocados a partir de Número do grupo * 500h
        
        // Grupo 15
        // 500h = 1280
        // 15 * 1280 = 19200
        // 19200 + 1024 (1k) = 20224

        parameter inf = 32'h4b00, // decimal = 19200
        parameter sup = 32'h4f00 // decimal = 20224
    )
    (
        input [31:0] ADDR, 
        output reg CS
    );
	
	always @(*) begin
		if ((ADDR >= inf) && (ADDR < sup)) begin
			CS <= 1'b0; // Acesso a memória Interna
		end
		
		else begin
			CS <= 1'b1; // Acessa a memória Externa
		end	
	end
endmodule