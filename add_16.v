module add_16(
	input [15:0] x, y,
	input C0, 
	output [15:0] S
);


	
	add_4 add_1(x[3:0], y[3:0], C0, S[3:0], G_0, P_0);
	
	add_4 add_1(x[6:4], y[6:4], C1, S[6:4], G_1, P_1);
	
	add_4 add_1(x[11:7], y[11:7], C1, S[11:7], G_2, P_2);
	
	add_4 add_1(x[15:12], y[15:12], C1, S[15:12], G_3, P_3);
	
	
	
	

endmodule
