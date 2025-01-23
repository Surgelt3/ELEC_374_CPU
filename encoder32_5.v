module encoder32_5(
	input [31:0] in,
	output reg [4:0] out
);

	always @(*) begin
		if(in[1])
			out = 5'b00001;
		else if(in[2])
			out = 5'b00010;
		else if(in[3])
			out = 5'b00011;
		else if(in[4])
			out = 5'b00100;
		else if(in[5])
			out = 5'b00101;
		else if(in[6])
			out = 5'b00110;
		else if(in[7])
			out = 5'b00111;
		else if(in[8])
			out = 5'b01000;
		else if(in[9])
			out = 5'b01001;
		else if(in[10])
			out = 5'b01010;
		else if(in[11])
			out = 5'b01011;
		else if(in[12])
			out = 5'b01100;
		else if(in[13])
			out = 5'b01101;
		else if(in[14])
			out = 5'b01110;
		else if(in[15])
			out = 5'b01111;
		else if(in[16])
			out = 5'b10000;
		else if(in[17])
			out = 5'b10001;
		else if(in[18])
			out = 5'b10010;
		else if(in[19])
			out = 5'b10011;
		else if(in[20])
			out = 5'b10100;
		else if(in[21])
			out = 5'b10101;
		else if(in[22])
			out = 5'b10110;
		else if(in[23])
			out = 5'b10111;
		else if(in[24])
			out = 5'b11000;
		else if(in[25])
			out = 5'b11001;
		else if(in[26])
			out = 5'b11010;
		else if(in[27])
			out = 5'b11011;
		else if(in[28])
			out = 5'b11100;
		else if(in[29])
			out = 5'b11101;
		else if(in[30])
			out = 5'b11110;
		else if(in[31])
			out = 5'b11111;
		else
			out = 5'b00000;
	end

endmodule
