module phase2_tb_ld(
	
);
	
	reg clk, reset;
	reg HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout;
	reg Read, IncPC;
	reg AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT;
	reg Gra, Grb, Grc, Rin, Rout, BAout;
	reg HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin;
	reg read_mem, write_mem;
	reg [31:0] IN_unit_input;
	reg CON_RESET;
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
		IN_unit_input,
		OUT_unit_output
	);

	parameter Default = 4'b0000, Init = 4'b0001, T0 = 4'b0010, T1 = 4'b0011, T2 = 4'b0100,
				T3 = 4'b0101, T4 = 4'b0110, T5 = 4'b0111, T6 = 4'b1000, T7 =4'b1001 ,
				Done = 4'b1010;
	reg [3:0] Present_state = Default;
	
	initial begin
			clk = 0;
			forever #10 clk = ~ clk;
	end	
	
	always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default : Present_state = Init;
			Init : Present_state = T0;
			T0 : Present_state = T1;
			T1 : Present_state = T2;
			T2 : Present_state = T3;
			T3 : Present_state = T4;
			T4 : Present_state = T5;
			T5 : Present_state = T6;
			T6 : Present_state = T7;
			T7 : Present_state = Done;
			Done: Present_state = Done;
		endcase
	end
	
	
	always @(posedge clk) begin
		case (Present_state)
			Init: begin
			
								PCin <= 1; IRin <= 1;
								reset <= 1;
								#20
								reset <= 0; HIout <= 0; LOout <= 0; Zhighout <= 0; Zlowout <= 0; PCout <= 0; IRout <= 0; MDRout <=0 ; INout <= 0; Cout <= 0; Yout <= 0; MARout <= 0;
								Read <= 0; IncPC <= 0;
								AND <= 0; OR <= 0; ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; ROL <= 0; NEG <= 0; NOT <= 0;
								Gra<=0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
								HIin <= 0; LOin <= 0; PCin <= 0; IRin <= 0; Zin <= 0; Yin <= 0; MARin <= 0; MDRin <= 0;
								read_mem <= 0; write_mem <= 0;
								IN_unit_input <= 0; 
			end
			T0: begin 
				IncPC <= 1; MARin <= 1; PCin <= 1;
				Read <= 1;
				#20 IncPC <= 0; MARin <= 0; PCin <= 0;
			end
			T1: begin
				MDRin <= 1;
				#20 MDRin <= 0; Read <= 0;
			end
			T2: begin
				MDRout <= 1; IRin <= 1;
				#20 MDRout <= 0; IRin <= 0;
			end
			T3: begin
				Grb <= 1; BAout <= 1; Yin <= 1;
				#20 Grb <= 0; BAout <= 0; Yin <= 0;
			end
			T4: begin
				Cout <= 1; ADD <= 1; Zin <= 1;
				#20 Cout <= 0; ADD <= 0; Zin <= 0;
			end
			T5: begin
				Zlowout <= 1; MARin <= 1; Read <= 1;
				#20 Zlowout <= 0; MARin <= 0;
			end
			T6: begin
				Read <= 1; MDRin <= 1;
				#20;
			end
			T7: begin
				Gra <= 1; Rin <= 1; Read <= 1;
				#20 Gra <= 0; Rin <= 0; Read <= 0; MDRin <= 0;
			end
			Done: begin
				
			end
		endcase
	end

endmodule
