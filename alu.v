module alu(
	input [31:0] A, B,
	input [12:0] control, 
	output reg [63:0] C
);		

	wire [63:0] mul_wire, div_wire;
	wire [31:0] add_wire, sub_wire, shr_wire, shra_wire, shl_wire;
	wire carry_add;
	
	always @(*) begin
		case (control) 
			13'b0000000000001: C = A & B;
			13'b0000000000010: C = A | B;
			13'b0000000000100: C = {carry_add, add_wire};
			13'b0000000001000: C = sub_wire;
			13'b0000000010000: C = mul_wire;
			13'b0000000100000: C = div_wire;
			13'b0000001000000: C = shr_wire;
			13'b0000010000000: C = shra_wire;
			13'b0000100000000: C = shl_wire;
			13'b0001000000000: C = (A>>(B%32)) | (A<<(32-(B%32)));
			13'b0010000000000: C = 32'hffffffff & (A<<(B%32)) | (A>>(32-(B%32)));
			13'b0100000000000: C = 32'hffffffff & ~B + 1'b1;
			13'b1000000000000: C = 32'hffffffff & ~B;
		endcase
	end
	
	shift_right shiftR(A, B, shr_wire);
	
	shift_right_arithmetic shiftRA(A, B, shra_wire);
	
	shift_left shiftL (A, B, shl_wire);
	
	
	
	div div_unit(
		.Q(A), .M(B),
		.remainder(div_wire[63:32]), .quotient(div_wire[31:0])
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
