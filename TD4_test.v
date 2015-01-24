`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:08:36 01/20/2015
// Design Name:   TD4_top
// Module Name:   TD4_test.v
// Project Name:  TD4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TD4_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module TD4_test;

	// Inputs
	reg clock;
	reg reset;
	reg [3:0] sw;

	// Outputs
	wire [3:0] LED;

	// Instantiate the Unit Under Test (UUT)
	TD4_top uut (
		.clock(clock), 
		.reset(reset), 
		.sw(sw), 
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		clock <= 0;
		reset <= 1'b0;
		sw    <= 4'b0000;

		// Wait 100 ns for global reset to finish
		#155;
      reset <= 1'b1;
		// Add stimulus here
	end
	
	//clock
	always #100 begin
		clock <= ~clock;
	end
      
endmodule

