module smg_display
(
	input 		 sys_clk,
	input 		 sys_rst_n,
	
	input [19:0] data,		//此处四个输入均是定时器模块的输出
	input [5:0]  point,
	input 		 en,
	input 		 sign,
	
	output reg [5:0] smg_wei,	//位选信号输出，低位控制左边，高位控制右边
	output reg [7:0] smg_duan	//段选信号输出
);

//这两个常量与动态扫描所用的定时器有关，类似于单片机学习时把数码管显示放入的定时器中断
localparam CLK_DIVIDE = 4'd10;	//时钟分频系数，
localparam MAX_NUM	 = 13'd5000;	//时钟计数值，定时1ms，详见语句块代码

reg [3:0]  clk_cnt;		//用于预分频语句块，详见语句块代码
reg        dri_clk;		//分频后的时钟输出，50MHz/10=5MHz
reg [23:0] num;			//每4位存储1个数码管位的数值（bcd码），例：num[3:0]存储个位的数字（0~9）
reg [12:0] cnt0;		//动态扫描定时器的计数器
reg        flag;		//动态扫描定时器的标志信号，每1ms产生一个高电平信号
reg [2:0]  cnt_wei;		//当前显示的位
reg [3:0]  num_display;	//当前数码管显示的数字
reg 	   dot_display;	//当前数码管小数点的显示

wire [3:0] data0;	// 个位数
wire [3:0] data1;	// 十位数
wire [3:0] data2;	// 百位数
wire [3:0] data3;	// 千位数
wire [3:0] data4;	// 万位数
wire [3:0] data5;	// 十万位数

assign  data0 = data % 4'd10;				// 个位数
assign  data1 = data / 4'd10 % 4'd10   ;    // 十位数
assign  data2 = data / 7'd100 % 4'd10  ;    // 百位数
assign  data3 = data / 10'd1000 % 4'd10 ;   // 千位数
assign  data4 = data / 14'd10000 % 4'd10;   // 万位数
assign  data5 = data / 17'd100000;  		// 十万位数

