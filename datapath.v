module datapath(
	input clk,
	input reset,
	
		//encoder inputs
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
	input HIout, LOout, Zhighout, Zlowout, PCout, MDRout, Read, 
	
	//mux inputs
	input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, 
	input HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, 
	input [31:0] Mdatain, 

);

	wire [31:0] BusMuxOut;
	
	reg [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;
	reg [31:0] PC, IR, Y, Z, MAR, HI, LO, MDR;

	register RegR0(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R0in), .Q(R0));
	register RegR1(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R1in), .Q(R1));
	register RegR2(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R2in), .Q(R2));
	register RegR3(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R3in), .Q(R3));
	register RegR4(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R4in), .Q(R4));
	register RegR5(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R5in), .Q(R5));
	register RegR6(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R6in), .Q(R6));
	register RegR7(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R7in), .Q(R7));
	register RegR8(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R8in), .Q(R8));
	register RegR9(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R9in), .Q(R9));
	register RegR10(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R10in), .Q(R10));
	register RegR11(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R11in), .Q(R11));
	register RegR12(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R12in), .Q(R12));
	register RegR13(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R13in), .Q(R13));
	register RegR14(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R14in), .Q(R14));
	register RegR15(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(R15in), .Q(R15));
	
	register RegPC(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(PCin), .Q(PC));
	register RegIR(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(IRin), .Q(IR));
	register RegY(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(Yin), .Q(Y));
	register RegZ(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(Zin), .Q(Z));
	register RegMAR(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(MARin), .Q(MAR));
	register RegHI(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(HIin), .Q(HI));
	register RegLO(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(LOin), .Q(LO));
	
	register RegMDR(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(MDRin), .Q(MDR));
	
	bus b(
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
		HIout, LOout, Zhighout, Zlowout, PCout, MDRout, Read,
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, 
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, Mdatain, 
		BusMuxOut
	);

endmodule
