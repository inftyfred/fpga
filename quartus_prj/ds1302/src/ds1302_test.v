/*
	功能：实现DS1302的控制。根据三根数据线的操作实现，数据的读取
*/
module ds1302_test(
	input       rst,//复位信号
	input       clk,//时钟信号
	output      ds1302_ce,//DS1302的RST信号
	output      ds1302_sclk,//DS1302的SPI时钟信号
	inout       ds1302_io,//DS1302的数据信号
	input		en,
	input 		key1,
	input		key2,
	input 		key3,
	input 		shift,
	output reg 	beep_flag,
	output reg  pm_flag,	//12h标志
	input Value_en,			//数码管使能端,使能信号从按键模块中来
	input [3:0]KEY_Value,	//按键值	
	input clock_ack,
	output[7:0] read_second,
	output[7:0] read_minute,
	output[7:0] read_hour,
	output[7:0] read_date,
	output[7:0] read_month,
	output[7:0] read_week,
	output[7:0] read_year,
	output reg [7:0] write_second,
	output reg [7:0] write_minute,
	output reg [7:0] write_hour,
	output reg [7:0] adj_hour,
	output reg [7:0] adj_minute,
	output reg [15:0] Max_beep_times,
	output reg clock_en
);
//状态机编号
localparam S_IDLE    =    0;//空闲状态机编号
localparam S_READ    =    1;//读状态机编号
localparam S_WRITE   =    2;//写状态机编号
localparam S_READ_CH =    3;
localparam S_WRITE_CH =   4;
localparam S_WAIT     =   5;
reg[2:0] state,next_state;//等待状态
 
reg write_time_req;	//写请求




//时钟状态机编号
localparam SHOW_TIME     =   0;//
localparam SET_TIME      =   1;//设置状态机编号
localparam STOP_TIME     =   2;//停止机编号
localparam RST_TIME      =   3;//复位
localparam SWITCH_TIME   =   4;//切换24/12
localparam BEEP_TIME     =   5;//闹钟

reg [7:0]mode_state;//时钟状态

//reg write_time_req_latch;
wire write_time_ack;	//写结束
reg read_time_req;		//读请求
wire read_time_ack;		//读结束

//写数据寄存器
reg[7:0] write_second_reg;
reg[7:0] write_minute_reg;
reg[7:0] write_hour_reg;

reg[7:0] write_date_reg;
reg[7:0] write_month_reg;
reg[7:0] write_week_reg;
reg[7:0] write_year_reg;
wire CH;	//ds1302计数使能位

reg clock_en1;
reg clock_en2;
reg clear_flag;
 
assign CH = read_second[7]; //得到计数使能CH位的值

 //标记写请求
