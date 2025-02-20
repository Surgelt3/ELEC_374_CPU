module alu(
	input [31:0] A, B,
	input [12:0] control, 
	output reg [63:0] C
);		

	wire [63:0] mul_wire;
	wire [31:0] add_wire, sub_wire, div_wire, rem_wire;
	wire carry_add;
	
	always @(*) begin
		case (control) 
			13'b0000000000001: C = A & B;
			13'b0000000000010: C = A | B;
			13'b0000000000100: C = {carry_add, add_wire};
			13'b0000000001000: C = sub_wire;
			13'b0000000010000: C = mul_wire;
			13'b0000000100000: C = {rem_wire, div_wire};
			13'b0000001000000: C = A >> B;
			13'b0000010000000: C = A >>> B;
			13'b0000100000000: C = A << B;
			13'b0001000000000: C = (A>>B) | (A<<32-B);
			13'b0010000000000: C = (A<<B) | (A>>32-B);
			13'b0100000000000: C = ~B + 1'b1;
			13'b1000000000000: C = ~B;
		endcase
	end
	
	
	div div_unit(
		.Q(A), .M(B),
		.remainder(rem_wire), .quotient(Div_wire)
	);

	add_32 sub_unit(
		.x(A), .y(~B+1'b1), 
		.C0(1'b0), 
		.S(sub_wire)
	);


	add_32 add_unit(
		.x(A), .y(B), 
		.C0(1'b0), 
		.C32(carry_add), 
		.S(add_wire)
	);

	mul mul_unit(
		A, B,
		mul_wire
	);

endmodule
