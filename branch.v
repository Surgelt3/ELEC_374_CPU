module branch(
	input[31:0] ir, 
	input[31:0] data,
	output reg out
	);
	
	reg[1:0] C2 = ir[20:19];
	reg[3:0] dec_out;
	reg nor_bus;
	
	decoder2_4(
		.in({C2}),
		.out(dec_out)
	);
	
	always @(*) begin
		nor_bus = ~(data | data);
		
		if(dec_out[0] == 1)
			out = nor_bus & 1;
			
		else if(dec_out[1] == 1)
			out = (~nor_bus) & 1;
			
		else if(dec_out[2] == 1)	
			out = (~data[31]) & 1;
			
		else if(dec_out[3] == 1)
			out = (data[31] & 1);

		
		end
endmodule
		
			
	