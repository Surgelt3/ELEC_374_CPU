module control_unit(
	input clk, reset, stop,
	input [31:0] IR,
	output reg Read, IncPC, 
	output reg HIoutA, LOoutA, ZhighoutA, ZlowoutA, PCoutA, IRoutA, MDRoutA, INoutA, CoutA, YoutA, MARoutA, 
	output reg HIoutB, LOoutB, ZhighoutB, ZlowoutB, PCoutB, IRoutB, MDRoutB, INoutB, CoutB, YoutB, MARoutB, 
	output reg HIoutC, LOoutC, ZhighoutC, ZlowoutC, PCoutC, IRoutC, MDRoutC, INoutC, CoutC, YoutC, MARoutC, 
	output reg HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
	output reg AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
	output reg write_mem,
	output reg CON_RESET, Br,
	output reg BAout,
	output reg run,
	output reg [1:0] RinSel,
	output [15:0] regin, regout_A, regout_B, regout_C,
	output [31:0] CSIGN
);

	reg Gra, Grb, Grc, Rin, RoutA, RoutB, RoutC;
	reg PCSave;
	
	
	wire [31:0] IR_bus;
	
	reg HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout, Rout;
	//st
	parameter reset_state = 7'd0, 
					fetch0 = 7'd1, fetch1 = 7'd2, fetch2 = 7'd3, 
					load0 = 7'd4, load1 = 7'd5, load2 = 7'd6, load3 = 7'd7, load4 = 7'd8,
					loadi0 = 7'd9, loadi1 = 7'd10, loadi2 = 7'd11,
					st0 = 7'd12, st1 = 7'd13, st2 = 7'd14, st3 = 7'd15, st4 = 7'd16,
					add0 = 7'd17, add1 = 7'd18, add2 = 7'd19,
					sub0 = 7'd20, sub1 = 7'd21, sub2 = 7'd22,
					and0 = 7'd23, and1 = 7'd24, and2 = 7'd25,
					or0 = 7'd26, or1 = 7'd27, or2 = 7'd28,
					ror0 = 7'd29, ror1 = 7'd30, ror2 = 7'd31,
					rol0 = 7'd32, rol1 = 7'd33, rol2 = 7'd34,
					shr0 = 7'd35, shr1 = 7'd36, shr2 = 7'd37,
					shra0 = 7'd38, shra1 = 7'd39, shra2 = 7'd40,
					shl0 = 7'd41, shl1 = 7'd42, shl2 = 7'd43,
					addi0 = 7'd44, addi1 = 7'd45, addi2 = 7'd46,
					andi0 = 7'd47, andi1 = 7'd48, andi2 = 7'd49,
					ori0 = 7'd50, ori1 = 7'd51, ori2 = 7'd52,
					div0 = 7'd53, div1 = 7'd54, div2 = 7'd55,
					mul0 = 7'd56, mul1 = 7'd57, mul2 = 7'd58,
					neg0 = 7'd59, neg1 = 7'd60, neg2 = 7'd61,
					not0 = 7'd62, not1 = 7'd63, not2 = 7'd64,
					br0 = 7'd65, br1 = 7'd66, br2 = 7'd67, 
					jal0 = 7'd68, jal1 = 7'd69, 
					jr0 = 7'd70,
					in0 = 7'd71,
					out0 = 7'd72,
					mflo0 = 7'd73,
					mfhi0 = 7'd74,
					nop0 = 7'd75,
					halt0 = 7'd76,
					DONE = 7'd77;
	reg [6:0] present_state;
	
	always @(posedge clk) begin
	
		if (reset)
			present_state = reset_state;
		else if (stop) begin
			present_state = present_state;
			run = 0;
		end else begin
			run = 1;
			case(present_state)
				reset_state: present_state = fetch0;
				fetch0: present_state = fetch1;
				fetch1: present_state = fetch2;
				fetch2: begin
								case(IR[31:27])
									5'b00000: present_state = load0;
									5'b00001: present_state = loadi0;
									5'b00010: present_state = st0;
									5'b00011: present_state = add0;
									5'b00100: present_state = sub0;
									5'b00101: present_state = and0;
									5'b00110: present_state = or0;
									5'b00111: present_state = ror0;
									5'b01000: present_state = rol0;
									5'b01001: present_state = shr0;
									5'b01010: present_state = shra0;
									5'b01011: present_state = shl0;
									5'b01100: present_state = addi0;
									5'b01101: present_state = andi0;
									5'b01110: present_state = ori0;
									5'b01111: present_state = div0;
									5'b10000: present_state = mul0;
									5'b10001: present_state = neg0;
									5'b10010: present_state = not0;
									5'b10011: present_state = br0;
									5'b10100: present_state = jal0;
									5'b10101: present_state = jr0;
									5'b10110: present_state = in0;
									5'b10111: present_state = out0;
									5'b11000: present_state = mflo0;
									5'b11001: present_state = mfhi0;
									5'b11010: present_state = nop0;
									5'b11011: present_state = halt0;
								endcase
				end
				
				load0: present_state = load1;
				load1: present_state = load2;
				load2: present_state = load3;
				load3: present_state = fetch1;
				
				loadi0: present_state = loadi1;
				loadi1: present_state = fetch2;
				
				st0: present_state = st1;
				st1: present_state = st2;
				st2: present_state = st3;
				st3: present_state = fetch0;
				
				add0: present_state = add1;
				add1: present_state = fetch2;
				
				sub0: present_state = sub1;
				sub1: present_state = fetch2;
				
				and0: present_state = and1;
				and1: present_state = fetch2;
				
				or0: present_state = or1;
				or1: present_state = fetch2;

				ror0: present_state = ror1;
				ror1: present_state = fetch2;

				rol0: present_state = rol1;
				rol1: present_state = fetch2;

				shr0: present_state = shr1;
				shr1: present_state = fetch2;

				shra0: present_state = shra1;
				shra1: present_state = fetch2;

				shl0: present_state = shl1;
				shl1: present_state = fetch2;
				
				addi0: present_state = addi1;
				addi1: present_state = fetch2;

				andi0: present_state = andi1;
				andi1: present_state = fetch2;

				ori0: present_state = ori1;
				ori1: present_state = fetch2;

				div0: present_state = div1;
				div1: present_state = fetch2;

				mul0: present_state = mul1;
				mul1: present_state = fetch2;

				neg0: present_state = neg1;
				neg1: present_state = fetch2;

				not0: present_state = not1;
				not1: present_state = fetch2;
				
				br0: present_state = br1;
				br1: present_state = fetch0;

				jal0: present_state = jal1;
				jal1: present_state = fetch0;

				jr0: present_state = fetch0;

				in0: present_state = fetch1;

				out0: present_state = fetch1;

				mflo0: present_state = fetch1;
				
				mfhi0: present_state = fetch1;
				
				nop0: present_state = fetch1;

				halt0: present_state = DONE;
				
				DONE: present_state = DONE;

			endcase
		end
	end	
	
	always @(*) begin
		case(present_state) 
			reset_state: begin
						HIoutA <= 0; LOoutA <= 0; ZhighoutA <= 0; ZlowoutA <= 0; PCoutA <= 0; IRoutA <= 0; MDRoutA <=0 ; INoutA <= 0; CoutA <= 0; YoutA <= 0; MARoutA <= 0;
						HIoutB <= 0; LOoutB <= 0; ZhighoutB <= 0; ZlowoutB <= 0; PCoutB <= 0; IRoutB <= 0; MDRoutB <=0 ; INoutB <= 0; CoutB <= 0; YoutB <= 0; MARoutB <= 0;
						HIoutC <= 0; LOoutC <= 0; ZhighoutC <= 0; ZlowoutC <= 0; PCoutC <= 0; IRoutC <= 0; MDRoutC <=0 ; INoutC <= 0; CoutC <= 0; YoutC <= 0; MARoutC <= 0;
						Read <= 0; IncPC <= 0;
						AND <= 0; OR <= 0; ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; ROL <= 0; NEG <= 0; NOT <= 0;
						Gra<=0; Grb <= 0; Grc <= 0; Rin <= 0; RoutA <= 0; RoutB <= 0; RoutC <= 0; BAout <= 0;
						HIin <= 0; LOin <= 0; PCin <= 0; IRin <= 0; Zin <= 0; Yin <= 0; MARin <= 0; MDRin <= 0; CONin <= 0;
						write_mem <= 0;
						CON_RESET <= 1; Br<= 0; PCSave <= 0;
						OUT_Portin <= 0; RinSel <= 2'b00;
			end
			fetch0: begin
				HIoutA <= 0; LOoutA <= 0; ZhighoutA <= 0; ZlowoutA <= 0; PCoutA <= 0; IRoutA <= 0; MDRoutA <=0 ; INoutA <= 0; CoutA <= 0; YoutA <= 0; MARoutA <= 0;
				HIoutB <= 0; LOoutB <= 0; ZhighoutB <= 0; ZlowoutB <= 0; PCoutB <= 0; IRoutB <= 0; MDRoutB <=0 ; INoutB <= 0; CoutB <= 0; YoutB <= 0; MARoutB <= 0;
				HIoutC <= 0; LOoutC <= 0; ZhighoutC <= 0; ZlowoutC <= 0; PCoutC <= 0; IRoutC <= 0; MDRoutC <=0 ; INoutC <= 0; CoutC <= 0; YoutC <= 0; MARoutC <= 0;
				Read <= 0; IncPC <= 0;
				AND <= 0; OR <= 0; ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; ROL <= 0; NEG <= 0; NOT <= 0;
				Gra<=0; Grb <= 0; Grc <= 0; Rin <= 0; RoutA <= 0; RoutB <= 0; RoutC <= 0; BAout <= 0;
				HIin <= 0; LOin <= 0; PCin <= 0; IRin <= 0; Zin <= 0; Yin <= 0; MARin <= 0; MDRin <= 0; CONin <= 0;
				write_mem <= 0;
				CON_RESET <= 0; PCSave <= 0;
				OUT_Portin <= 0;
				CON_RESET <= 0; Br <= 0;
				IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			fetch1: begin
				IncPC <= 0; MARin <= 0; PCin <= 0; 
				MDRin <= 0; MDRoutA <= 0; Gra <= 0; Rin <= 0;
				write_mem <= 0;
				CON_RESET <= 0;
				Gra <= 0; RoutA <= 0;
				INoutA <= 0;
				OUT_Portin <= 0;
				LOoutA <= 0;
				HIoutA <= 0;
				Read <= 1;
			end
			fetch2: begin
				ZlowoutA <= 0; Gra <= 0; Rin <= 0;
				HIin <= 0; LOin <= 0; DIV <= 0; MUL <= 0;
				MDRin <= 1; Read <= 1; MDRoutC <= 1; IRin <= 1; RinSel <= 2'b10; 
			end
			
			load0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; BAout <= 1; CoutC <= 1; ADD <= 1; Zin <= 1;
			end
			load1: begin
				Grb <= 0; BAout <= 0; CoutC <= 0; ADD <= 0; Zin <= 0;
				ZlowoutA <= 1; MARin <= 1; RinSel <= 2'b00;
			end
			load2: begin
				ZlowoutA <= 0; MARin <= 0;
				Read <= 1;
			end
			load3: begin
				MDRin <= 1; Read <= 1; MDRoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; IncPC <= 1; MARin <= 1; PCin <= 1;
			end

			loadi0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; BAout <= 1; CoutC <= 1; ADD <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			loadi1: begin
				Grb <= 0; BAout <= 0; CoutC <= 0; ADD <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end

			st0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; BAout <= 1; CoutC <= 1; ADD <= 1; Zin <= 1;
			end
			st1: begin
				Grb <= 0; BAout <= 0; CoutC <= 0; ADD <= 0; Zin <= 0;
				ZlowoutA <= 1; MARin <= 1; RinSel <= 2'b00;
			end
			st2: begin
				ZlowoutA <= 0; MARin <= 0;
				Gra <= 1; RoutA <= 1; MDRin <= 1; RinSel <= 2'b00;
			end
			st3: begin
				Gra <= 0; RoutA <= 0; MDRin <= 0;
				write_mem <= 1;
			end

			add0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; ADD <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			add1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; ADD <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			sub0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; SUB <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			sub1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; SUB <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			and0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; AND <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			and1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; AND <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			or0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; OR <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			or1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; OR <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			ror0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; ROR <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			ror1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; ROR <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			rol0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; ROL <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			rol1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; ROL <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			shr0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; SHR <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			shr1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; SHR <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			shra0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; SHRA <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			shra1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; SHRA <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			shl0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; Grc <= 1; RoutC <= 1; SHL <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			shl1: begin
				Grb <= 0; RoutB <= 0; Grc <= 0; RoutC <= 0; SHL <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
						
			addi0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; CoutC <= 1; ADD <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			addi1: begin
				Grb <= 0; RoutB <= 0; CoutC <= 0; ADD <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end

			andi0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; CoutC <= 1; AND <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			andi1: begin
				Grb <= 0; RoutB <= 0; CoutC <= 0; AND <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			ori0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; CoutC <= 1; OR <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			ori1: begin
				Grb <= 0; RoutB <= 0; CoutC <= 0; OR <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			div0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Gra <= 1; RoutA <= 1; Grb <= 1; RoutB <= 1; DIV <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			div1: begin
				Gra <= 0; RoutA <= 0; Grb <= 0; RoutB <= 0; DIV <= 1; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				HIin <= 1; LOin <= 1; Read <= 1;
			end
			
			mul0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Gra <= 1; RoutA <= 1; Grb <= 1; RoutB <= 1; MUL <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			mul1: begin
				Gra <= 0; RoutA <= 0; Grb <= 0; RoutB <= 0; MUL <= 1; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				HIin <= 1; LOin <= 1; Read <= 1;
			end
						
			neg0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; NEG <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			neg1: begin
				Grb <= 0; RoutB <= 0; NEG <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end

			not0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Grb <= 1; RoutB <= 1; NOT <= 1; Zin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			not1: begin
				Grb <= 0; RoutB <= 0; NOT <= 0; Zin <= 0; IncPC <= 0; MARin <= 0; PCin <= 0;
				ZlowoutA <= 1; Gra <= 1; Rin <= 1; RinSel <= 2'b00; Read <= 1;
			end
			
			br0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Gra <= 1; RoutA <= 1; RinSel <= 2'b00; CONin <= 1;
			end
			br1: begin
				Gra <= 0; RoutA <= 0; CONin <= 0;
				IncPC <= 1; PCin <= 1; Br <= 1; CON_RESET <= 1;
			end
			
			jal0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				PCSave <= 1; PCoutA <= 1; RinSel <= 2'b00; Gra <= 1; Rin <= 1;
			end
			jal1: begin
				PCSave <= 0; PCoutA <= 0; Gra <= 1; Rin <= 1;
				Gra <= 1; RoutA <= 1; RinSel <= 2'b00; PCin <= 1;
			end

			jr0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Gra <= 1; RoutA <= 1; RinSel <= 2'b00; PCin <= 1;
			end
			
			in0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				INoutA <= 1; Gra <= 1; RinSel <= 2'b00; Rin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			
			out0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				Gra <= 1; RoutA <= 1; RinSel <= 2'b00; OUT_Portin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			
			mflo0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				LOoutA <= 1; Gra <= 1; RinSel <= 2'b00; Rin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			
			mfhi0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
				HIoutA <= 1; Gra <= 1; RinSel <= 2'b00; Rin <= 1; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			
			nop0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0; IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			
			halt0: begin
				MDRin <= 0; Read <= 0; MDRoutC <= 0; IRin <= 0;
			end

		endcase
	
	end
	
	assign IR_bus = PCSave ? 32'h04000000: IR;
	
	select_encode_ABC se(
		Gra, Grb, Grc,
		Rin,
		RoutA, RoutB, RoutC,
		BAout,
		RinSel,
		IR_bus,
		regin, regout_A, regout_B, regout_C,
		CSIGN
	);



endmodule
