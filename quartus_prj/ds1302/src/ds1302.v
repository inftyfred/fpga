/*
	实现功能：主要完成时间寄存器的读写控制，  直接读取或者输入时间数据
	输入写数据请求和需写入的数据 
	或者读数据请求
	当读数据请求时 输出读取的时间
*/
module ds1302(
	input           rst,
	input           clk,
	output          ds1302_ce,
	output          ds1302_sclk,
	inout           ds1302_io,
	input Value_en,			//数码管使能端,使能信号从按键模块中来
	input [3:0]KEY_Value,	//按键值
	input			key1,
	input			key2,
	input           write_time_req,  //上层给出的写请求
	output          write_time_ack,  //返回给上层写完成信号（年月日等所有数据）
	input[7:0]      write_second,
	input[7:0]      write_minute,
	input[7:0]      write_hour,
	input[7:0]      write_date,
	input[7:0]      write_month,
	input[7:0]      write_week,
	input[7:0]      write_year,
	input           read_time_req,	//上层给出的读请求
	output          read_time_ack,	//返回给上层读完成信号（年月日等所有数据）
	output reg[7:0] read_second,	//bcd码存储，高四位代表十位，低四位代表个位
	output reg[7:0] read_minute,
	output reg[7:0] read_hour,
	output reg[7:0] read_date,
	output reg[7:0] read_month,
	output reg[7:0] read_week,
	output reg[7:0] read_year
 
);
localparam S_IDLE         =  0;	//空闲状态
localparam S_WR_WP        =  1;	//写保护
localparam S_WR_SEC       =  2;	//写秒
localparam S_WR_MIN       =  3;	//写分
localparam S_WR_HOUR      =  4;	//写时
//功能拓展
localparam S_WR_MON       =  5;	//写月
localparam S_WR_WEEK      =  6;	//写周
localparam S_WR_YEAR      =  7;	//写年
localparam S_RD_SEC       =  8;
localparam S_RD_MIN       =  9;
localparam S_RD_HOUR      = 10;
localparam S_RD_MON       = 11;
localparam S_RD_WEEK      = 12;
localparam S_RD_YEAR      = 13;
localparam S_RD_DATE      = 15;
localparam S_ACK          = 14;
localparam S_WR_DATE      = 16; //写日
 
reg[4:0] state, next_state;
reg[7:0] read_addr;	//暂存读取数据的地址
reg[7:0] write_addr;	//暂存写入的地址
reg[7:0] write_data;	//暂存写入的数据
wire[7:0] read_data;	//暂存读取的数据
reg cmd_write;			//写命令信号
reg cmd_read;			//读命令信号
wire cmd_read_ack;		//读操作完成信号
wire cmd_write_ack;		//写操作完成信号
assign write_time_ack = (state == S_ACK);
assign read_time_ack = (state == S_ACK);
 
//给cmd_write和cmd_read赋值 
//通过检测目前的状态 
//读时间的状态机  那么cmd_read=1
//写时间的状态机时  cmd_write=1
always@(posedge clk or posedge rst)
begin
	if(rst)
		cmd_write <= 1'b0;
	else if(cmd_write_ack)
		cmd_write <= 1'b0;
	else
		case(state)
			S_WR_WP,
			S_WR_SEC,
			S_WR_MIN,
			S_WR_HOUR,
			S_WR_DATE,
			S_WR_MON,
			S_WR_WEEK,
			S_WR_YEAR:
			cmd_write <= 1'b1;
		endcase
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		cmd_read <= 1'b0;
	else if(cmd_read_ack)
		cmd_read <= 1'b0;
	else
		case(state)
			S_RD_SEC,
			S_RD_MIN,
			S_RD_HOUR,
			S_RD_DATE,
			S_RD_MON,
			S_RD_WEEK,
			S_RD_YEAR:
				cmd_read <= 1'b1;
		endcase
end
 
 
//检测状态机 读数据的时候 将读取的数据赋值给对应的寄存器
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_second <= 8'h02;
	else if(state == S_RD_SEC && cmd_read_ack)
		read_second <= read_data;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_minute <= 8'h01;
	else if(state == S_RD_MIN && cmd_read_ack)
		read_minute <= read_data;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_hour <= 8'h00;
	else if(state == S_RD_HOUR && cmd_read_ack)
		read_hour <= read_data;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_date <= 8'h00;
	else if(state == S_RD_DATE && cmd_read_ack)
		read_date <= read_data;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_month <= 8'h00;
	else if(state == S_RD_MON && cmd_read_ack)
		read_month <= read_data;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_week <= 8'h00;
	else if(state == S_RD_WEEK && cmd_read_ack)
		read_week <= read_data;
end
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_year <= 8'h00;
	else if(state == S_RD_YEAR && cmd_read_ack)
		read_year <= read_data;
end

