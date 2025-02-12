module add_pc(
	input [31:0] x,
	input IncPC,
	output reg [31:0] PC
);

wire [31:0] S;

always @(IncPC) begin
	PC <= S;
end

add_32 pc_add(
		.x(x), .y(32'd1),.S(S)
);

endmodule
