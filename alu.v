module alu(
	input [31:0] A, B,
	input control
	output [31:0] C
);

	always @(*) begin
		case (control) 
			: C = A & B;
			: C = A | B;
			: C = ~ A;
		endcase
	end

endmodule
