module ram(
	input clk, reset, read, write,
	input [8:0] addr,
	input [31:0] data_in,
	output reg [31:0] data_out
);

	reg [31:0] memory [511:0];
	integer i;
	
	initial begin
		#20 $readmemh("C:/\Users/\lucas/\Desktop/\ELEC_374/\mem.mif", memory);
	end
	
	always @(posedge clk) begin
		//if(reset) begin
		//	for (i = 0; i < 512; i=i+1) begin
		//		memory[i] <= 32'b0;
		//	end
		//end
		if(read)
			data_out <= memory[addr];
		else if (write)
			memory[addr] <= data_in;
	end
	
	

endmodule
