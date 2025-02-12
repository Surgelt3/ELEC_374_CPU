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
		x = 32'd1345;
		y = j;
		#1;
		#2560 $stop;
	end
endmodule
