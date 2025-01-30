module add_32_tb(

);
	reg [31:0] x, y;
	wire [31:0] S;
	reg C0;
	reg [31:0] i, j;
	
	
	add_32 add32(
		x, y,
		C0, 
		S
	);
	
	initial begin
		C0=1'b0;
		for (j=128; j < {32{1'b1}}; j = j+32'd567) begin
			x = 32'd1345;
			y = j;
			#1;
		end
		#2560 $stop;
	end


endmodule
