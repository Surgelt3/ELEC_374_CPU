module branch(
	input[31:0] ir, 
	input[31:0] bus,
	output out
);
	
	
	wire [3:0] dec_out;
	wire zr_cond, nzr_cond, pos_cond, neg_cond;
	
	assign dec_out = 1 << ir[20:19];
	
	assign zr_cond =  ~bus[31:0] & dec_out[0];
	assign nzr_cond = bus[31:0] & dec_out[1];
	assign pos_cond = ~bus[31] & dec_out[2];
	assign neg_cond = bus[31] & dec_out[3];
	assign out = zr_cond | nzr_cond | pos_cond | neg_cond;
	
endmodule
