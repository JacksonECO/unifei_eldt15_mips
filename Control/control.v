/*
Eduardo Augusto Ribeiro Duenas - 2017011086 - Turma 2
Jackson Galdino Da Silveira    - 2018010136 - Turma 1
Jean Tan Li                    - 2018000069 - Turma 1
*/

module control(
	input [31:0] instruction,
	output [31:0] out
);

reg [1:0] alu_ctrl; // 0: add, 1: sub, 2: and, 3: or
reg mul_ctrl; // Ativa o multiplicador
reg mux_alu; // Ativa a ALU
reg mux_reg;
reg mux_wb; // Ativa o write back (salva dados no registrador)
reg wr;
reg wr_reg_file; 
reg [4:0] rs; // Primeiro registrador Fonte
reg [4:0] rt; // Segundo registrador Fonte para instruções tipo R 
              // Ou Registro destino para instruções tipo I
reg [4:0] rd; // Registrador destino para Instruções tipo R
reg extend_ctrl; // Ativa o extender - 0: Instrução tipo R, 1: Instrução tipo I

assign out = {{8'b0},{extend_ctrl},{mul_ctrl},{rs},{rt},{rd},{wr_reg_file},{wr},{mux_wb},{mux_reg},{mux_alu},{alu_ctrl}};

always @(*) begin
	rs <= instruction[25:21];
	rt <= instruction[20:16];
	wr <= 0;
	alu_ctrl <= 0;
	mux_alu <= 1;
	rd <= 0;
	mux_wb <= 0;
	wr_reg_file <= 0;
	mux_reg <= 0;
	extend_ctrl <= 0;
	mul_ctrl <= 0;

	case(instruction[31:26])
		6'd15: // Instrução do tipo R
		begin
			case(instruction[5:0])
				6'd32: // Adição / ADD
                    begin
                        alu_ctrl <= 2'b00;
                        mux_alu <= 1;
                        mul_ctrl <= 0;
                    end
				6'd34: // Subtração / SUB
                    begin
                        alu_ctrl <= 2'b01;
                        mux_alu <= 1;
                        mul_ctrl <= 0;
                    end	
				6'd50: // Multiplicação / MUL
                    begin
                        mux_alu <= 0;
                        mul_ctrl <= 1;
                    end	
				6'd36: // And &
                    begin
                        alu_ctrl <= 2'b10;
                        mux_alu <= 1;
                        mul_ctrl <= 0;
                    end	
				6'd37: // Or |
                    begin
                        alu_ctrl <= 2'b11;
                        mux_alu <= 1;
                        mul_ctrl <= 0;
                    end	
			endcase
			rd <= instruction[15:11];
			mux_reg <= 0;
			mux_wb <= 0;
			wr <= 1;
			extend_ctrl <= 0;
			wr_reg_file <= 1;
		end

		// Instrução do tipo I
		6'd16: // Load Word / LW
            begin
                mux_reg <= 1;
                mux_wb <= 1;
                alu_ctrl <= 2'b00;
                mux_alu <= 1;
                wr_reg_file <= 1;
                wr <= 1;
                rd <= rt;
                mul_ctrl <= 0;
                extend_ctrl <= 1;
            end
			
		6'd17: // Store Word / SW
            begin
                mux_reg <= 1;
                mux_wb <= 1;
                alu_ctrl <= 2'b00;
                mux_alu <= 1;
                wr_reg_file <= 0;
                wr <= 0;
                rd <= 5'b0;
                mul_ctrl <= 0;
                extend_ctrl <= 1;
            end
	endcase
end


endmodule