//动态扫描定时器的时钟分频语句块，10分频即5MHz
//分频的原因：上述六个assign语句由于有除法和取余运算，占用时间较长，
//因此，在一个50MHz的系统时钟周期内，无法计算完毕，
//如果后面的数码管显示语句块仍用系统时钟触发，则会产生时序冲突（即没计算完就要显示）
//所以将系统时钟10分频后，产生一个5MHz的时钟来触发显示语句块。经过10个系统时钟周期，已经计算完毕。
always @(posedge sys_clk or negedge sys_rst_n)
begin
	if(sys_rst_n==0)
	begin
		clk_cnt <= 4'd0;
		dri_clk <= 1'b1;
	end
	else if(clk_cnt == CLK_DIVIDE/2 - 1'd1)		//每5个系统时钟脉冲反转一次状态，即每10个系统时钟为一个周期
	begin
		clk_cnt <= 4'd0;
		dri_clk <= ~dri_clk;	//定时器时钟输出
	end
	else
	begin
		clk_cnt <= clk_cnt + 1'b1;	//每个系统时钟脉冲自加1
		dri_clk <= dri_clk;
	end
end

//动态扫描定时器的计数语句块，定时1ms
always @(posedge dri_clk or negedge sys_rst_n)	//注意此处的触发时钟为dri_clk，而不是系统时钟
begin
	if(sys_rst_n==0)
	begin
		cnt0 <= 13'b0;
		flag <= 1'b0;
	end
	else if(cnt0 < MAX_NUM - 1'b1)	//定时1ms,5000*0.2us=1ms
	begin
		cnt0 <= cnt0 + 1'b1;
		flag <= 1'b0;
	end
	else 
	begin
		cnt0 <= 13'b0;
		flag <= 1'b1;	//到达1ms，给出高电平信号
	end
end

//每1ms换下一个位显示，实现动态扫描。
always @(posedge dri_clk or negedge sys_rst_n)
begin
	if(sys_rst_n==0)
		cnt_wei <= 3'b0;
	else if(flag)
	begin
		if(cnt_wei < 3'd5)
			cnt_wei <= cnt_wei + 1'b1;	//每1ms,显示的位号加1
		else
			cnt_wei <= 3'b0;
	end
	else
		cnt_wei<=cnt_wei;
end

always @(posedge sys_clk or negedge sys_rst_n)
begin	
	if(sys_rst_n==0)
		num <= 24'b0;
	else 
	begin
		if(data5 || point[5])	//如果第6位有不为0的值（6位数）或第六位的小数点打开
		begin
			num[23:20] <= data5;  //则依次给6位数码管赋值
			num[19:16] <= data4;
			num[15:12] <= data3;
			num[11:8]  <= data2;
			num[ 7:4]  <= data1;
			num[ 3:0]  <= data0;
		end
		else 
		begin                         
			if (data4 || point[4]) 
			begin //如果显示数据为5位十进制数，则给低5位数码管赋值
				 num[19:0] <= {data4,data3,data2,data1,data0};
				 if(sign)                    
					  num[23:20] <= 4'd11; //如果需要显示负号，则最高位（第6位）为符号位
				 else
					  num[23:20] <= 4'd10; //不需要显示负号时，则第6位不显示任何字符
			end
         	else 
			begin //如果显示数据为4位十进制数，则给低4位数码管赋值
				if (data3 || point[3]) 
				begin
					num[15: 0] <= {data3,data2,data1,data0};
					num[23:20] <= 4'd10; //第6位不显示任何字符
					if(sign)             //如果需要显示负号，则最高位（第5位）为符号位
						num[19:16] <= 4'd11;
					else                 //不需要显示负号时，则第5位不显示任何字符
						num[19:16] <= 4'd10;
				end
				else 
				begin //如果显示数据为3位十进制数，则给低3位数码管赋值
					if (data2 || point[2]) 
					begin
						num[11: 0] <= {data2,data1,data0};
						num[23:16] <= {2{4'd10}};	//第6、5位不显示任何字符
						if(sign)         //如果需要显示负号，则最高位（第4位）为符号位
							num[15:12] <= 4'd11;
						else             //不需要显示负号时，则第4位不显示任何字符
							num[15:12] <= 4'd10;
					end
					else 
					begin //如果显示数据为2位十进制数，则给低2位数码管赋值
						if (data1 || point[1]) 
						begin
							num[ 7: 0] <= {data1,data0};
							num[23:12] <= {3{4'd10}};	//第6、5、4位不显示任何字符
							if(sign)     //如果需要显示负号，则最高位（第3位）为符号位
								num[11:8]  <= 4'd11;
							else         //不需要显示负号时，则第3位不显示任何字符
								num[11:8] <=  4'd10;
						end
						else 
						begin      		 //如果显示数据为1位十进制数，则给最低位数码管赋值
							num[3:0] <= data0;
							num[23:8] <= {4{4'd10}};//第6、5、4、3位不显示任何字符
							if(sign)     //如果需要显示负号，则最高位（第2位）为符号位
								num[7:4] <= 4'd11;
							else         //不需要显示负号时，则第2位不显示任何字符
								num[7:4] <= 4'd10;
						end
					end
				end
            end
        end
    end
end	

always @(posedge dri_clk or negedge sys_rst_n) 
begin
    if(sys_rst_n==0) 
    begin
        smg_wei  <= 6'b111111;     //关闭所有位（位选信号低电平有效）
        num_display <= 4'b0;           
        dot_display <= 1'b1;       //不显示小数点（共阳极数码管，低电平导通）
    end
    else 
    begin
        if(en) 
        begin		//确认数码管已使能
            case (cnt_wei)	//判断当前显示的位
                3'd0 :
                begin
                    smg_wei  <= 6'b011111;     //显示数码管最低位
                    num_display <= num[3:0] ;  //显示的数据
                    dot_display <= ~point[0];  //显示的小数点
                end
                3'd1 :
                begin
                    smg_wei  <= 6'b101111;     //显示数码管第1位
                    num_display <= num[7:4] ;
                    dot_display <= ~point[1];
                end
                3'd2 :
				begin
                    smg_wei  <= 6'b110111;    //显示数码管第2位
                    num_display <= num[11:8];
                    dot_display <= ~point[2];
                end
                3'd3 :
                begin
                    smg_wei  <= 6'b111011;    //显示数码管第3位
                    num_display <= num[15:12];
                    dot_display <= ~point[3];
                end
                3'd4 :
                begin
                    smg_wei  <= 6'b111101;    //显示数码管第4位
                    num_display <= num[19:16];
                    dot_display <= ~point[4];
                end
                3'd5 :
                begin
                    smg_wei  <= 6'b111110;    //显示数码管最高位
                    num_display <= num[23:20];
                    dot_display <= ~point[5];
                end
                default :
                begin
                    smg_wei  <= 6'b111111;
                    num_display <= 4'b0;
                    dot_display <= 1'b1;
                end
            endcase
        end
        else 
        begin
            smg_wei  <= 6'b111111;    //使能信号为0时，所有数码管均不显示
            num_display <= 4'b0;  
            dot_display <= 1'b1;
        end
    end
end

always @ (posedge dri_clk or negedge sys_rst_n) begin
    if (sys_rst_n==0)
        smg_duan <= 8'hc0;
    else 
    begin
        case (num_display)
            4'd0 : smg_duan <= {dot_display,7'b1000000}; //显示数字 0
            4'd1 : smg_duan <= {dot_display,7'b1111001}; //显示数字 1
            4'd2 : smg_duan <= {dot_display,7'b0100100}; //显示数字 2
            4'd3 : smg_duan <= {dot_display,7'b0110000}; //显示数字 3
            4'd4 : smg_duan <= {dot_display,7'b0011001}; //显示数字 4
            4'd5 : smg_duan <= {dot_display,7'b0010010}; //显示数字 5
            4'd6 : smg_duan <= {dot_display,7'b0000010}; //显示数字 6
            4'd7 : smg_duan <= {dot_display,7'b1111000}; //显示数字 7
            4'd8 : smg_duan <= {dot_display,7'b0000000}; //显示数字 8
            4'd9 : smg_duan <= {dot_display,7'b0010000}; //显示数字 9
            4'd10: smg_duan <= 8'b11111111;           //不显示任何字符
            4'd11: smg_duan <= 8'b10111111;           //显示负号(-)
            default: 
                   smg_duan <= {dot_display,7'b1000000};
        endcase
    end
end

endmodule			
