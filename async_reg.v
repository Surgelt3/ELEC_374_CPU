module async_reg (
	input clr,
	input write_enable,
	input [31:0] D,
	output reg [31:0] Q
);

	always @(*) begin
		if (clr)
			Q = 32'd0;
		else if (write_enable)
			Q = D;
	end

endmodule