always@(posedge clk )
begin
	// if(!rst)
	// 	//write_time_req <= 1'b1;
	if(write_time_ack)
		write_time_req <= 1'b0;
	else if(state == S_WRITE_CH)
		write_time_req <= 1'b1;
	else if(!key3)
	begin
		write_time_req <= 1'b1; //发送修改时间的请求 将write_变量写入DS1302
	end
	else if(!key2)
	begin
		write_time_req <= 1'b1;
		clear_flag <= 1'b1;
	end
	//整点报时功能 响铃数与整点数相同
	else if((read_minute == 8'h00 && read_second == 8'h00 && (en) ) ) //保证是整点     		//|| ((Value_en) && (KEY_Value == 4'd6))
	begin
		//Max_beep_times 控制响铃的次数
		case(write_hour) 
            8'h01: Max_beep_times <= 16'd4;
            8'h02: Max_beep_times <= 16'd8;
            8'h03: Max_beep_times <= 16'd12;
            8'h04: Max_beep_times <= 16'd16;
            8'h05: Max_beep_times <= 16'd20;
            8'h06: Max_beep_times <= 16'd24;
            8'h07: Max_beep_times <= 16'd28;
            8'h08: Max_beep_times <= 16'd32;
            8'h09: Max_beep_times <= 16'd36;
            8'h10: Max_beep_times <= 16'd40;
            8'h11: Max_beep_times <= 16'd44;
            8'h12: Max_beep_times <= 16'd48;
            8'h13: Max_beep_times <= 16'd52;
            8'h14: Max_beep_times <= 16'd56;
            8'h15: Max_beep_times <= 16'd60;
            8'h16: Max_beep_times <= 16'd64;
            8'h17: Max_beep_times <= 16'd68;
            8'h18: Max_beep_times <= 16'd72;
            8'h19: Max_beep_times <= 16'd76;
            8'h20: Max_beep_times <= 16'd82;
            8'h21: Max_beep_times <= 16'd86;
            8'h22: Max_beep_times <= 16'd92;
            8'h23: Max_beep_times <= 16'd96;
            8'h00: Max_beep_times <= 16'd0;
            default:Max_beep_times <= Max_beep_times;
        endcase
		if(write_hour > 8'h00)
			beep_flag <= 1'b1;//触发响铃
	end
	else
	begin
		beep_flag <= 1'b0;
		clear_flag <= 1'b0;
	end
end
 
 //标记读请求
always@(posedge clk)
begin
	if(read_time_ack)
		read_time_req <= 1'b0;
	else if(state == S_READ || state == S_READ_CH)
		read_time_req <= 1'b1;
end

//状态机
always@(posedge clk or posedge rst)
begin
	if(rst)
		state <= S_IDLE;
	else
		state <= next_state;	
end
 

always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
	clock_en1 <= 1'b0;
	end
	else if(Value_en && !en && KEY_Value == 4'd8)  //设定闹钟
	begin
		clock_en1 <= 1'b1;   	//表示闹钟设定标志
		adj_hour   <= write_hour;
		adj_minute <= write_minute;
	end
	else if(clock_en) //关闹钟
	begin
		clock_en1 <= 1'b0;
	end
	else
	begin
	clock_en1 <= clock_en1;
	adj_hour <= adj_hour;
	adj_minute <= adj_minute;
	end
end


always@(posedge clk)
begin
	if((adj_hour == read_hour) && (adj_minute == read_minute) && (en) && (clock_en1))//闹钟触发条件                 //&& (clock_en1)  && (clock_en1)
	begin
		clock_en <= 1'b1; //开启闹钟
	end
	else 
		clock_en <= 1'b0;
end

 
always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		//电子钟复位
		write_second_reg <= 8'h00;//write_second;
		write_minute_reg <= 8'h00;//write_minute;
		write_hour_reg <= 8'h00;//write_hour;
		write_date_reg <= 8'h00;
		write_month_reg <= 8'h00;
		write_week_reg <= 8'h00;
		write_year_reg <= 8'h00;
	end
	else if((state == S_WRITE_CH) || ( (write_time_req) && (!clear_flag) ))		//如果计数未打开，则写入数据并打开计数
	begin
		// write_second_reg <= read_second;	//更换此块代码可以使ds1302从上一次的时间继续计数
		// write_second_reg <= read_minute;
		// write_hour_reg <= read_hour;
		// write_date_reg <= read_date;
		// write_month_reg <= read_month;
		// write_week_reg <= read_week;
		// write_year_reg <= read_year;	
		write_second_reg <= write_second;//
		write_minute_reg <= write_minute;
		write_hour_reg <= write_hour;//
		write_date_reg <= 8'h17;
		write_month_reg <= 8'h10;
		write_week_reg <= 8'h02;
		write_year_reg <= 8'h23;//
	end
	else if(clear_flag && write_time_req)
	begin
		write_second_reg <= 8'h00;//
		write_minute_reg <= 8'h00;
		write_hour_reg <= 8'h00;//
	end
end
 



always@(posedge clk)
begin
	if(Value_en && !en && KEY_Value == 4'd1)
	begin
		begin
		case(write_hour)
		8'h00:write_hour <= 8'h01;
		8'h01:write_hour <= 8'h02;
		8'h02:write_hour <= 8'h03;
		8'h03:write_hour <= 8'h04;
		8'h04:write_hour <= 8'h05;
		8'h05:write_hour <= 8'h06;
		8'h06:write_hour <= 8'h07;
		8'h07:write_hour <= 8'h08;
		8'h08:write_hour <= 8'h09;
		8'h09:write_hour <= 8'h10;
		8'h10:write_hour <= 8'h11;
		8'h11:write_hour <= 8'h12;
		8'h12:write_hour <= 8'h13;
		8'h13:write_hour <= 8'h14;
		8'h14:write_hour <= 8'h15;
		8'h15:write_hour <= 8'h16;
		8'h16:write_hour <= 8'h17;
		8'h17:write_hour <= 8'h18;
		8'h18:write_hour <= 8'h19;
		8'h19:write_hour <= 8'h20;
		8'h20:write_hour <= 8'h21;
		8'h21:write_hour <= 8'h22;
		8'h22:write_hour <= 8'h23;
		8'h23:write_hour <= 8'h00;
		default:write_hour <= 8'h00;
		endcase
		end
	end
	else if(Value_en && !en && KEY_Value == 4'd2)
	begin
		case(write_minute)
		8'h00:write_minute <= 8'h01;
		8'h01:write_minute <= 8'h02;
		8'h02:write_minute <= 8'h03;
		8'h03:write_minute <= 8'h04;
		8'h04:write_minute <= 8'h05;
		8'h05:write_minute <= 8'h06;
		8'h06:write_minute <= 8'h07;
		8'h07:write_minute <= 8'h08;
		8'h08:write_minute <= 8'h09;
		8'h09:write_minute <= 8'h10;
		8'h10:write_minute <= 8'h11;
		8'h11:write_minute <= 8'h12;
		8'h12:write_minute <= 8'h13;
		8'h13:write_minute <= 8'h14;
		8'h14:write_minute <= 8'h15;
		8'h15:write_minute <= 8'h16;
		8'h16:write_minute <= 8'h17;
		8'h17:write_minute <= 8'h18;
		8'h18:write_minute <= 8'h19;
		8'h19:write_minute <= 8'h20;
		8'h20:write_minute <= 8'h21;
		8'h21:write_minute <= 8'h22;
		8'h22:write_minute <= 8'h23;
		8'h23:write_minute <= 8'h24;
		8'h24:write_minute <= 8'h25;
		8'h25:write_minute <= 8'h26;
		8'h26:write_minute <= 8'h27;
		8'h27:write_minute <= 8'h28;
		8'h28:write_minute <= 8'h29;
		8'h29:write_minute <= 8'h30;
		8'h30:write_minute <= 8'h31;
		8'h31:write_minute <= 8'h32;
		8'h32:write_minute <= 8'h33;
		8'h33:write_minute <= 8'h34;
		8'h34:write_minute <= 8'h35;
		8'h35:write_minute <= 8'h36;
		8'h36:write_minute <= 8'h37;
		8'h37:write_minute <= 8'h38;
		8'h38:write_minute <= 8'h39;
		8'h39:write_minute <= 8'h40;
		8'h40:write_minute <= 8'h41;
		8'h41:write_minute <= 8'h42;
		8'h42:write_minute <= 8'h43;
		8'h43:write_minute <= 8'h44;
		8'h44:write_minute <= 8'h45;
		8'h45:write_minute <= 8'h46;
		8'h46:write_minute <= 8'h47;
		8'h47:write_minute <= 8'h48;
		8'h48:write_minute <= 8'h49;
		8'h49:write_minute <= 8'h50;
		8'h50:write_minute <= 8'h51;
		8'h51:write_minute <= 8'h52;
		8'h52:write_minute <= 8'h53;
		8'h53:write_minute <= 8'h54;
		8'h54:write_minute <= 8'h55;
		8'h55:write_minute <= 8'h56;
		8'h56:write_minute <= 8'h57;
		8'h57:write_minute <= 8'h58;
		8'h58:write_minute <= 8'h59;
		8'h59:write_minute <= 8'h00;
		default:write_minute <= 8'h00;
		endcase
	end
	else if(Value_en && !en && KEY_Value == 4'd3)
	begin
		case(write_second)
		8'h00:write_second <= 8'h01;
		8'h01:write_second <= 8'h02;
		8'h02:write_second <= 8'h03;
		8'h03:write_second <= 8'h04;
		8'h04:write_second <= 8'h05;
		8'h05:write_second <= 8'h06;
		8'h06:write_second <= 8'h07;
		8'h07:write_second <= 8'h08;
		8'h08:write_second <= 8'h09;
		8'h09:write_second <= 8'h10;
		8'h10:write_second <= 8'h11;
		8'h11:write_second <= 8'h12;
		8'h12:write_second <= 8'h13;
		8'h13:write_second <= 8'h14;
		8'h14:write_second <= 8'h15;
		8'h15:write_second <= 8'h16;
		8'h16:write_second <= 8'h17;
		8'h17:write_second <= 8'h18;
		8'h18:write_second <= 8'h19;
		8'h19:write_second <= 8'h20;
		8'h20:write_second <= 8'h21;
		8'h21:write_second <= 8'h22;
		8'h22:write_second <= 8'h23;
		8'h23:write_second <= 8'h24;
		8'h24:write_second <= 8'h25;
		8'h25:write_second <= 8'h26;
		8'h26:write_second <= 8'h27;
		8'h27:write_second <= 8'h28;
		8'h28:write_second <= 8'h29;
		8'h29:write_second <= 8'h30;
		8'h30:write_second <= 8'h31;
		8'h31:write_second <= 8'h32;
		8'h32:write_second <= 8'h33;
		8'h33:write_second <= 8'h34;
		8'h34:write_second <= 8'h35;
		8'h35:write_second <= 8'h36;
		8'h36:write_second <= 8'h37;
		8'h37:write_second <= 8'h38;
		8'h38:write_second <= 8'h39;
		8'h39:write_second <= 8'h40;
		8'h40:write_second <= 8'h41;
		8'h41:write_second <= 8'h42;
		8'h42:write_second <= 8'h43;
		8'h43:write_second <= 8'h44;
		8'h44:write_second <= 8'h45;
		8'h45:write_second <= 8'h46;
		8'h46:write_second <= 8'h47;
		8'h47:write_second <= 8'h48;
		8'h48:write_second <= 8'h49;
		8'h49:write_second <= 8'h50;
		8'h50:write_second <= 8'h51;
		8'h51:write_second <= 8'h52;
		8'h52:write_second <= 8'h53;
		8'h53:write_second <= 8'h54;
		8'h54:write_second <= 8'h55;
		8'h55:write_second <= 8'h56;
		8'h56:write_second <= 8'h57;
		8'h57:write_second <= 8'h58;
		8'h58:write_second <= 8'h59;
		8'h59:write_second <= 8'h00;
		default: write_second <= 8'h00;
		endcase
	end
	else if(en) //时钟运行状态
	begin
		if(!shift)	//12h与24h状态切换
		begin
			write_hour <= read_hour;
			write_minute <= read_minute;
			write_second <= read_second;
			pm_flag <= 1'b0;
			clock_en2 <= 1'b1;
		end
		else
		begin
			if(read_hour >= 8'h13)
				pm_flag <= 1'b1;
			else
				pm_flag <= 1'b0;
			case(read_hour)
			8'h13:write_hour <= 8'h01;
			8'h14:write_hour <= 8'h02;
			8'h15:write_hour <= 8'h03;
			8'h16:write_hour <= 8'h04;
			8'h17:write_hour <= 8'h05;
			8'h18:write_hour <= 8'h06;
			8'h19:write_hour <= 8'h07;
			8'h20:write_hour <= 8'h08;
			8'h21:write_hour <= 8'h09;
			8'h22:write_hour <= 8'h10;
			8'h23:write_hour <= 8'h11;
			default:write_hour <= write_hour;
			endcase
			write_minute <= read_minute;
			write_second <= read_second;
			clock_en2 <= 1'b1;
		end
	end
	else if(clock_en1 == 1'b0)
		clock_en2 <= 1'b0;
end


 //
always@(posedge clk)
begin

	case(state)		
		S_IDLE:
				next_state <= S_READ_CH;
		S_READ_CH:	//判断CH位的值，计数是否打开，0—打开，1—关闭
			if(read_time_ack)
				next_state <= CH ? S_WRITE_CH : S_READ;
			else
				next_state <= S_READ_CH;
		S_WRITE_CH:	//如果计数未打开  必要时可以存入当前时间
			if(write_time_ack)
				next_state <= S_WAIT;
			else
				next_state <= S_WRITE_CH;
		S_WAIT:
			next_state <= S_READ;
		S_READ:	//读数据  读出此时的时间，这个时间即使掉电仍然会更新
			if(read_time_ack)
				next_state <= S_IDLE;
			else
				next_state <= S_READ;
		default:
			next_state <= S_IDLE;
	endcase
end
 

ds1302 ds1302_m0(
	.rst(rst),
	.clk(clk),
	.ds1302_ce(ds1302_ce),
	.ds1302_sclk(ds1302_sclk),
	.ds1302_io(ds1302_io),
	.key1(key1),
	.key2(key2),
	.Value_en(Value_en),			//数码管使能端,使能信号从按键模块中来
	.KEY_Value(KEY_Value),			//按键值
	.write_time_req(write_time_req),
	.write_time_ack(write_time_ack),
	.write_second(write_second_reg),
	.write_minute(write_minute_reg),
	.write_hour(write_hour_reg),
	.write_date(write_date_reg),
	.write_month(write_month_reg),
	.write_week(write_week_reg),
	.write_year(write_year_reg),
	.read_time_req(read_time_req),
	.read_time_ack(read_time_ack),
	.read_second(read_second),
	.read_minute(read_minute),
	.read_hour(read_hour),
	.read_date(read_date),
	.read_month(read_month),
	.read_week(read_week),
	//.beep_flag(beep_flag),
	.read_year(read_year)
	
);



endmodule 
