`timescale 1ns / 1ps

module add_4_tb(

);

	reg [3:0] A, B;
	reg C0;
	wire [3:0] S;
	wire G_1, P_1, C4;
	reg [3:0] i, j;
	
	add_4 add4(
		A, B, 
		C0,
		S,
		G_1, P_1, C4
	);	

	initial begin
	
		for (i = 4'd0; i < 4'd15; i = i + 4'd1) begin
			for (j = 4'd0; j < 4'd15; j = j + 4'd1) begin
				A = i; B = j; C0 = 1'b0;
				
				#2;
			end
		end
		
		#2560 $stop;
	end
	

endmodule
