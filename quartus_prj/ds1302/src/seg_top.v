module seg_top(
	input clk,
	input rst_n,
	input Value_en,			//数码管使能端,使能信号从按键模块中来
	input en,
	input pm_flag,
	input [3:0]KEY_Value,
	output[2:0]  seg_sel,		//数码管位选
	output[7:0]  seg_data,		//数码管段选
	input [31:0] seg_bcd		//需要显示的数据
);


//实例化解码器模块。对数据解码，转换成数码管段选。每四位一个数据。(bcd码)
wire[6:0] seg7_data_0;
seg_decoder seg_decoder_m0(
	.bin_data(seg_bcd[31:28]),
	.en(en),
	.seg_data(seg7_data_0)
);
wire[6:0] seg7_data_1;
seg_decoder seg_decoder_m1(
	.bin_data(seg_bcd[27:24]),
	.en(en),
	.seg_data(seg7_data_1)
);
wire[6:0] seg7_data_2;
seg_decoder seg_decoder_m2(
	.bin_data(seg_bcd[23:20]),
	.en(en),
	.seg_data(seg7_data_2)
);
wire[6:0] seg7_data_3;
seg_decoder seg_decoder_m3(
	.bin_data(seg_bcd[19:16]),
	.en(en),
	.seg_data(seg7_data_3)
);
wire[6:0] seg7_data_4;
seg_decoder seg_decoder_m4(
	.bin_data(seg_bcd[15:12]),
	.en(en),
	.seg_data(seg7_data_4)
);

wire[6:0] seg7_data_5;
seg_decoder seg_decoder_m5(
	.bin_data(seg_bcd[11:8]),
	.en(en),
	.seg_data(seg7_data_5)
);

wire[6:0] seg7_data_6;
seg_decoder seg_decoder_m6(
	.bin_data(seg_bcd[7:4]),
	.en(en),
	.seg_data(seg7_data_6)
);

wire[6:0] seg7_data_7;
seg_decoder seg_decoder_m7(
	.bin_data(seg_bcd[3:0]),
	.en(en),
	.seg_data(seg7_data_7)
);



wire[7:0] seg_data_0;
wire[7:0] seg_data_1;
wire[7:0] seg_data_2;
wire[7:0] seg_data_3;
wire[7:0] seg_data_4;
wire[7:0] seg_data_5;
wire[7:0] seg_data_6;
wire[7:0] seg_data_7;

assign seg_data_0 = {1'b0,seg7_data_0};			//最高位为小数点，共yin极数码管，高电平熄灭
assign seg_data_1 = {pm_flag,seg7_data_1};
assign seg_data_2 = {1'b0,7'b100_0000};	//seg7_data_2
assign seg_data_3 = {1'b0,seg7_data_3};
assign seg_data_4 = {1'b0,seg7_data_4};
assign seg_data_5 = {1'b0,7'b100_0000}; //seg7_data_5
assign seg_data_6 = {1'b0,seg7_data_6};
assign seg_data_7 = {1'b0,seg7_data_7};

//实例化动态扫描模块
seg_scan seg_scan_m0(
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.seg_sel(seg_sel),
	.seg_data(seg_data),
	.seg_data_0(seg_data_0),
	.seg_data_1(seg_data_1),
	.seg_data_2(seg_data_2),
	.seg_data_3(seg_data_3),
	.seg_data_4(seg_data_4),
	.seg_data_5(seg_data_5),
	.seg_data_6(seg_data_6),
	.seg_data_7(seg_data_7)
);
endmodule 
