module register(
	input clk,
	input clr,
	input [31:0] D,
	input write_enable,
	output reg [31:0] Q
);

	always @(posedge clk)
		if (clr)
			Q = 0;
		else begin
			if (write_enable)
				Q = D;
		end
			
	end
	



endmodule
