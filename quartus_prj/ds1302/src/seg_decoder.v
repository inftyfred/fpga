module seg_decoder
(
	input[3:0]      bin_data,     // 数码管一个位的数据
	input en,
	output reg[6:0] seg_data      // 数码管的段码
);

always@(*)
begin
	case(bin_data)	//数字判断（0~f）
		4'd0:seg_data <= 7'b011_1111;
		4'd1:seg_data <= 7'b000_0110;
		4'd2:seg_data <= 7'b101_1011;
		4'd3:seg_data <= 7'b100_1111;
		4'd4:seg_data <= 7'b110_0110;
		4'd5:seg_data <= 7'b110_1101;
		4'd6:seg_data <= 7'b111_1101;
		4'd7:seg_data <= 7'b000_0111;
		4'd8:seg_data <= 7'b111_1111;
		4'd9:seg_data <= 7'b110_1111;
		4'ha:seg_data <= 7'b111_0111;
		4'hb:seg_data <= 7'b111_1100;
		4'hc:seg_data <= 7'b011_1001;
		4'hd:seg_data <= 7'b101_1110;
		4'he:seg_data <= 7'b111_1001;
		4'hf:seg_data <= 7'b111_0001;
		default:seg_data <= 7'b000_000;
	endcase
end
endmodule
