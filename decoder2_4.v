module decoder2_4(
	input [1:0] in,
	output reg [3:0] out
);

	always @(*) begin
		if(in[0] == 0)
			if(in[1] == 0)
				out = 0001;
			else
				out = 0010;
		else
			if(in[1] == 0)
				out = 0100;
			else
				out = 1000;
	end
endmodule