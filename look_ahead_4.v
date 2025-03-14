module look_ahead_4(
	input G0, P0, G1, P1, G2, P2, G3, P3, C0,
	output C1, C2, C3, C4, G_1, P_1
);

	assign C1 = G0 | P0&C0;
	
	assign C2 = G1 | P1&C1;
	
	assign C3 = G2 | P2 & C2;

	assign C4 = G3 | P3 & C3;
	
	assign G_1 = G3 + P3&P2 + P3&P2&G1 + P3&P2&P1&G0;
	assign P_1 = P3&P2&P1&P0&C0;

endmodule
