module shift_right_arithmetic (
	input signed [31:0] val, 
	input [31:0] shift,
	output reg [31:0] out
);

	always @(*) begin
		out = val >>> shift;
	end

endmodule
