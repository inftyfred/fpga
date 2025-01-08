/*
	功能：完成 DS1302 寄存器读写控制
	状态“S_IDLE”空闲状态，收到读写寄存器请求写进入“S_CE_HIGH”状态，将 CE 拉高，然
	后根据请求类型，进入读（S_READ）或写状态(S_WRITE)。 “S_WRITE”状态下一个状态进入写地址状态“S_WRITE_ADDR”,再进入写数据状态
	“S_WRITE_DATA”，完成一个寄存器的写入，最后应答，拉低 CE。 “S_READ”状态下一个状态进入读地址状态“S_READ_ADDR”,再进入读数据状态
	“S_READ_DATA”，完成一个寄存器的读取，最后应答，拉低 CE。
*/
module ds1302_io(
	input           clk,
	input           rst,
	output          ds1302_ce,
	output          ds1302_sclk,
	inout           ds1302_io,
	input           cmd_read,
	input           cmd_write,
	output          cmd_read_ack,
	output          cmd_write_ack,
	input[7:0]      read_addr,
	input[7:0]      write_addr,
	output reg[7:0] read_data,
	input[7:0]      write_data
);
//状态机编号
localparam S_IDLE         =  0;//空闲状态
localparam S_CE_HIGH      =  1;//拉高CE的状态
localparam S_READ         =  2;//读装态
localparam S_READ_ADDR    =  3;//读地址状态
localparam S_READ_DATA    =  4;//读数据状态
localparam S_WRITE        =  5;//写状态
localparam S_WRITE_ADDR   =  6;//写地址状态
localparam S_WRITE_DATA   =  7;//写数据状态
localparam S_CE_LOW       =  8;//CE拉低状态
localparam S_ACK          =  9;//响应状态
 
reg[3:0] state, next_state;
reg[19:0] delay_cnt;
reg wr_req;			//SPI读写请求触发信号，实例化SPI模块
wire wr_ack;		//SPI操作结束信号，实例化SPI模块
//reg wr_ack_d0;		
reg CS_reg;			//暂存片选信号，实例化SPI模块
wire DCLK;			//SPI的时钟线，实例化SPI模块
wire MOSI;			//SPI的MOSI，实例化SPI模块
wire MISO;			//SPI的MISO，实例化SPI模块
reg[7:0] send_data;			//暂存需要写入的数据，实例化SPI模块
wire[7:0] data_rec;			//暂存读到的数据，实例化SPI模块
reg ds1302_io_dir;			//数据线方向，=0写输出（高阻态），=1读输入
assign ds1302_io = ~ds1302_io_dir ? MOSI : 1'bz;// 读数据的状态为1 那么输出为高阻态  否则输出需要输出的数据    也就是读取数据的时候不能输出数据
assign MISO = ds1302_io;//主机输入从机输出   读取DS1302输出的数据
assign ds1302_sclk = DCLK;
assign cmd_read_ack = (state == S_ACK);//读写的状态都来自于返回的相应状态
assign cmd_write_ack = (state == S_ACK);
//ds1302数据流状态机
always@(posedge clk or posedge rst)
begin
	if(rst)
		state <= S_IDLE;
	else
		state <= next_state;
