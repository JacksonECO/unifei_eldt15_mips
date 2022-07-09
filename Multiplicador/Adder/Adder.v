module Adder(add1,add2,soma);
		input	[15:0] add1, add2;
		output [16:0] soma;
		
		assign soma = add1 + add2;

endmodule
