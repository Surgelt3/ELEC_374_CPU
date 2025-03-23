module tmp_tb(
	
);

	
	reg [31:0] ir, data;
	wire out;

	
	branch br(
		ir, 
		data,
		out
	);
	
	
	initial begin
			
			ir = 32'h9880001B;
			data = 32'd0;
			
	end	
		

endmodule
