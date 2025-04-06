module CPU(
	input clk, reset, stop, 
	input [31:0] IN_unit_input, 
	output run,
	output [31:0] OUT_unit_output,
	output [7:0] seg_display_1, seg_display_2
);

	wire [31:0] MAR, BusMuxIn_MDR;
	wire [31:0] OUT_MDR;
	
	wire Read, write_mem;
	
	core c(
		clk, reset, stop,
		IN_unit_input, 
		BusMuxIn_MDR, OUT_MDR,
		Read, write_mem, run, 
		MAR, OUT_unit_output
	);
	
	ram mem_ram(
		.clk(clk), .reset(reset), .read(Read), .write(write_mem), .addr(MAR[8:0]),
		.data_in(BusMuxIn_MDR), .data_out(OUT_MDR)
	);
	
	Seven_Seg_Display_Out seg_disp_1(.outputt(seg_display_1), .clk(clk), .data(OUT_unit_output[3:0]));
	Seven_Seg_Display_Out seg_disp_2(.outputt(seg_display_2), .clk(clk), .data(OUT_unit_output[7:4]));

	
	
endmodule
	