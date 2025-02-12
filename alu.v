module alu(
	input [31:0] A, B,
	input [12:0] control, 
	output reg [63:0] C
);		

	wire [63:0] mul_wire, add_wire, sub_wire, div_wire;
	always @(*) begin
		case (control) 
			13'b0000000000001: C = A & B;
			13'b0000000000010: C = A | B;
			13'b0000000000100: C = add_wire;
			13'b0000000001000: C = sub_wire;
			13'b0000000010000: C = mul_wire;
			13'b0000000100000: C = div_wire;
			13'b0000001000000: C = A >> B;
			13'b0000010000000: C = A >>> B;
			13'b0000100000000: C = A << B;
			13'b0001000000000: C = (A>>B) | (A<<32-B);
			13'b0010000000000: C = (A<<B) | (A>>32-B);
			13'b0100000000000: C = ~A + 1'b1;
			13'b1000000000000: C = ~A;
		endcase
	end
	

	add_32 sub_unit(
		A, ~B+1'b1, 
		1'b0,
		sub_wire
	);


	add_32 add_unit(
		A, B, 
		1'b0,
		add_wire
	);

	mul mul_unit(
		A, B,
		mul_wire
	);

endmodule
