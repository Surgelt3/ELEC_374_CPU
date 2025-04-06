module core (
		input clk, reset, stop,
		input [31:0] IN_unit_input, 
		inout [31:0] BusMuxIn_MDR, OUT_MDR,
		output Read, write_mem, run, 
		output [31:0] MAR, OUT_unit_output
);
	
	wire [31:0] CSIGN, IR;
	wire R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in;
	wire R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out,R5out, R4out, R3out, R2out, R1out, R0out;
	
	wire [15:0] regout_A, regout_B, regout_C;
	wire [1:0] RinSel;
	
	wire BAout;
	wire IncPC;
	wire HIoutA, LOoutA, ZhighoutA, ZlowoutA, PCoutA, IRoutA, MDRoutA, INoutA, CoutA, YoutA, MARoutA;
	wire HIoutB, LOoutB, ZhighoutB, ZlowoutB, PCoutB, IRoutB, MDRoutB, INoutB, CoutB, YoutB, MARoutB;
	wire HIoutC, LOoutC, ZhighoutC, ZlowoutC, PCoutC, IRoutC, MDRoutC, INoutC, CoutC, YoutC, MARoutC;
	wire HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin;
	wire AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT;
	wire CON_RESET, Br;
	
	
	control_unit cntrl_unit(
		clk, reset, stop,
		IR,
		Read, IncPC, 
		HIoutA, LOoutA, ZhighoutA, ZlowoutA, PCoutA, IRoutA, MDRoutA, INoutA, CoutA, YoutA, MARoutA, 
		HIoutB, LOoutB, ZhighoutB, ZlowoutB, PCoutB, IRoutB, MDRoutB, INoutB, CoutB, YoutB, MARoutB, 
		HIoutC, LOoutC, ZhighoutC, ZlowoutC, PCoutC, IRoutC, MDRoutC, INoutC, CoutC, YoutC, MARoutC, 
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
		AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		write_mem,
		CON_RESET, Br,
		BAout,
		run,
		RinSel,
		{R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in}, 
		regout_A, regout_B, regout_C,
		CSIGN
	);
		

	
	datapath dp(
		clk, reset,
		//encoder inputs
		regout_A, regout_B, regout_C,
		HIoutA, LOoutA, ZhighoutA, ZlowoutA, PCoutA, IRoutA, MDRoutA, INoutA, CoutA, YoutA, MARoutA, 
		HIoutB, LOoutB, ZhighoutB, ZlowoutB, PCoutB, IRoutB, MDRoutB, INoutB, CoutB, YoutB, MARoutB, 
		HIoutC, LOoutC, ZhighoutC, ZlowoutC, PCoutC, IRoutC, MDRoutC, INoutC, CoutC, YoutC, MARoutC, 		
		Read, IncPC, RinSel,
		AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		//mux inputs
		R15in, R14in, R13in, R12in, R11in, R10in, R9in, R8in, R7in, R6in,R5in, R4in, R3in, R2in, R1in, R0in, 
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
		BAout,
		CON_RESET, Br,
		IN_unit_input, CSIGN,
		BusMuxIn_MDR, OUT_MDR, MAR, IR, OUT_unit_output
	);

	
	
endmodule
