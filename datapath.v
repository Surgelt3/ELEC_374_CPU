module datapath(
	input clk,
	input reset,
	
	//encoder inputs
	input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
	input HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout,
	
	input Read, IncPC,
	input AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
	
	//mux inputs
	input R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in, 
	input HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, 
	input [31:0] IN, 
	output [31:0] BusMuxOut, PC
);

	wire [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;
	wire [31:0] HI, LO, ZHI, ZLO, IR, CSIGN, Y, MAR, MDR;

	wire [31:0] MDR_D;
	wire [63:0] ALU_C;
	
	wire [31:0] PC_PLUS_1;
	wire [31:0] MAR_DATA, PC_DATA;
	wire [31:0] HI_DATA, LO_DATA;
	
	wire ZtoHL;
	
	bus b(
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
		HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout,INout, Cout, Yout, MARout,
		R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, 
		HI, LO, ZHI, ZLO, PC, IR, MDR, IN, CSIGN, Y, MAR, 
		BusMuxOut
	);


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
	
	mux_2_1 PC_mux(BusMuxOut, PC_PLUS_1, IncPC, PC_DATA);
	register RegPC(.clk(clk), .clr(reset), .D(PC_DATA), .write_enable(PCin), .Q(PC));
	register RegIR(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(IRin), .Q(IR));
	register RegY(.clk(clk), .clr(reset), .D(BusMuxOut), .write_enable(Yin), .Q(Y));
	
	
	mux_2_1 MAR_mux(BusMuxOut, PC, IncPC, MAR_DATA);
	register RegMAR(.clk(clk), .clr(reset), .D(MAR_DATA), .write_enable(MARin), .Q(MAR));
	
		
	mux_2_1 MDMux(BusMuxOut, IN, Read, MDR_D);
	register RegMDR(.clk(clk), .clr(reset), .D(MDR_D), .write_enable(MDRin), .Q(MDR));
		
	alu alu_32 (Y, BusMuxOut, {NOT, NEG, ROL, ROR, SHL, SHRA, SHR, DIV, MUL, SUB, ADD, OR, AND}, ALU_C);
	register RegZHI (.clk(clk), .clr(reset), .D(ALU_C[63:32]), .write_enable(Zin), .Q(ZHI));
	register RegZLO (.clk(clk), .clr(reset), .D(ALU_C[31:0]), .write_enable(Zin), .Q(ZLO));
	
	assign ZtoHL = DIV | MUL;
	
	mux_2_1 HI_mux(BusMuxOut, ZHI, ZtoHL, HI_DATA);
	mux_2_1 LO_mux(BusMuxOut, ZLO, ZtoHL, LO_DATA);
	register RegHI(.clk(clk), .clr(reset), .D(HI_DATA), .write_enable(HIin), .Q(HI));
	register RegLO(.clk(clk), .clr(reset), .D(LO_DATA), .write_enable(LOin), .Q(LO));

						
		
	add_32 pc_add(
		.x(PC), .y(32'd1), .C0(32'd0),.S(PC_PLUS_1)
	);



endmodule
