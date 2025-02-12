module register #(parameter BUS_SIZE = 32)(
	input clk,
	input clr,
	input [BUS_SIZE-1:0] D,
	input write_enable,
	output reg [BUS_SIZE-1:0] Q
);

	always @(posedge clk) begin
		if (clr)
			Q <= 0;
		else begin
			if (write_enable)
				Q <= D;
		end
			
	end

endmodule
