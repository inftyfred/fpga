module seg_scan
(
	input           clk,		  //系统时钟
	input           rst_n,		  //复位信号
	input			en,				//使能信号
	output reg[2:0] seg_sel,      //数码管位选输出
	output reg[7:0] seg_data,     //当前显示位的段选码输出
	input[7:0]      seg_data_0,	  //个位的段选码，由上面的解码器模块得到
	input[7:0]      seg_data_1,	  //十位的段选码
	input[7:0]      seg_data_2,	  //百位的段选码
	input[7:0]      seg_data_3,	  
	input[7:0]      seg_data_4,	  
	input[7:0]      seg_data_5,	  
	input[7:0]      seg_data_6,	 
	input[7:0]      seg_data_7	   
);

parameter SCAN_FREQ = 200;     //扫描频率，此处的扫描频率是指8个位全部扫描一遍的频率，200Hz->5ms
parameter CLK_FREQ = 24_000_000; //时钟频率

parameter SCAN_COUNT = CLK_FREQ /(SCAN_FREQ * 8) - 1;	

reg[31:0] scan_timer;  //动态扫描计数器
reg[3:0]  scan_sel;    //位选计数器

always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		scan_timer <= 32'd0;
		scan_sel <= 4'd0;
	end
	else if(scan_timer >= SCAN_COUNT)	//按位进行扫描显示
	begin
		scan_timer <= 32'd0;
		if(scan_sel == 4'd7)
			scan_sel <= 4'd0;
		else
			scan_sel <= scan_sel + 4'd1;	//每计到1个周期位选数加1，用来显示下一个位
	end
	else
		begin
			scan_timer <= scan_timer + 32'd1;
		end
end

always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		seg_sel <= 3'b111;
		seg_data <= 8'hff;
	end
	else
	begin
		case(scan_sel)
			//个位数码管显示
			4'd0:
			begin
				seg_sel <= 3'd000;	// 最低位为0，即个位显示
				seg_data <= seg_data_0;	// 个位的段选码
			end
			//十位数码管显示
			4'd1:
			begin
				seg_sel <= 3'd001;
				seg_data <= seg_data_1;
			end
			//...
			4'd2:
			begin
				seg_sel <= 3'b010;
				seg_data <= seg_data_2;
			end
			4'd3:
			begin
				seg_sel <= 3'b011;
				seg_data <= seg_data_3;
			end
			4'd4:
			begin
				seg_sel <= 3'b100;
				seg_data <= seg_data_4;
			end
			4'd5:
			begin
				seg_sel <= 3'b101;
				seg_data <= seg_data_5;
			end
            4'd6:
			begin
				seg_sel <= 3'b110;
				seg_data <= seg_data_6;
			end
            4'd7:
			begin
				seg_sel <= 3'b111;
				seg_data <= seg_data_7;
			end
			default:
			begin
				seg_sel <= 3'b000;
				seg_data <= 8'h00;
			end
		endcase
	end
end

endmodule
