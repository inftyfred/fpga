//***************************************************************************
//功能：数码管显示
//描述:按键按下的时在数码管中显示
//24MHz
//***************************************************************************
module ShowControl(
	CLK,
	nRST,
	KEY_Value,
	Value_en,
	SEL,
	SEG
);

	input CLK;
	input nRST;
	input Value_en;			//数码管使能端,使能信号从按键模块中来
	input [3:0]KEY_Value;
	output reg [2:0]SEL;		//位选
	output reg [7:0]SEG;		//段选
	
	reg clock_1k;
	reg [14:0]cnt;
	reg [3:0]data_tmp;
	reg [31:0]disp_data;		//显示的数据
	
	//=========产生数码管驱动脉冲=======//
	always @(posedge CLK or negedge nRST)			
		if(!nRST)
			begin
				cnt <= 15'b0;
				clock_1k <= 1'b1;
			end
		else if(cnt == 15'd11_999)			//500微秒为一个时钟周期
			begin
				cnt <= 15'b0;
				clock_1k <= ~clock_1k;
			end
		else
			cnt <= cnt + 1'b1;
			
	//==========更新要显示的数据=========//
	always @(posedge CLK or negedge nRST)
		if(!nRST)
			disp_data <= 32'd0;
		else if(Value_en)
			disp_data <= {disp_data[27:0],KEY_Value};
		else
			disp_data <= disp_data;
			
	//=============位选控制============//
	always @(posedge clock_1k or negedge nRST)
		if(!nRST)
			SEL <= 3'b111;
		else if(SEL == 3'b111)
			SEL <= 3'b000;
		else
			SEL <= SEL + 1'b1;
		
	//=============段选控制============//
	always @(*)
		case(SEL)
				3'b000: data_tmp <= disp_data[31:28];				//逻辑上是最高位，但对应的是开发板(最右边的一位)最低位
				3'b001: data_tmp <= disp_data[27:24];
				3'b010: data_tmp <= disp_data[23:20];
				3'b011: data_tmp <= disp_data[19:16];
				3'b100: data_tmp <= disp_data[15:12];
				3'b101: data_tmp <= disp_data[11:8];
				3'b110: data_tmp <= disp_data[7:4];
				3'b111: data_tmp <= disp_data[3:0];					//逻辑上是最低位，但对应的是开发板(最左边的一位)最高位
		endcase
	
	//=============段选解析============//
	always @(*)
		case(data_tmp)																//共阴数码管
			4'h0: SEG <= 8'h3f;
			4'h1: SEG <= 8'h06;
			4'h2: SEG <= 8'h5b;
			4'h3: SEG <= 8'h4f;
			4'h4: SEG <= 8'h66;
			4'h5: SEG <= 8'h6d;
			4'h6: SEG <= 8'h7d;
			4'h7: SEG <= 8'h07;
			4'h8: SEG <= 8'h7f;
			4'h9: SEG <= 8'h6f;
			4'ha: SEG <= 8'h77;
			4'hb: SEG <= 8'h7c;
			4'hc: SEG <= 8'h39;
			4'hd: SEG <= 8'h5e;
			4'he: SEG <= 8'h79;
			4'hf: SEG <= 8'h71;
		endcase
endmodule
