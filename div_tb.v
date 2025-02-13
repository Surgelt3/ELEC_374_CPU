module div_tb(

);
	reg [31:0] x, y;
	wire [31:0] R, S;
	reg [31:0] i, j;
	
	
	div div32(
		x, y,
		R, S
	);
	
	initial begin
			x = -32'd23;
			y = 32'd5;
		#100
			x = 32'd23;
			y = -32'd5;
		#100
			x = -32'd23;
			y = -32'd5;
		#100
			x = 32'd23;
			y = 32'd5;
		#100
		$stop;
	end


endmodule