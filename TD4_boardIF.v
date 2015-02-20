`timescale 1ns / 1ps
`default_nettype none

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
		DP3OEN_O,
		DP4OEN_O
    );
	 

	input CLK_I;
	input SW1_I;
	
	output LED1_O;
	output LED2_O;
	output LED3_O;
	output LED4_O;
		
		//7segID
	output reg [8:1] SEG_O;
		
	output DP1OEN_O;
	output DP2OEN_O;
	output DP3OEN_O;
	output DP4OEN_O;
	
	wire TD4_CLK;
	wire [3:0] LED;
	assign {LED4_O,LED3_O,LED2_O,LED1_O} = LED;
	
	//‰¼
	assign DP1OEN_O = 1'b0;
	assign DP2OEN_O = 1'b0;
	assign DP3OEN_O = 1'b0;
	assign DP4OEN_O = 1'b0;
	
	wire   CLK2_I;
	assign CLK2_I = CLK_I;
	
	//‰¼
	always @(negedge SW1_I)
	begin
		SEG_O <= 8'b00000000;
	end
	
	
	//clock‚ð1Hz‚É•ÏŠ·
	normClkGenerator clkgen(
		.clk_in(CLK2_I),
		.reset_n(SW1_I),
		.clk_out(TD4_CLK)
	);

	wire [3:0] sw;
	assign sw = 4'b000; //‰¼
	//TD4‚ÆÚ‘±
	TD4_top td4_0(
		.clock(TD4_CLK),
		.reset(SW1_I),
		.sw(sw),
		.LED(LED)
	);

endmodule
