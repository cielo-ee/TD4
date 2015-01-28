`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:54:22 01/28/2015 
// Design Name: 
// Module Name:    TD4_boardIF 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TD4_boardIF(
		CLK_I,
		SW1_I,
		
		LED1_O,
		LED2_O,
		LED3_O,
		LED4_O,
		
		//7segID
		SEG_O,
		
		DP1OEN_O,
		DP2OEN_O,
		DP2OEN_O,
		DP3OEN_O
    );

	input CLK_I;
	inpnt LED1_O;
	input LED2_O;
	input LED3_O;
	input LED4_O;
		
		//7segID
	output SEG_O;
		
	output DP1OEN_O;
	output DP2OEN_O;
	output DP2OEN_O;
	output DP3OEN_O;

endmodule
