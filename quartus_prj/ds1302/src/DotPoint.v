module DotPoint
(
	input No,
	input clock,
	output reg[15:0] Dot_R,
	output reg[3:0] Dot_C
);

localparam CNT_MAX = 16'd2400;

reg[15:0] count1;
reg[3:0] count;
reg clk;

// always@(posedge clock)
// begin
// 	if(count1 <= CNT_MAX - 1)
// 		count1 <= count + 1'b1;
// 	else
// 	begin
// 		clk <= !clk;
// 		count1 <= 16'd0;
// 	end
// end

always@(posedge clock)
begin
	if(count < 4'hf)
		count <= count +1'b1;
	else
	begin
		count <= 4'h0;
	end
	Dot_C <= count;
end

always@ (posedge clk)
begin
	// if(!No)	// lock;
		case(count)
		/* 1灭 0亮
0x07,0x08,0x10,0x10,0x10,0x08,0x07,0x00,0x10,0x1F,0x11,0x03,0x14,0x18,0x10,0x00,
0xF0,0x08,0x04,0x04,0x04,0x08,0xF0,0x00,0x04,0xFC,0x04,0x80,0x64,0x1C,0x04,0x00,

		*/
			4'h0:Dot_R<=16'b1111111111111111;
			4'h1:Dot_R<=16'b1111111111111111;
			4'h2:Dot_R<=16'b1100000001111111;
			4'h3:Dot_R<=16'b1101111101111111;
			4'h4:Dot_R<=16'b1101111100011111;
			4'h5:Dot_R<=16'b1101111101100111;
			4'h6:Dot_R<=16'b1101111101111011;
			4'h7:Dot_R<=16'b1101111101111101;
			4'h8:Dot_R<=16'b1101111101111101;
			4'h9:Dot_R<=16'b1101111101111011;
			4'ha:Dot_R<=16'b1101111101100111;
			4'hb:Dot_R<=16'b1101111100011111;
			4'hc:Dot_R<=16'b1101111101111111;
			4'hd:Dot_R<=16'b1100000001111111;
			4'he:Dot_R<=16'b1111111111111111;
			4'hf:Dot_R<=16'b1111111111111111;
/* 
//ok
			4'h0:Dot_R=16'b1111000000011111;
			4'h1:Dot_R=16'b1110111111101111;
			4'h2:Dot_R=16'b1101111111110111;
			4'h3:Dot_R=16'b1101111111110111;
			4'h4:Dot_R=16'b1101111111110111;
			4'h5:Dot_R=16'b1110111111101111;
			4'h6:Dot_R=16'b1111000000011111;
			4'h7:Dot_R=16'b1111111111111111;
			4'h8:Dot_R=16'b1101111111110111;
			4'h9:Dot_R=16'b1100000000000111;
			4'ha:Dot_R=16'b1101111101110111;
			4'hb:Dot_R=16'11111110001111111;
			4'hc:Dot_R=16'b1101100111010111;
			4'hd:Dot_R=16'b1100011111100111;
			4'he:Dot_R=16'b1101111111110111;
			4'hf:Dot_R=16'b1111111111111111; */
			
		endcase
	// else if(No)
	// 	case(count)
	// 		4'h0:Dot_R=16'b1111111111111111;
	// 		4'h1:Dot_R=16'b1111111111111111;
	// 		4'h2:Dot_R=16'b1100000001111111;
	// 		4'h3:Dot_R=16'b1101111101111111;
	// 		4'h4:Dot_R=16'b1101111100001111;
	// 		4'h5:Dot_R=16'b1101111101110011;
	// 		4'h6:Dot_R=16'b1101111101111101;
	// 		4'h7:Dot_R=16'b1101111101111110;
	// 		4'h8:Dot_R=16'b1101111101111110;
	// 		4'h9:Dot_R=16'b1101111101111101;
	// 		4'ha:Dot_R=16'b1101111101110011;
	// 		4'hb:Dot_R=16'b1101111101111111;
	// 		4'hc:Dot_R=16'b1101111101111111;
	// 		4'hd:Dot_R=16'b1100000001111111;
	// 		4'he:Dot_R=16'b1111111111111111;
	// 		4'hf:Dot_R=16'b1111111111111111;
	// 	endcase
end
endmodule
