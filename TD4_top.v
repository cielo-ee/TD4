`default_nettype none

module TD4_top(
	clock,reset,sw,LED
	);
	
	 input clock,reset;
	 input  [3:0] sw;
	 output [3:0] LED;
	
	 wire [3:0] ip; //instruction pointer
	 wire [7:0] ramdata; //ram�o��
	 
	 TD4_core TD4_core0(
		.clock(clock),
		.reset(reset),
		.sw(sw),
		.LED(LED),
		.ip(ip),
		.ramdata(ramdata)
	 );
	
	ram16 ram16_0(
		.data(ramdata),
		.addr(ip)
	);
	
endmodule

module TD4_core(
		clock,reset,sw,LED,ip,ramdata
    );
	 input clock,reset;
	 input  [3:0] sw;
	 input  [7:0] ramdata;
	 output [3:0] LED;
	 output [3:0] ip;
	 
	 wire selectA;
	 wire selectB;
	 wire carry;
	 
	 wire [3:0] OP;
	 
	 wire [3:0] load;
	 wire [3:0] alu_inA;
	 wire [3:0] alu_out;
	 wire [3:0] Imm;
	 
	 reg CFlag;           //carry flag
	 reg [3:0] reg_outA;
	 reg [3:0] reg_outB;
	 reg [3:0] ip;        //instruction pointer
	 reg [3:0] LED;       //LED out 
	 
	 /* fetch */
 	 assign {OP,Imm}  = ramdata;

	 /* decode */
	 
	 //decorder
	 assign selectA = OP[0] | OP[3];
	 assign selectB = OP[1];
	 assign load    = { ~OP[2] | ~OP[3] | (~OP[0] & CFlag),
							   OP[2] | ~OP[3],
							  ~OP[2] |  OP[3],
                        OP[2] |  OP[3]	};
	  /* execute */
		
     //multiplexer
	  function [3:0] mux;
		input [1:0] sel;
		input [15:0] data;
			begin
				case(sel)
					2'b11: mux = data[15:12];
					2'b10: mux = data[11:8];
					2'b01: mux = data[7:4];
					2'b00: mux = data[3:0];
				endcase
			end
		endfunction
	  
	  assign alu_inA = mux({selectB,selectA},
									{4'b0000,sw,reg_outB,reg_outA});
	  //addr
	  assign {carry,alu_out} = alu_inA + Imm;

	 /* store */

	 always @(posedge clock or negedge reset)
		begin
			if(~reset) begin
				CFlag    <= 1'b0;
				reg_outA <= 4'b0000;
				reg_outB <= 4'b0000;
				LED      <= 4'b0000;
				ip       <= 4'b0000;
			end
			else begin //���Z�b�g�ȊO
				CFlag <= carry;
				if(~load[0]) //reg A
					reg_outA <= alu_out;
				else 
					reg_outA <= reg_outA;
					
				if(~load[1]) //reg B
					reg_outB <= alu_out;
				else
					reg_outB	<= reg_outB;

				if(~load[2]) //out
					LED  <= alu_out;
				else
					LED <= LED;
				if(~load[3]) //instruction pointer
					ip <= alu_out;
				else
					ip <= ip+1;	
			end
	 end
	 	
	//ram

endmodule


module ram16(
		addr,
		data
	);
	input  [3:0] addr;
	output [7:0] data;
	
		 //ram
	reg [7:0] ram [15:0];
	
	assign data = ram[addr];
	
	initial begin
		   ram[0]  <= 8'b10110111; 
			ram[1]  <= 8'b00000001; 
			ram[2]  <= 8'b11100001; 
			ram[3]  <= 8'b00000001; 
			ram[4]  <= 8'b11100011; 
			ram[5]  <= 8'b10110110; 
			ram[6]  <= 8'b00000001; 
			ram[7]  <= 8'b11100110; 
			ram[8]  <= 8'b00000001; 
			ram[9]  <= 8'b11101000; 
			ram[10] <= 8'b10110000; 
			ram[11] <= 8'b10110100; 
			ram[12] <= 8'b00000001;
			ram[13] <= 8'b11101010; 
			ram[14] <= 8'b10111000; 
			ram[15] <= 8'b11111111; 
			/*
			ram[0]  <= 8'b00111100; // mov A 1100 
			ram[1]  <= 8'b00110110; // mov A 0110
			ram[2]  <= 8'b01110011; // mov B 0011
			ram[3]  <= 8'b01111001; // mov B 1001
			ram[4]  <= 8'b00010000; // mov A,B
			ram[5]  <= 8'b00111100; // mov A 1100
			ram[6]  <= 8'b01000000; // mov B,A
			ram[7]  <= 8'b00001100; // add A,1100 
			ram[8]  <= 8'b01010011; // add B,0011 
			ram[9]  <= 8'b00100000; // in  A
			ram[10] <= 8'b01100000; // in  B
			ram[11] <= 8'b10110101; // out 0101
			ram[12] <= 8'b10010000; // out B
//			ram[13] <= 8'b11110000; // jmp 0000 
//       ram[13] <= 8'b11100001; // jnc 0001
			ram[13] <= 8'b00001111; // add A 1111 
			ram[14] <= 8'b11100010; // jnc 0010
         ram[15] <= 8'b10111010; // out 1010 */
		end
	
endmodule