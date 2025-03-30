module core (
		input clk, reset,
		input [31:0] IN_unit_input, 
		inout [31:0] BusMuxIn_MDR, OUT_MDR,
		output Read, write_mem, 
		output [31:0] MAR, OUT_unit_output
);
	
	wire [31:0] CSIGN, IR;
	wire R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in;
	wire R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out,R5out, R4out, R3out, R2out, R1out, R0out;
	
	wire BAout;
	wire IncPC;
	wire HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout;
	wire HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin;
	wire AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT;
	wire CON_RESET;
	
	control_unit cntrl_unit(
		clk, reset,
		IR,
		Read, IncPC, 
		HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout, 
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
		AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		write_mem,
		CON_RESET,
		BAout,
		{R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in}, 
		{R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out,R5out, R4out, R3out, R2out, R1out, R0out},
		CSIGN
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
