module reg_test ();

	reg clk, reset;
	reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout,INout, Cout, Yout, MARout;
	
	reg [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;
	reg [31:0] HI, LO, ZHI, ZLO, PC, IR, MDR, IN, CSIGN, Y, MAR;
	wire [31:0] BusMuxOut;
	
	parameter Default = 4'b0000, Init = 4'b0001, Reg_load1a = 4'b0010, Reg_load1b = 4'b0011, Reg_load2a = 4'b0100,
				Reg_load2b = 4'b0101, Reg_load3a = 4'b0110, Reg_load3b = 4'b0111, Reg_read1a = 4'b1000,
				T0 = 4'b1000,
				T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
	reg [3:0] Present_state = Default;

	bus b(
		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
		HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout,INout, Cout, Yout, MARout,
		R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, 
		HI, LO, ZHI, ZLO, PC, IR, MDR, IN, CSIGN, Y, MAR, 
		BusMuxOut
	);
	
	initial begin
			reset = 0;
			clk = 0;
			forever #20 clk = ~ clk;
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
			Reg_load3b : Present_state = Reg_read1a;
			Reg_read1a : Present_state = T0;
			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = T5;
		endcase
	end

	
	always @(posedge clk) begin
		case (Present_state)
			Init: begin
								reset <= 0; R0out <= 0; R1out <= 0; R2out <= 0; R3out <= 0; R4out <= 0; R5out <= 0; R6out <= 0; R7out <= 0; R8out <= 0; R9out <= 0; R10out <= 0;
								R11out <= 0; R12out <= 0; R13out <= 0; R14out <= 0; R15out <= 0; HIout <= 0; LOout <= 0; Zhighout <= 0; Zlowout <= 0; PCout <= 0; IRout <= 0; MDRout <= 0; INout <= 0; Cout <= 0; Yout <= 0; MARout <= 0;
			end
			Reg_load1a: begin
								MDRout <= 1; R0 <= 32'd0; R1<= 32'd1; R2 <= 32'd2; R3 <= 32'd3; R4 <= 32'd4; R5 <= 32'd5; R6 <= 32'd6; R7 <= 32'd7; R8 <= 32'd8; R9 <= 32'd9; R10 <= 32'd10;
								R11 <= 32'd11; R12 <= 32'd12; R13 <= 32'd13; R14 <= 32'd14; R15 <= 32'd15; HI <= 32'd16; LO <= 32'd17; PC <= 32'd18; IR<= 32'd19; MDR <= 32'd64;
								#80;
							end
			//Reg_load1b: begin
			//					R4out <= 1; R4 <= 32'h00000024;
			//					#20 R4out <= 0;
			//				end
			//Reg_load2a: begin
			//					Mdatain <= 32'h00000024;
			//					Read <= 1; MDRin <= 1;
			//					#20 Read <= 0; MDRin <= 0;
			//				end
			//Reg_load2b: begin
			//					MDRout <= 1; R7in <= 1;
			//					#20 MDRout <= 0; R7in <= 0;
			//				end
			//Reg_load3a: begin
			//					Mdatain <= 32'h00000028;
			//					Read <= 1; MDRin <= 1;
			//					#20 Read <= 0; MDRin <= 0;
			//				end
			//Reg_load3b: begin
			//					MDRout <= 1; R4in <= 1;
			//					#20 MDRout <= 0; R4in <= 0; 
			//				end
			//Reg_read1a: begin
			//					R3out <= 1;
			//					#20 R3out <= 0;
			//				end
		
		endcase
	end

endmodule
