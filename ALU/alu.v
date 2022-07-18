module alu (
		input 	  [31:0] data1, data2,
		input 	  [1:0] sel,
		output reg signed [31:0] out
	);

		always @(*) begin
			case(sel)
				2'b00: out <= data1 + data2; // Soma
				2'b01: out <= data1 - data2; // Subtração
				2'b10: out <= data1 & data2; // AND
				2'b11: out <= data1 | data2; // OR
			endcase			
		end

endmodule 
