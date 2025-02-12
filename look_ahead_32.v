module look_ahead_32 (
	input C0, G_0, P_0, G_1, P_1, G_2, P_2, G_3, P_3, G_4, P_4, G_5, P_5, G_6, P_6, G_7, P_7, 
	output C4, C8, C12, C16, C20, C24, C28, C32
);

	assign C4 = G_0 | (P_0 & C0);
	assign C8 = G_1 | (P_1 & (G_0 | (P_0 & C0)));
	assign C12 = G_2 | (P_2 & (G_1 | (P_1 & (G_0 | (P_0 & C0)))));
	assign C16 = G_3 | (P_3 & (G_2 | (P_2 & (G_1 | (P_1 & (G_0 | (P_0 & C0)))))));
	assign C20 = G_4 | (P_4 & (G_3 | (P_3 & (G_2 | (P_2 & (G_1 | (P_1 & (G_0 | (P_0 & C0)))))))));
	assign C24 = G_5 | (P_5 & (G_4 | (P_4 & (G_3 | (P_3 & (G_2 | (P_2 & (G_1 | (P_1 & (G_0 | (P_0 & C0)))))))))));
	assign C28 = G_6 | (P_6 & (G_5 | (P_5 & (G_4 | (P_4 & (G_3 | (P_3 & (G_2 | (P_2 & (G_1 | (P_1 & (G_0 | (P_0 & C0)))))))))))));
	assign C32 = G_7 | (P_7 & (G_6 | (P_6 & (G_5 | (P_5 & (G_4 | (P_4 & (G_3 | (P_3 & (G_2 | (P_2 & (G_1 | (P_1 & (G_0 | (P_0 & C0)))))))))))))));


endmodule
