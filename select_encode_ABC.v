module select_encode_ABC(
	input Gra, Grb, Grc, 
	input Rin,
	input	RoutA, RoutB, RoutC,
	input BAout,
	input [1:0] RinSel,
	input [31:0] data,
	output [15:0] regin, regout_A, regout_B, regout_C,
	output [31:0] C_sign_extended
);
	
	wire [3:0] a, b, c;
	wire [15:0] decoder_outA, decoder_outB, decoder_outC, decoder_out;
	assign a = data[26:23] & {32{Gra}};
	assign b = data[22:19] & {32{Grb}};
	assign c = data[18:15] & {32{Grc}};
	
	assign decoder_outA = 1 << a;
	assign decoder_outB = 1 << b;
	assign decoder_outC = 1 << c;

	
	mux_3_1 se_mux (
		.in0(decoder_outA), .in1(decoder_outB), .in2(decoder_outC), .sel(RinSel), .out(decoder_out)
	);
	
	assign regin = decoder_out & {32{Rin}};
	
	assign regout_A = decoder_outA & {32{(RoutA | BAout)}};
	
	assign regout_B = decoder_outB & {32{(RoutB | BAout)}};

	assign regout_C = decoder_out & {32{(RoutC | BAout)}};

	
	assign C_sign_extended = {{13{data[18]}}, data[18:0]};
	
endmodule
