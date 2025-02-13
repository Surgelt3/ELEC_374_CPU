module mul_tb(

);

	reg [31:0] M, Q;
	wire [63:0] P;
	reg [31:0] i, j;
	
	mul mul_32(
		M, Q,
		P
	);
	
	initial begin
			M = -32'd23;
			Q = 32'd5;
		#100
			M = 32'd23;
			Q = -32'd5;
		#100
			M = -32'd23;
			Q = -32'd5;
		#100
			M = 32'd23;
			Q = 32'd5;
		#100
		$stop;
	end



endmodule
