module phase3_tb(
	
);
	
	reg clk, reset, stop;
	reg [31:0] IN_unit_input;
	wire run;
	wire [31:0] OUT_unit_output;
		
		
	CPU cpu(
		clk, reset, stop,
		IN_unit_input, 
		run,
		OUT_unit_output
	);

	parameter Default = 5'b00000, Init = 5'b00001, Test = 5'b00010, Done = 5'b01111;
	reg [4:0] Present_state = Default;
	
	initial begin
			clk = 0;
			forever #10 clk = ~ clk;
	end	
	
	always @(posedge clk) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
			Default : Present_state = Init;
			Init : Present_state = Test;
			Test : Present_state = Test;
			Done: Present_state = Done;
		endcase
	end
	
	
	always @(posedge clk) begin
		case (Present_state)
			Init: begin
					stop <= 0; reset <= 1; IN_unit_input <= 32'd0;
					#20 reset <= 0;
			end
			Test: begin
			
			end
			
			Done: begin
				
			end
		endcase
	end

endmodule
