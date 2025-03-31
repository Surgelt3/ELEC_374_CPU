module control_unit(
	input clk, reset, stop,
	input [31:0] IR,
	output reg Read, IncPC, 
	output reg HIout, LOout, Zhighout, Zlowout, PCout, IRout, MDRout, INout, Cout, Yout, MARout, 
	output reg HIin, LOin, PCin, IRin, Zin, Yin, MARin, MDRin, CONin, OUT_Portin,
	output reg AND, OR, ADD, SUB, MUL, DIV, SHR, SHRA, SHL, ROR, ROL, NEG, NOT,
	output reg write_mem,
	output reg CON_RESET, Br,
	output reg BAout,
	output reg run,
	output [15:0] regin, regout,
	output [31:0] CSIGN
);

	reg Gra, Grb, Grc, Rin, Rout;
	reg PCSave;
	
	wire [31:0] IR_bus;
	
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
				load3: present_state = load4;
				load4: present_state = fetch0;
				
				loadi0: present_state = loadi1;
				loadi1: present_state = loadi2;
				loadi2: present_state = fetch0;
				
				st0: present_state = st1;
				st1: present_state = st2;
				st2: present_state = st3;
				st3: present_state = st4;
				st4: present_state = fetch0;
				
				add0: present_state = add1;
				add1: present_state = add2;
				add2: present_state = fetch0;
				
				sub0: present_state = sub1;
				sub1: present_state = sub2;
				sub2: present_state = fetch0;
				
				and0: present_state = and1;
				and1: present_state = and2;
				and2: present_state = fetch0;
				
				or0: present_state = or1;
				or1: present_state = or2;
				or2: present_state = fetch0;

				ror0: present_state = ror1;
				ror1: present_state = ror2;
				ror2: present_state = fetch0;

				rol0: present_state = rol1;
				rol1: present_state = rol2;
				rol2: present_state = fetch0;

				shr0: present_state = shr1;
				shr1: present_state = shr2;
				shr2: present_state = fetch0;

				shra0: present_state = shra1;
				shra1: present_state = shra2;
				shra2: present_state = fetch0;

				shl0: present_state = shl1;
				shl1: present_state = shl2;
				shl2: present_state = fetch0;
				
				addi0: present_state = addi1;
				addi1: present_state = addi2;
				addi2: present_state = fetch0;

				andi0: present_state = andi1;
				andi1: present_state = andi2;
				andi2: present_state = fetch0;

				ori0: present_state = ori1;
				ori1: present_state = ori2;
				ori2: present_state = fetch0;

				div0: present_state = div1;
				div1: present_state = div2;
				div2: present_state = fetch0;

				mul0: present_state = mul1;
				mul1: present_state = mul2;
				mul2: present_state = fetch0;

				neg0: present_state = neg1;
				neg1: present_state = neg2;
				neg2: present_state = fetch0;

				not0: present_state = not1;
				not1: present_state = not2;
				not2: present_state = fetch0;
				
				br0: present_state = br1;
				br1: present_state = br2;
				br2: present_state = fetch0;

				jal0: present_state = jal1;
				jal1: present_state = fetch0;

				jr0: present_state = fetch0;

				in0: present_state = fetch0;

				out0: present_state = fetch0;

				mflo0: present_state = fetch0;
				
				mfhi0: present_state = fetch0;
				
				nop0: present_state = fetch0;

				halt0: present_state = DONE;
				
				DONE: present_state = DONE;

			endcase
		end
	end	
	
	always @(*) begin
		case(present_state) 
			reset_state: begin
						HIout <= 0; LOout <= 0; Zhighout <= 0; Zlowout <= 0; PCout <= 0; IRout <= 0; MDRout <=0 ; INout <= 0; Cout <= 0; Yout <= 0; MARout <= 0;
						Read <= 0; IncPC <= 0;
						AND <= 0; OR <= 0; ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; ROL <= 0; NEG <= 0; NOT <= 0;
						Gra<=0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
						HIin <= 0; LOin <= 0; PCin <= 0; IRin <= 0; Zin <= 0; Yin <= 0; MARin <= 0; MDRin <= 0; CONin <= 0;
						write_mem <= 0;
						CON_RESET <= 1; Br<= 0; PCSave <= 0;
						OUT_Portin <= 0;
			end
			fetch0: begin
				HIout <= 0; LOout <= 0; Zhighout <= 0; Zlowout <= 0; PCout <= 0; IRout <= 0; MDRout <=0 ; INout <= 0; Cout <= 0; Yout <= 0; MARout <= 0;
				Read <= 0; IncPC <= 0;
				AND <= 0; OR <= 0; ADD <= 0; SUB <= 0; MUL <= 0; DIV <= 0; SHR <= 0; SHRA <= 0; SHL <= 0; ROR <= 0; ROL <= 0; NEG <= 0; NOT <= 0;
				Gra<=0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0;
				HIin <= 0; LOin <= 0; PCin <= 0; IRin <= 0; Zin <= 0; Yin <= 0; MARin <= 0; MDRin <= 0; CONin <= 0;
				write_mem <= 0;
				CON_RESET <= 0; PCSave <= 0;
				OUT_Portin <= 0;
				CON_RESET <= 0; Br <= 0;
				IncPC <= 1; MARin <= 1; PCin <= 1;
			end
			fetch1: begin
				IncPC <= 0; MARin <= 0; PCin <= 0;
				MDRin <= 1; Read <= 1;
			end
			fetch2: begin
				MDRout <= 1; IRin <= 1;
			end
			
			load0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; BAout <= 1; Yin <= 1;
			end
			load1: begin
				Grb <= 0; BAout <= 0; Yin <= 0;
				Cout <= 1; ADD <= 1; Zin <= 1;				
			end
			load2: begin
				Cout <= 0; ADD <= 0; Zin <= 0;	
				Zlowout <= 1; MARin <= 1;
			end
			load3: begin
				Zlowout <= 0; MARin <= 0;
				Read <= 1; MDRin <= 1;
			end
			load4: begin
				MDRout <= 1; Gra <= 1; Rin <= 1;
			end

			loadi0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; BAout <= 1; Yin <= 1;
			end
			loadi1: begin
				Grb <= 0; BAout <= 0; Yin <= 0;
				Cout <= 1; ADD <= 1; Zin <= 1;
			end
			loadi2: begin
				Cout <= 0; ADD <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end

			st0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; BAout <= 1; Yin <= 1;
			end
			st1: begin
				Grb <= 0; BAout <= 0; Yin <= 0;
				Cout <= 1; ADD <= 1; Zin <= 1;
			end
			st2: begin
				Cout <= 0; ADD <= 0; Zin <= 0;
				Zlowout <= 1; MARin <= 1;
			end
			st3: begin
				Zlowout <= 0; MARin <= 0;
				Gra <= 1; Rout <= 1; MDRin <= 1;
			end
			st4: begin
				Gra <= 0; Rout <= 0; MDRin <= 0;
				write_mem <= 1;
			end

			add0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			add1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; ADD <= 1; Zin <= 1; 
			end
			add2: begin
				Grc <= 0; Rout <= 0; ADD <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			sub0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			sub1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; SUB <= 1; Zin <= 1; 
			end
			sub2: begin
				Grc <= 0; Rout <= 0; SUB <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			and0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			and1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; AND <= 1; Zin <= 1; 
			end
			and2: begin
				Grc <= 0; Rout <= 0; AND <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			or0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			or1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; OR <= 1; Zin <= 1; 
			end
			or2: begin
				Grc <= 0; Rout <= 0; OR <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			ror0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			ror1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; ROR <= 1; Zin <= 1; 
			end
			ror2: begin
				Grc <= 0; Rout <= 0; ROR <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			rol0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			rol1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; ROL <= 1; Zin <= 1; 
			end
			rol2: begin
				Grc <= 0; Rout <= 0; ROL <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			shr0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			shr1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; SHR <= 1; Zin <= 1; 
			end
			shr2: begin
				Grc <= 0; Rout <= 0; SHR <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			shra0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			shra1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; SHRA <= 1; Zin <= 1; 
			end
			shra2: begin
				Grc <= 0; Rout <= 0; SHRA <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			shl0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			shl1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grc <= 1; Rout <= 1; SHL <= 1; Zin <= 1; 
			end
			shl2: begin
				Grc <= 0; Rout <= 0; SHL <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
						
			addi0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			addi1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Cout <= 1; ADD <= 1; Zin <= 1; 
			end
			addi2: begin
				Cout <= 0; ADD <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end

			andi0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			andi1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Cout <= 1; AND <= 1; Zin <= 1; 
			end
			andi2: begin
				Cout <= 0; AND <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			ori0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			ori1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Cout <= 1; OR <= 1; Zin <= 1; 
			end
			ori2: begin
				Cout <= 0; OR <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			div0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Gra <= 1; Rout <= 1; Yin <= 1; 
			end
			div1: begin
				Gra <= 0; Rout <= 0; Yin <= 0;
				Grb <= 1; Rout <= 1; DIV <= 1; Zin <= 1;
			end
			div2: begin
				Grb <= 0; Rout <= 0; Zin <= 0;
				HIin <= 1; LOin <= 1;
			end
			
			mul0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Gra <= 1; Rout <= 1; Yin <= 1; 
			end
			mul1: begin
				Gra <= 0; Rout <= 0; Yin <= 0;
				Grb <= 1; Rout <= 1; MUL <= 1; Zin <= 1;
			end
			mul2: begin
				Grb <= 0; Rout <= 0; Zin <= 0;
				HIin <= 1; LOin <= 1;
			end
						
			neg0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			neg1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grb <= 1; Rout <= 1; NEG <= 1; Zin <= 1;
			end
			neg2: begin
				Grb <= 0; Rout <= 0; NEG <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end

			not0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Grb <= 1; Rout <= 1; Yin <= 1; 
			end
			not1: begin
				Grb <= 0; Rout <= 0; Yin <= 0;
				Grb <= 1; Rout <= 1; NOT <= 1; Zin <= 1;
			end
			not2: begin
				Grb <= 0; Rout <= 0; NOT <= 0; Zin <= 0;
				Zlowout <= 1; Gra <= 1; Rin <= 1;
			end
			
			br0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Gra <= 1; Rout <= 1; CONin <= 1;
			end
			br1: begin
				Gra <= 0; Rout <= 0; CONin <= 0;
				IncPC <= 1; PCin <= 1; Br <= 1;
			end
			br2: begin
				IncPC <= 0; PCin <= 0; Br <= 0;
				CON_RESET <= 1;
			end
			
			jal0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				PCSave <= 1; PCout <= 1; Gra <= 1; Rin <= 1;
			end
			jal1: begin
				PCSave <= 0; PCout <= 0; Gra <= 1; Rin <= 1;
				Gra <= 1; Rout <= 1; PCin <= 1;
			end

			jr0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Gra <= 1; Rout <= 1; PCin <= 1; 
			end
			
			in0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				INout <= 1; Gra <= 1; Rin <= 1;
			end
			
			out0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				Gra <= 1; Rout <= 1; OUT_Portin <= 1; 
			end
			
			mflo0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				LOout <= 1; Gra <= 1; Rin <= 1;
			end
			
			mfhi0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
				HIout <= 1; Gra <= 1; Rin <= 1;
			end
			
			nop0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
			end
			
			halt0: begin
				MDRout <= 0; IRin <= 0; Read <= 0; MDRin <= 0;
			end

		endcase
	
	end
	
	assign IR_bus = PCSave ? 32'h04000000: IR;
	
	select_encode s_e(
		.Gra(Gra), .Grb(Grb), .Grc(Grc), 
		.Rin(Rin), .Rout(Rout), .BAout(BAout),
		.data(IR_bus),
		.regin(regin), 
		.regout(regout), 
		.C_sign_extended(CSIGN)
	);


endmodule
