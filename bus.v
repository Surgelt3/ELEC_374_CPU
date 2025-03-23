module bus(
	//encoder inputs
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
	input HIout, LOout, Zhighout, Zlowout, PCout, MDRout, INout, Cout, Yout, MARout,
	
	//mux inputs
	input [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, 
	input [31:0] HI, LO, ZHI, ZLO, PC, MDR, IN, CSIGN, Y, MAR, 
	
	
	output [31:0] out
	
);
	
	wire [4:0] sel;

	// 32:5 encoder
	encoder32_5 enc(
		.in({6'b0, MARout, Yout, Cout, INout, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out}), 
		.out(sel)
	);

	mux32_1 mux(
		.in0(R0), .in1(R1), .in2(R2), .in3(R3), .in4(R4), .in5(R5), .in6(R6), .in7(R7), .in8(R8), .in9(R9), .in10(R10), .in11(R11), .in12(R12), .in13(R13), .in14(R14), .in15(R15), .in16(HI), .in17(LO), .in18(ZHI), .in19(ZLO), .in20(PC), .in21(MDR), .in22(IN), .in23(CSIGN), .in24(Y), .in25(MAR),
		.sel(sel),
		.out(out)
	);
	
	

endmodule
