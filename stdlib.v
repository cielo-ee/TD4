`timescale 1ns / 1ps
`default_nettype none

module SevenSegmentEncoder(
	in,out
	);
	
	input [3:0] in;
	input [7:0] out;
	
	assign out = sevenSegment(in);
	
	function [7:0] sevenSegment;
		input  [3:0] segIn;
		begin
			case(segIn)
			//                 gfedcba   
				4'h0: sevenSegment = 7'b0111111;
				4'h1: sevenSegment = 7'b0000110;
				4'h2: sevenSegment = 7'b1011011;
				4'h3: sevenSegment = 7'b1001111;
				4'h4: sevenSegment = 7'b1100110;
				4'h5: sevenSegment = 7'b1101101;
				4'h6: sevenSegment = 7'b1111101;
				4'h7: sevenSegment = 7'b0000111;
				4'h8: sevenSegment = 7'b1111111;
				4'h9: sevenSegment = 7'b1101111;
				4'hA: sevenSegment = 7'b1110111;
				4'hB: sevenSegment = 7'b1111100;
				4'hC: sevenSegment = 7'b0111001;
				4'hD: sevenSegment = 7'b1011110;
				4'hE: sevenSegment = 7'b1111001;
				4'hF: sevenSegment = 7'b1110001;
			endcase
		end
	endfunction
endmodule

module prescaler(
	clk_in,
	reset_n,
	clk_out,
	);
	
	input clk_in;
	input reset_n;
	output clk_out;
	
	reg [7:0] interreg;
	assign clk_out = interreg[7];
	
	always @(posedge clk_in or negedge reset_n)
	begin
		if(~reset_n)
			interreg <= 8'h00;
		else
			interreg <= interreg + 1;
	end

endmodule

module normClkGenerator(
	clk_in,
	reset_n,
	clk_out
	);
//	parameter [31:1] param_05Second = 32'h00FBC520; //33MHz‚Å0.5•b
	parameter [31:0] param_05Second = 32'h00000100;
//	parameter [31:0] param_05Second = 32'h00FBC520;

	input clk_in;
	input reset_n;
	output clk_out;
	
	
	reg [31:0] interreg;
	reg clk_out;
	
	always @(posedge clk_in or negedge reset_n)
	begin
		if(~reset_n) begin
			interreg <= 32'h00000000;
			clk_out  <= 1'b0;
		end 
		else if(interreg == param_05Second) begin
		   interreg <= 32'h00000000;
			clk_out  <= ~ clk_out;
		end
		else
			interreg <= interreg + 1;
		end
	
endmodule

