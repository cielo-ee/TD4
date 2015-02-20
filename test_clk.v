`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:40:22 02/20/2015
// Design Name:   normClkGenerator
// Module Name:   E:/home/syu/Xilinx/TD4/test_clk.v
// Project Name:  TD4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: normClkGenerator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns
`default_nettype none


module test_clk;

	// Inputs
	reg clk_in;
	reg reset_n;

	// Outputs
	wire clk_out;

	// Instantiate the Unit Under Test (UUT)
	normClkGenerator uut (
		.clk_in(clk_in), 
		.reset_n(reset_n), 
		.clk_out(clk_out)
	);

	initial begin
		// Initialize Inputs
		clk_in    <= 1'b0;
		reset_n   <= 1'bX;

		// Wait 100 ns for global reset to finish
		#100;
		reset_n <= 1'b0;
		#100
		reset_n <= 1'b1;

		// Add stimulus here

	end
	
	always #10 begin
		clk_in <= ~clk_in;
	end
      
endmodule

