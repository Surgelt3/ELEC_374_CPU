module core (
		input clk, reset,
		input HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout,
		input Read, IncPC,
		input AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		input Gra, Grb, Grc, Rin, Rout, BAout,
		input HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin, 
		input CON_RESET,
		input PCSave,
		input [31:0] IN_unit_input, 
		inout [31:0] BusMuxIn_MDR, OUT_MDR,
		output [31:0] BusMuxOut, MAR, OUT_unit_output
);
	
	wire [31:0] CSIGN, IR;
	wire R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in;
	wire R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out,R5out, R4out, R3out, R2out, R1out, R0out;
	wire [31:0] IR_bus;
	
	assign IR_bus = PCSave ? 32'h04000000: IR;

	select_encode s_e(
		.Gra(Gra), .Grb(Grb), .Grc(Grc), 
		.Rin(Rin), .Rout(Rout), .BAout(BAout),
		.data(IR_bus),
		.regin({R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in}), 
		.regout({R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out,R5out, R4out, R3out, R2out, R1out, R0out}), 
		.C_sign_extended(CSIGN)
	);
	
	datapath dp(
		clk, reset,
		//encoder inputs
		R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out,R5out, R4out, R3out, R2out, R1out, R0out,
		HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout,
		
		Read, IncPC,
		AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		//mux inputs
		R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in, 
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
		BAout,
		CON_RESET,
		IN_unit_input, CSIGN,
		BusMuxIn_MDR, OUT_MDR,
		BusMuxOut, MAR, IR, OUT_unit_output
	);

	
	
endmodule
