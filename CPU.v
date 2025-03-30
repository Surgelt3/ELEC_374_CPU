module CPU(
	input clk, reset,
	input [31:0] IN_unit_input, 
	output [31:0] OUT_unit_output
);

	wire [31:0] MAR, BusMuxIn_MDR;
	wire [31:0] OUT_MDR;
	
	wire Read, write_mem;
	
	core c(
		clk, reset,
		IN_unit_input, 
		BusMuxIn_MDR, OUT_MDR,
		Read, write_mem,
		MAR, OUT_unit_output
	);
	
	ram mem_ram(
		.clk(clk), .reset(reset), .read(Read), .write(write_mem), .addr(MAR[8:0]),
		.data_in(BusMuxIn_MDR), .data_out(OUT_MDR)
	);
	
	
endmodule
	