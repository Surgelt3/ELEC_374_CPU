module mul (
	input [31:0] M, Q,
	output reg [63:0] P
);	

	integer i;
	integer j, k;
	reg [63:0] A, B;
	reg [31:0] negative, positive;
	reg [31:0] temp;
	
	always @(*) begin
				
		B = {{32{1'b0}}, M};
		A = {64{1'b0}};
		temp = Q >> 1;
		
		for(i = 0; i < 32; i=i+2) begin
			if (i == 0) begin
				case(Q[1:0])
					2'b00: A = A;
					2'b01: A = A + B;
					2'b10: A = A + ((~B + 1'b1)<< 1);
					2'b11: A = A;
				endcase
			end else begin
				j = i+1;
				k = i-1; 
				case(temp[2:0])
					3'b000: A = A + 0;
					3'b001: A = A + (B << i);
					3'b010: A = A + (B << i);
					3'b011: A = A + (B << (i+1));
					3'b100: A = A + ((~B + 1'b1)<< (i+1));
					3'b101: A = A + ((~B + 1'b1)<< (i));
					3'b110: A = A + ((~B + 1'b1)<< (i));
					3'b111: A = A + 0;
				endcase
				temp = temp >> 2;
			end
		end
		P = A;
	end

endmodule
