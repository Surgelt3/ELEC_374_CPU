module datapath_tb_DIV(
	
);
	
	
	reg clk, reset;
	reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
	reg HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout, Read, IncPC;
	reg AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT;
	reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
	reg HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin;
	reg [31:0] IN;

	wire [31:0] BusMuxOut, PC;		

	
	datapath dp(
		clk, reset,
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
		HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout,
		Read, IncPC,
		AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin,
		IN,
		BusMuxOut, PC
	);
	
	parameter Default = 4'b0000, Init = 4'b0001, Reg_load1a = 4'b0010, Reg_load1b = 4'b0011, Reg_load2a = 4'b0100,
				Reg_load2b = 4'b0101, Reg_load3a = 4'b0110, Reg_load3b = 4'b0111, T0 = 4'b1000,
				T1 = 4'b1001, T2 = 4'b1010, T3 = 4'b1011, T4 = 4'b1100, Done = 4'b1101;
	reg [3:0] Present_state = Default;
	
	initial begin
			clk = 0;
			forever #10 clk = ~ clk;
	end	
	
	always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default : Present_state = Init;
			Init : Present_state = Reg_load1a;
			Reg_load1a : Present_state = Reg_load1b;
			Reg_load1b : Present_state = Reg_load2a;
			Reg_load2a : Present_state = Reg_load2b;
			Reg_load2b : Present_state = Reg_load3a;
			Reg_load3a : Present_state = Reg_load3b;
			Reg_load3b : Present_state = T0;
			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = Done;
		endcase
	end
	
	
	always @(posedge clk) begin
		case (Present_state)
			Init: begin
								PCin <= 1; reset <= 1;
								#20 reset <= 0; R0out <= 0; R1out <= 0; R2out <= 0; R3out <= 0; R4out <= 0; R5out <= 0; R6out <= 0; R7out <= 0; R8out <= 0; R9out <= 0; R10out <= 0;
								R11out <= 0; R12out <= 0; R13out <= 0; R14out <= 0; R15out <= 0; HIout <= 0; LOout <= 0; Zhighout <= 0; Zlowout <= 0; PCout <= 0; IRout <= 0; MDRout <=0 ; INout <= 0; Cout <= 0; Yout <= 0; MARout <= 0;
								Read <= 0; IncPC <= 0;
								AND <= 0; OR <= 0; ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; ROL <= 0; NEG <= 0; NOT <= 0;
								R0in <= 0; R1in <= 0; R2in <= 0; R3in <= 0; R4in <= 0; R5in <= 0; R6in <= 0; R7in <= 0; R8in <= 0; R9in <= 0; R10in <= 0; R11in <= 0;
								R12in <= 0; R13in <= 0; R14in <= 0; R15in <= 0; HIin <= 0; LOin <= 0; PCin <= 0; IRin <= 0; Zin <= 0; Yin <= 0; MARin <= 0; MDRin <= 0;
								IN <= 0;
								IN <= 32'd0;
			end
			Reg_load1a: begin
								IN <= 32'h00000022;
								Read <= 1; MDRin <= 1;
								#20 Read <= 0; MDRin <= 0;
							end
			Reg_load1b: begin
								MDRout <= 1; R2in <= 1;
								#20 MDRout <= 0; R2in <= 0;
							end
			Reg_load2a: begin
								IN <= 32'h00000024;
								Read <= 1; MDRin <= 1;
								#20 Read <= 0; MDRin <= 0;
							end
			Reg_load2b: begin
								MDRout <= 1; R6in <= 1;
								#20 MDRout <= 0; R6in <= 0;
							end
			Reg_load3a: begin
								IN <= 32'h00000028;
								Read <= 1; MDRin <= 1;
								#20 Read <= 0; MDRin <= 0;
							end
			Reg_load3b: begin
								MDRout <= 1; R4in <= 1;
								#20 MDRout <= 0; R4in <= 0; 
							end
			T0: begin 
				IncPC <= 1; MARin <= 1; PCin <= 1; MDRin <= 1;
				Read <= 1; IN <= 32'h79300000;
				#20 IncPC <= 0; MARin <= 0; PCin <= 0; MDRin <= 0;
				Read <= 0;
			end
			T1: begin
				MDRout <= 1; IRin <= 1;
				#20 MDRout <= 0; IRin <= 0;
			end
			T2: begin
				R2out <= 1; Yin <= 1;
				#20 R2out <= 0; Yin <= 0;
			end
			T3: begin
				R6out <= 1; DIV <= 1; Zin <= 1;
				#20 R6out <= 0; Zin <= 0;
			end
			T4: begin
				HIin <= 1; LOin <= 1;
				#20 HIin <= 0; LOin <= 0; DIV <= 0;
			end
			Done: begin
				
			end
		endcase
	end
	

endmodule
