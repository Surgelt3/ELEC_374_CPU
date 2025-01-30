module add_4 (
input [3:0] A, B,
input C0,
output [3:0] S,
output G, P, C4
);	
	
	wire G0, P0, G1, P1, G2, P2, G3, P3;
	wire C1, C2, C3;
	
	add_1 adder_1(A[0], B[0], C0, S[0], G0, P0);
	
	add_1 adder_2(A[1], B[1], C1, S[1], G1, P1);
	
	add_1 adder_3(A[2], B[2], C2, S[2], G2, P2);

	add_1 adder_4(A[3], B[3], C3, S[3], G3, P3);
	
	look_ahead_4 la4(G0, P0, G1, P1, G2, P2, G3, P3, C0, C1, C2, C3, C4, G, P);

endmodule
