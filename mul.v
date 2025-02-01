module mul (
	input [31:0] M, Q,
	output reg [63:0] P
);	
	
	integer i;
	reg [63:0] A, B;
	reg [31:0] negative, positive;
	
	always @(*) begin
		B = {{32{1'b0}}, M};
		A = {64{1'b0}};
		
		for(i = 0; i < 32; i=i+1) begin
			if (i == 0) begin
				if(~Q[0]) begin
					positive[0] = 0;
					negative[0] = 0;
				end else 
					negative[0] = 1;
					positive[0] = 0;
			end else if(~Q[i]) begin
				if(~Q[i-1]) begin
					positive[i] = 0;
					negative[i] = 0; 
				end else begin
					positive[i] = 1;
					negative[i] = 0;
				end
			end else begin
				if(Q[i-1]) begin
					positive[i] = 0;
					negative[i] = 0; 
				end else begin
					positive[i] = 0;
					negative[i] = 1;
				end
			end
			if (negative[i])
				A = A + ((~B + 1'b1)<< i);
			else if (positive[i])
				A = A + ((B)<< i);
			else
				A = A + {64{1'b0}};
			$display("%d\n", A);
		end
		P = A;
	end

endmodule
