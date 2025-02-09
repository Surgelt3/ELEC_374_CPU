module div(
    input [31:0] M, Q, 
    output reg [31:0] remainder, quotient
);
reg [31:0] A;
reg [31:0] Dividend;
reg [31:0] Divisor;
reg [31:0] DivisorNeg;
integer i;

always @(*) begin
	A = {32{1'b0}};
	Dividend = Q;
	Divisor = M;
	DivisorNeg = ~M + 1'b1;
	for(i=0; i < 32; i = i + 1) begin
		A = (A << 1) | (Dividend[31]);
		Dividend = Dividend << 1;
		if (~A[31]) begin
			A = A + DivisorNeg;
		end
		else if(A[31]) begin
			A = A + Divisor;
		end
		
		if(~A[31]) begin
			Dividend[0] = 1;
		end
		else if(A[31]) begin
			Dividend[0] = 0;
		end
	end
	if(A[31]) begin
		A = A + Divisor;
	end
	quotient = Dividend;
	remainder = A;
	end
endmodule
