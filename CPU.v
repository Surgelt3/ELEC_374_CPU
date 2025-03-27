module CPU(
	input clk, reset,
	
	input HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout,
	
	input Read, IncPC,
	input AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
	input Gra, Grb, Grc, Rin, Rout, BAout,
	input HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
	input read_mem, write_mem,
	input CON_RESET,
	input PCSave,
	input [31:0] IN_unit_input, 
	output [31:0] OUT_unit_output
);

	wire [31:0] BusMuxOut, MAR, BusMuxIn_MDR;
	wire [31:0] OUT_MDR;
	core c(
		clk, reset,
		HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout,
		Read, IncPC,
		AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		Gra, Grb, Grc, Rin, Rout, BAout,
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
		CON_RESET,
		PCSave,
		IN_unit_input, 
		BusMuxIn_MDR, OUT_MDR,
		BusMuxOut, MAR, OUT_unit_output
	);

	
	
	ram mem_ram(
		.clk(clk), .reset(reset), .read(Read), .write(write_mem), .addr(MAR[8:0]),
		.data_in(BusMuxIn_MDR), .data_out(OUT_MDR)
	);
	
	
endmodule
	