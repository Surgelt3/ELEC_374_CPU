module add_1(
	input x, y, c,
	output S, G, P
);

always @(*) begin
	S = x^y^c;
	G = x & y;
	P = x | y;
end

endmodule

