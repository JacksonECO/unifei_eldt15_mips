`timescale 1ns/10ps 

module control_TB();

    reg [31:0] instruction;
    wire [31:0] out;

    control DUT(
        .instruction(instruction),
        .out(out)
    );

    initial begin
        //					 |group+1| rs  | rt  |   offse (16b)  | LW
        #20 instruction = 32'b_010000_00000_00001_0000000000000000;

        //					 |group+1| rs  | rt  |   offse (16b)  | LW
        #20 instruction = 32'b_010000_00000_00010_0000000000000001;


        //			          |group | rs  | rt  | rd  | 10  | command = 36 | ADD
        #20 instruction = 32'b_001111_00001_00010_00011_01010_100000;

        //			          |group | rs  | rt  | rd  | 10  | command = 34 | SUB
        #20 instruction = 32'b_001111_00001_00010_00011_01010_100010;

        //			          |group | rs  | rt  | rd  | 10  | command = 50 | MUL
        #20 instruction = 32'b_001111_00001_00010_00011_01010_110010;

        //			          |group | rs  | rt  | rd  | 10  | command = 36 | AND
        #20 instruction = 32'b_001111_00001_00010_00011_01010_100100;

        //			          |group | rs  | rt  | rd  | 10  | command = 37 | OR
        #20 instruction = 32'b_001111_00001_00010_00011_01010_100101;


        //					 |group+2| rs  | rt  |   offse (16b)  | LW
        #20 instruction = 32'b_010001_00000_00011_0000000000000011;
    end

endmodule

// {[31:24], extend_ctrl [23], mul_ctrl [22], rs [21:17], rt [16:12], rd [11:7], wr_reg_file [6], wr [5], mux_wb [4], mux_reg [3], mux_alu [2], alu_ctrl [1:0]};