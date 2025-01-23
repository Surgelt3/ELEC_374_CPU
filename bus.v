module bus(
	//encoder inputs
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
	input HIout, LOout, Zhighout, Zlowout, PCout, MDRout, Read, 
	
	//mux inputs
	input [31:0] R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, 
	input [31:0] HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, Mdatain, 
	
	output [31:0] out
	
);
	
	wire [4:0] s

	// 32:5 encoder
	encoder32_5 enc(
		.in({R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,HIout, LOout, Zhighout, Zlowout, PCout, MDRout, Read}), 
		.out(s)
	);
	
	mux32_1 mux(
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, Mdatain,
		sel,
		out
	);
	
	

endmodule
