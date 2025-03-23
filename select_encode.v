module select_encode(
	input Gra, Grb, Grc, Rin, Rout, BAout,
	input [31:0] data,
	output [15:0] regin, regout,
	output [31:0] C_sign_extended
);
	
	wire [3:0] a, b, c, d;
	wire [15:0] decoder_out;
	assign a = data[26:23] & {32{Gra}};
	assign b = data[22:19] & {32{Grb}};
	assign c = data[18:15] & {32{Grc}};
	assign d = a | b | c;
	assign decoder_out = 1 << d;
	
	assign regin = decoder_out & {32{Rin}};
	assign regout = decoder_out & {32{(Rout | BAout)}};
	
	assign C_sign_extended = {{13{data[18]}}, data[18:0]};
	
endmodule
