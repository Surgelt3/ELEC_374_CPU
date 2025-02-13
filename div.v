module div(
    input [31:0] Q, M, 
    output reg [31:0] remainder, quotient
);
reg [31:0] A;
reg [31:0] Dividend;
reg [31:0] Divisor;
reg [31:0] DivisorNeg;
integer i;

always @(*) begin
	A = {32{1'b0}};
	
	if (Q[31])
		Dividend = ~Q + 1'b1;
	else
		Dividend = Q;
	if (M[31])
		Divisor = ~M + 1'b1;
	else
		Divisor = M;
	
	
	DivisorNeg = ~Divisor + 1'b1;
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
	
	
	if (M[31] ^ Q[31])
		quotient = ~Dividend + 1'b1;
	else
		quotient = Dividend;
	remainder = A;
	end
endmodule