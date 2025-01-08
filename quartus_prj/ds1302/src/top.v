module top(
	input        clk,   		//系统时钟 24MHz
	input        rst_n,			//复位按键
	output       rtc_sclk,		//ds1302时钟线
	output       rtc_ce,		//ds1302片选线
	inout        rtc_data,		//ds1302数据线
    //独立按键和拨码开关输入
    input       key1,
    input       key2,
    input       key3,
    input       key4,
    input       en,
    input       shift,
    //独立按键和拨码开关输入
    input [3:0] KEY_COL,		//矩阵 列
	
	output [3:0]KEY_ROW,		//矩阵 行
	output [2:0] seg_sel,		//数码管位选
	output [7:0] seg_data,		//数码管段选
    output beep //蜂鸣器
);


wire beep_flag;
wire pm_flag;

//从DS1302中读取时、分、秒
wire[7:0] read_second;
wire[7:0] read_minute;
wire[7:0] read_hour;
//表示写入时间
wire[7:0] write_second_reg;
wire[7:0] write_minute_reg;
wire[7:0] write_hour_reg;

wire[7:0] read_date;
wire[7:0] read_month;
wire[7:0] read_week;
wire[7:0] read_year;



wire [7:0] adj_hour;
wire [7:0] adj_minute;
wire clock_en;
wire clock_ack;


wire value_en;
wire [3:0]key_value;		//矩阵键盘值
wire seg_bcd;
wire [15:0]Max_beep_times;




//数码管动态扫描实例化
seg_top seg_bcd_m0(
    .clk          (clk),
    .rst_n        (rst_n),
    .en             (en),
    .pm_flag        (pm_flag),
    .Value_en   (value_en),			//数码管使能端,使能信号从按键模块中来
	.KEY_Value  (key_value),
    .seg_sel      (seg_sel),
    .seg_data     (seg_data),
    .seg_bcd      ({write_hour_reg,4'b1111,write_minute_reg,4'b1111,write_second_reg})	//显示时分秒  read_second
);

//按键调用
KeyValue keyValue1(
    .CLK(clk),
    .nRST(rst_n),
    .KEY_ROW(KEY_ROW), //行
    .KEY_COL(KEY_COL), //列
    .KEY_Value(key_value),//键值
    .Value_en(value_en)  //按键使能
);

//蜂鸣器
beep beep_ins1(
    .clk(clk),  //24MHz
    .rst_n(rst_n),
    .Value_en(value_en),			//数码管使能端,使能信号从按键模块中来
	.KEY_Value(key_value),	//按键值
    .now_time({write_hour_reg}),
    .adj_time({adj_hour,adj_minute}),
    .beep_flag(beep_flag),
    .clock_ack(clock_ack),
    .clock_en(clock_en),
    .Max_beep_times(Max_beep_times),
    .beep(beep)
);


//ds1302模块实例化
ds1302_test ds1302_test_m0(
    .rst         (~rst_n),
    .clk         (clk),
    .ds1302_ce   (rtc_ce),
    .ds1302_sclk (rtc_sclk),
    .ds1302_io   (rtc_data),
    .read_second (read_second),
    .en(en),
    .key1(key1),
    .key2(key2),
    .key3(key3),
    .shift(shift),
    .beep_flag(beep_flag),
    .pm_flag(pm_flag),
    .Value_en    (value_en),
    .KEY_Value   (key_value),
    .read_minute (read_minute),
    .read_hour   (read_hour),
    .read_date   (read_date),
    .read_month  (read_month),
    .read_week   (read_week),
    .read_year   (read_year),
    .write_second(write_second_reg),
    .write_minute(write_minute_reg),
    .write_hour(write_hour_reg),
    .adj_hour(adj_hour),
    .clock_en(clock_en),
    .clock_ack(clock_ack),
    .Max_beep_times(Max_beep_times),
	.adj_minute(adj_minute)
);
endmodule 