//按照状态机 给地址赋值
//控制当前要读数据的地址
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_addr <= 8'h00;
	else
		case(state)
				S_RD_SEC:
					read_addr <= 8'h81;
				S_RD_MIN:
					read_addr <= 8'h83;
				S_RD_HOUR:
					read_addr <= 8'h85;
				S_RD_DATE:
					read_addr <= 8'h87;
				S_RD_MON:
					read_addr <= 8'h89;
				S_RD_WEEK:
					read_addr <= 8'h8b;
				S_RD_YEAR:
					read_addr <= 8'h8d;
			default:
				read_addr <= read_addr;
		endcase
end
//按照状态机 给写数据的地址和数据赋值
//控制当前要写数据的地址和数据
always@(posedge clk or posedge rst)
begin
	if(rst)
		begin
			write_addr <= 8'h00;
			write_data <= 8'h00;
		end
	else
		case(state)
			S_WR_WP:
				begin
					write_addr <= 8'h8e;
					write_data <= 8'h00;
				end
			S_WR_SEC:
				begin
					write_addr <= 8'h80;
					write_data <= write_second;
				end
			S_WR_MIN:
				begin
					write_addr <= 8'h82;
					write_data <= write_minute;
				end
			S_WR_HOUR:
				begin
					write_addr <= 8'h84;
					write_data <= write_hour;
				end
			S_WR_DATE:
				begin
					write_addr <= 8'h86;
					write_data <= write_date;
				end
			S_WR_MON:
				begin
					write_addr <= 8'h88;
					write_data <= write_month;
				end
			S_WR_WEEK:
				begin
					write_addr <= 8'h8a;
					write_data <= write_week;
				end
			S_WR_YEAR:
				begin
					write_addr <= 8'h8c;
					write_data <= write_year;
				end
			default:
				begin
					write_addr <= 8'h00;
					write_data <= 8'h00;
				end
		endcase
end
 

//改变状态机
always@(posedge clk or posedge rst)
begin
	if(rst)
		state <= S_IDLE;
	else
		state <= next_state;
end

always@(*)
begin

begin
	case(state)
		S_IDLE:
			if(write_time_req)//写时间请求 
				next_state <= S_WR_WP;
			else if(read_time_req)//读时间请求 
				next_state <= S_RD_SEC;
			else
				next_state <= S_IDLE;
		S_WR_WP://写时间请求 
			if(cmd_write_ack)
				next_state <= S_WR_SEC;//写秒
			else
				next_state <= S_WR_WP;
		S_WR_SEC:
			if(cmd_write_ack)
				next_state <= S_WR_MIN;
			else
				next_state <= S_WR_SEC;
		S_WR_MIN:
			if(cmd_write_ack)
				next_state <= S_WR_HOUR;
			else
				next_state <= S_WR_MIN;
		S_WR_HOUR:
			if(cmd_write_ack)
				next_state <= S_WR_DATE;
			else
				next_state <= S_WR_HOUR;
		S_WR_DATE:
			if(cmd_write_ack)
				next_state <= S_WR_MON;
			else
				next_state <= S_WR_DATE;
		S_WR_MON:
			if(cmd_write_ack)
				next_state <= S_WR_WEEK;
			else
				next_state <= S_WR_MON;
		S_WR_WEEK:
			if(cmd_write_ack)
				next_state <= S_WR_YEAR;
			else
				next_state <= S_WR_WEEK;
		S_WR_YEAR:
			if(cmd_write_ack)
				next_state <= S_ACK;
			else
				next_state <= S_WR_YEAR;
		S_RD_SEC:
			if(cmd_read_ack)
				next_state <= S_RD_MIN;
			else
				next_state <= S_RD_SEC;
		S_RD_MIN:
			if(cmd_read_ack)
				next_state <= S_RD_HOUR;
			else
				next_state <= S_RD_MIN;
		S_RD_HOUR:
			if(cmd_read_ack)
				next_state <= S_RD_DATE;
			else
				next_state <= S_RD_HOUR;
		S_RD_DATE:
			if(cmd_read_ack)
				next_state <= S_RD_MON;
			else
				next_state <= S_RD_DATE;
		S_RD_MON:
			if(cmd_read_ack)
				next_state <= S_RD_WEEK;
			else
				next_state <= S_RD_MON;
		S_RD_WEEK:
			if(cmd_read_ack)
				next_state <= S_RD_YEAR;
			else
				next_state <= S_RD_WEEK;
		S_RD_YEAR:
			if(cmd_read_ack)
				next_state <= S_ACK;
			else
				next_state <= S_RD_YEAR;
		S_ACK:
			next_state <= S_IDLE;
		default:
			next_state <= S_IDLE;
	endcase
end
end
ds1302_io ds1302_io_m0(
	.clk(clk),
	.rst(rst),
	.ds1302_ce(ds1302_ce),
	.ds1302_sclk(ds1302_sclk),
	.ds1302_io(ds1302_io),
	.cmd_read(cmd_read),
	.cmd_write(cmd_write),
	.cmd_read_ack(cmd_read_ack),
	.cmd_write_ack(cmd_write_ack),
	.read_addr(read_addr),
	.write_addr(write_addr),
	.read_data(read_data),
	.write_data(write_data)
);
endmodule