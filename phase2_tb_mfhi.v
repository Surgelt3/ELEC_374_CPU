module phase2_tb_mfhi(
	
);
	
	reg clk, reset;
	reg HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout;
	reg Read, IncPC;
	reg AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT;
	reg Gra, Grb, Grc, Rin, Rout, BAout;
	reg HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin;
	reg read_mem, write_mem;
	reg CON_RESET;
	reg PCSave;
	reg [31:0] IN_unit_input;
	wire [31:0] OUT_unit_output;
		
		
	CPU cpu(
		clk, reset,
		HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout,
		Read, IncPC,
		AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
		Gra, Grb, Grc, Rin, Rout, BAout,
		HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin, 
		read_mem, write_mem,
		CON_RESET,
		PCSave,
		IN_unit_input,
		OUT_unit_output
	);

	parameter Default = 5'b00000, Init = 5'b00001, Regload0 = 5'b00010, Regload1 = 5'b00011, Regload2 = 5'b00100,
				Regload3 = 5'b00101, Regload4 = 5'b00110, Regload5 = 5'b00111, 
				
				Regload6 = 5'b01000, Regload7 = 5'b01001, Regload8 = 5'b01010, Regload9 = 5'b01011, Regload10 = 5'b01100, Regload11 = 5'b01101,
				
				Mulreg0 = 5'b01110, Mulreg1 = 5'b01111, Mulreg2 = 5'b10000, Mulreg3 = 5'b10001, Mulreg4 = 5'b10010, Mulreg5 = 5'b10011, 
				
				T0 = 5'b10100, T1 = 5'b10101, T2 = 5'b10110, T3 = 5'b10111, T4 = 5'b11000, T5 = 5'b11001, T6 = 5'b11010,
				Done = 5'b11011;
	reg [4:0] Present_state = Default;
	
	initial begin
			clk = 0;
			forever #10 clk = ~ clk;
	end	
	
	always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default : Present_state = Init;
			Init : Present_state = Regload0;
			Regload0 : Present_state = Regload1;
			Regload1 : Present_state = Regload2;
			Regload2 : Present_state = Regload3;
			Regload3 : Present_state = Regload4;
			Regload4 : Present_state = Regload5;
			Regload5 : Present_state = Regload6;
			
			Regload6 : Present_state = Regload7;
			Regload7 : Present_state = Regload8;
			Regload8 : Present_state = Regload9;
			Regload9 : Present_state = Regload10;
			Regload10 : Present_state = Regload11;
			Regload11 : Present_state = Mulreg0;
			
			Mulreg0 : Present_state = Mulreg1;
			Mulreg1 : Present_state = Mulreg2;
			Mulreg2 : Present_state = Mulreg3;
			Mulreg3 : Present_state = Mulreg4;
			Mulreg4 : Present_state = Mulreg5;
			Mulreg5 : Present_state = T0;

			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = T5;
			T5 : Present_state = T6;
			T6 : Present_state = Done;
			Done: Present_state = Done;
		endcase
	end
	
	
	always @(posedge clk) begin
		case (Present_state)
			Init: begin
								CON_RESET <= 1;
								reset <= 1;
								#20
								reset <= 0; HIout <= 0; LOout <= 0; Zhighout <= 0; Zlowout <= 0; PCout <= 0; IRout <= 0; MDRout <=0 ; INout <= 0; Cout <= 0; Yout <= 0; MARout <= 0;
								Read <= 0; IncPC <= 0;
								AND <= 0; OR <= 0; ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; ROL <= 0; NEG <= 0; NOT <= 0;
								Gra<=0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
								HIin <= 0; LOin <= 0; PCin <= 0; IRin <= 0; Zin <= 0; Yin <= 0; MARin <= 0; MDRin <= 0; CONin <= 0;
								read_mem <= 0; write_mem <= 0;
								CON_RESET <= 0; PCSave <= 0;
								IN_unit_input <= 0; OUT_Portin <= 0;
			end
			
			Regload0: begin
				IncPC <= 1; MARin <= 1; PCin <= 1;
				#20 IncPC <= 0; MARin <= 0; PCin <= 0;
			end
			Regload1: begin
				MDRin <= 1; Read <= 1;
				#20;
			end
			Regload2: begin
				MDRout <= 1; IRin <= 1;
				#20 MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
			end
			Regload3: begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#20 Grb <= 0; BAout <= 0; Yin <= 0;
			end
			Regload4: begin
				Cout <= 1; ADD <= 1; Zin <= 1;
				#20 Cout <= 0; ADD <= 0; Zin <= 0;
			end
			Regload5: begin
				Zlowout <= 1; Gra <= 1; Rin <= 1; 		
				#20 Zlowout <= 0; Gra <= 0; Rin <= 0; 
			end
			
			Regload6: begin
				IncPC <= 1; MARin <= 1; PCin <= 1;
				#20 IncPC <= 0; MARin <= 0; PCin <= 0;
			end
			Regload7: begin
				MDRin <= 1; Read <= 1;
				#20;
			end
			Regload8: begin
				MDRout <= 1; IRin <= 1;
				#20 MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
			end
			Regload9: begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#20 Grb <= 0; BAout <= 0; Yin <= 0;
			end
			Regload10: begin
				Cout <= 1; ADD <= 1; Zin <= 1;
				#20 Cout <= 0; ADD <= 0; Zin <= 0;
			end
			Regload11: begin
				Zlowout <= 1; Gra <= 1; Rin <= 1; 		
				#20 Zlowout <= 0; Gra <= 0; Rin <= 0; 
			end

			Mulreg0: begin 
				IncPC <= 1; MARin <= 1; PCin <= 1;
				#20 IncPC <= 0; MARin <= 0; PCin <= 0;
			end
			Mulreg1: begin
				MDRin <= 1; Read <= 1;
				#20;
			end
			Mulreg2: begin
				MDRout <= 1; IRin <= 1;
				#20 MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
			end
			Mulreg3: begin
				Grb <= 1; Rout <= 1; Yin <= 1; 
				#20 Grb <= 0; Rout <= 0; Yin <= 0;
			end
			Mulreg4: begin
				Gra <= 1; Rout <= 1; MUL <= 1; Zin <= 1;
				#20 Grc <= 0; Rout <= 0; MUL <= 0; Zin <= 0;
			end
			Mulreg5: begin
				HIin <= 1; LOin <= 1;
				#20 HIin <= 0; LOin <= 0; MUL <= 0;
			end

			T0: begin
				IncPC <= 1; MARin <= 1; PCin <= 1;
				#20 IncPC <= 0; MARin <= 0; PCin <= 0;
			end
			T1: begin
				MDRin <= 1; Read <= 1;
				#20;
			end
			T2: begin
				MDRout <= 1; IRin <= 1;
				#20 MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
			end
			T3: begin
				Zhighout <= 1; Gra <= 1; Rin <= 1;
				#20 Zhighout <= 0; Gra <= 0; Rin <= 0;
			end

			Done: begin
				
			end
		endcase
	end

endmodule
