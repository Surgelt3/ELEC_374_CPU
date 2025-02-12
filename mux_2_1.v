module mux_2_1(
	input [31:0] A, B,
	input sel,
	output [31:0] D
);
	assign D = sel ? B:A;


endmodule
