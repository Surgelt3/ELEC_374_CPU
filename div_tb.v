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
		for (j=128; j < {32{1'b1}}; j = j+32'd567) begin
			x = 32'd1345;
			y = j;
			#1;
		end
		#2560 $stop;
	end


endmodule