module shift_left (
	input [31:0] val, shift,
	output reg [31:0] out
);

	always @(*) begin
		out = val << shift;
	end

endmodule