end
//分配下一个状态
always@(*)
begin
	case(state)
		S_IDLE:	//空闲
			if(cmd_read || cmd_write)//如果读或写使能，将CE拉高 
				next_state <= S_CE_HIGH;
			else
				next_state <= S_IDLE;//如果没有信号 那仍然是空闲状态
		S_CE_HIGH://如果CE拉高了 
			if(delay_cnt == 20'd255)
				next_state <= cmd_read ? S_READ : S_WRITE;//如果延时达到一定时间 那么如果读使能 那么进入到S_READ状态 否者就是写状态
			else
				next_state <= S_CE_HIGH;//没有到时间 那么状态不变
		S_READ://读状态 那么将下一个状态改成读地址
			next_state <= S_READ_ADDR;
		S_READ_ADDR://进入读地址状态  
			if(wr_ack)//如果收到应答  那么结束本状态进入下一个状态
				next_state <= S_READ_DATA;//进入数据接收状态
			else
				next_state <= S_READ_ADDR;//否则进入到读地址状态
		S_READ_DATA://读数据
			if(wr_ack)//如果收到应答  那么结束本状态进入下一个状态
				next_state <= S_ACK;
			else
				next_state <= S_READ_DATA;
		S_WRITE:
			next_state <= S_WRITE_ADDR;
		S_WRITE_ADDR://写地址状态
			if(wr_ack)//如果收到应答  那么结束本状态进入下一个状态
				next_state <= S_WRITE_DATA;//写数据状态
			else
				next_state <= S_WRITE_ADDR;//写地址状态
		S_WRITE_DATA:
			if(wr_ack)//如果收到应答  那么结束本状态进入下一个状态
				next_state <= S_ACK;
			else
				next_state <= S_WRITE_DATA;
		S_ACK://应答信号 CE输出低
			next_state <= S_CE_LOW;
		S_CE_LOW://CE输出低 
			if(delay_cnt == 20'd255)//延时到达一定时间 空闲状态
				next_state <= S_IDLE;
			else
				next_state <= S_CE_LOW;
		default:next_state <= S_IDLE;
	endcase
end


//片选信号控制 //NCS控制
always@(posedge clk or posedge rst)
begin
	if(rst)
		CS_reg <= 1'b0;
	else if(state == S_CE_HIGH)
		CS_reg <= 1'b1;
	else if(state == S_CE_LOW)
		CS_reg <= 1'b0;
end


//片选信号改变后延时
//延时模块 当开始 或者结束状态时候 使用
always@(posedge clk or posedge rst)
begin
	if(rst)
		delay_cnt <= 20'd0;
	else if(state == S_CE_HIGH || state == S_CE_LOW)//改变CE信号进行的延时
		delay_cnt <= delay_cnt + 20'd1;
	else
		delay_cnt <= 20'd0;
end
//如果是读数据 写数据的过程中 进行数据的请求
always@(posedge clk or posedge rst)
begin
	if(rst)
		wr_req <= 1'b0;
	else if(wr_ack)
		wr_req <= 1'b0;
	else if(state == S_READ_ADDR || state == S_READ_DATA || state == S_WRITE_ADDR || state == S_WRITE_DATA)
		wr_req <= 1'b1;	//该四种状态需要触发SPI驱动
end

//给IO输出赋值 如果是读数据的状态 赋值为1
////改变数据口方向
always@(posedge clk or posedge rst)
begin
	if(rst)
		ds1302_io_dir <= 1'b0;
	else
		ds1302_io_dir <= (state == S_READ_DATA);
end



//将通信之后的获取数据  data_rec  保存下来 改变顺序
always@(posedge clk or posedge rst)
begin
	if(rst)
		read_data <= 8'h00;
	else if(state == S_READ_DATA && wr_ack)
		read_data <= {data_rec[0],data_rec[1],data_rec[2],data_rec[3],data_rec[4],data_rec[5],data_rec[6],data_rec[7]};
end
 
//需要发送的数据赋值
always@(posedge clk or posedge rst)
begin
	if(rst)
		send_data <= 8'h00;
	else if(state == S_READ_ADDR)//发送读地址指令的状态时
		send_data <= {1'b1,read_addr[1],read_addr[2],read_addr[3],read_addr[4],read_addr[5],read_addr[6],1'b1};
	else if(state == S_WRITE_ADDR)//发送写数据的地址状态时
		send_data <= {1'b0,write_addr[1],write_addr[2],write_addr[3],write_addr[4],write_addr[5],write_addr[6],1'b1};
	else if(state == S_WRITE_DATA)//发送要写的数据时候
		send_data <= {write_data[0],write_data[1],write_data[2],write_data[3],write_data[4],write_data[5],write_data[6],write_data[7]};
end
spi_master spi_master_m0(
	.sys_clk(clk),
	.rst(rst),
	.nCS(ds1302_ce),
	.DCLK(DCLK),
	.MOSI(MOSI),
	.MISO(MISO),
	.CPOL(1'b0),
	.CPHA(1'b0),
	.nCS_ctrl(CS_reg),
	.clk_div(16'd50),
	.wr_req(wr_req),
	.wr_ack(wr_ack),
	.data_in(send_data),
	.data_out(data_rec)
);
endmodule