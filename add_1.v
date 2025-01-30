module add_1(
	input x, y, c,
	output S, G, P
);

	assign S = x^y^c;
	assign G = x & y;
	assign P = x | y;


endmodule

