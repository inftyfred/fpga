module spi_master(
	input                       sys_clk,	
	input                       rst,
	output                      nCS,       //SPI片选输出信号 
	output                      DCLK,      //SPI时钟
	output                      MOSI,      //SPI的MOSI，主机发送
	input                       MISO,      //SPI的MISO，主机接收
	input                       CPOL,		//SPI极性，=0表示时钟空闲低电平；=1表示时钟空闲高电平
	input                       CPHA,		//SPI相位，=0表示第一个边沿触发，=1表示第二个边沿触发
	input                       nCS_ctrl,	//片选控制
	input[15:0]                 clk_div,	//时钟分频
	input                       wr_req,		//写请求触发信号
	output                      wr_ack,		//传输结束反馈信号
	input[7:0]                  data_in,	//要写的数据
	output[7:0]                 data_out	//读到的数据
);

localparam                   IDLE            = 0;		//空闲状态
localparam                   DCLK_EDGE       = 1;		//时钟产生边沿状态
localparam                   DCLK_IDLE       = 2;		//时钟空闲（等待）状态
localparam                   ACK             = 3;		//返回结束信号状态
localparam                   LAST_HALF_CYCLE = 4;		//最后一个边沿状态
localparam                   ACK_WAIT        = 5;

reg                          DCLK_reg;					//暂存时钟输出信号
reg[7:0]                     MOSI_shift;				//暂存要写的数据
reg[7:0]                     MISO_shift;				//暂存读到的数据
reg[2:0]                     state;						//当前状态
reg[2:0]                     next_state;				//下一个状态
reg [15:0]                   clk_cnt;					//时钟等待计数器
reg[4:0]                     clk_edge_cnt;				//时钟边沿计数器

assign MOSI = MOSI_shift[7];							//输出最高位
assign data_out = MISO_shift;							//读到的数据输出
assign nCS = nCS_ctrl;									//片选控制直接由输入转到输出
assign DCLK = DCLK_reg;									//时钟寄存后输出
	
assign wr_ack = (state == ACK);							//获得传输结束信号

//SPI时钟线CLK状态机
always@(posedge sys_clk or posedge rst)
begin
	if(rst)
		state <= IDLE;
	else
		state <= next_state;
end

always@(*)
begin
	case(state)
		IDLE: //SPI空闲状态
			if(wr_req == 1'b1)
				next_state <= DCLK_IDLE;
			else
				next_state <= IDLE;
		DCLK_IDLE: //触发后，时钟先等待clk_div个系统时钟周期
			if(clk_cnt == clk_div)
				next_state <= DCLK_EDGE;
			else
				next_state <= DCLK_IDLE;
		DCLK_EDGE: //SPI时钟线开始产生8个时钟脉冲，每个系统时钟上升沿改变一次SPI时钟电平
			if(clk_edge_cnt == 5'd15)	//当计到第15个边沿时进入下一个状态，此时还差最后一个边沿
				next_state <= LAST_HALF_CYCLE;
			else
				next_state <= DCLK_IDLE;	
		LAST_HALF_CYCLE:	//准备最后一个边沿状态
			if(clk_cnt == clk_div)	//时钟等待clk_div个系统时钟周期
				next_state <= ACK;
			else
				next_state <= LAST_HALF_CYCLE; 	
		ACK: 	//响应状态
			next_state <= ACK_WAIT;
				//等待一个系统时钟周期，确定结束信号
		ACK_WAIT:
			next_state <= IDLE;
		default:
			next_state <= IDLE;
	endcase
end

//SPI时钟线产生时钟脉冲
always@(posedge sys_clk or posedge rst)
begin
	if(rst)
		DCLK_reg <= 1'b0;
	else if(state == IDLE)
		DCLK_reg <= CPOL;				//空闲时时钟恢复空闲极性
	else if(state == DCLK_EDGE)			//SPI时钟线每个系统时钟上升沿改变一次电平，产生时钟脉冲
		DCLK_reg <= ~DCLK_reg;			//相当于系统时钟的2分频
end

//SPI时钟线等待时间计数（传输开始和结束时使用）
always@(posedge sys_clk or posedge rst)
begin
	if(rst)
		clk_cnt <= 16'd0;
	else if(state == DCLK_IDLE || state == LAST_HALF_CYCLE) 
		clk_cnt <= clk_cnt + 16'd1;
	else
		clk_cnt <= 16'd0;
end

//SPI时钟边沿个数计数器
always@(posedge sys_clk or posedge rst)
begin
	if(rst)
		clk_edge_cnt <= 5'd0;
	else if(state == DCLK_EDGE)	//CLK每改变一次电平计数器加1
		clk_edge_cnt <= clk_edge_cnt + 5'd1;
	else if(state == IDLE)
		clk_edge_cnt <= 5'd0;
end


//SPI写数据
always@(posedge sys_clk or posedge rst)
begin
	if(rst)
		MOSI_shift <= 8'd0;
	else if(state == IDLE && wr_req)
		MOSI_shift <= data_in;			//一旦触发立即把要写的数据传递到寄存器
	else if(state == DCLK_EDGE)			//工作在边沿触发状态
		if(CPHA == 1'b0 && clk_edge_cnt[0] == 1'b1)	//第一个边沿触发且第二个边沿刚好到来（因此还未加1）
			MOSI_shift <= {MOSI_shift[6:0],MOSI_shift[7]};	//准备下一位，把第6高位调到最高位
		else if(CPHA == 1'b1 && (clk_edge_cnt != 5'd0 && clk_edge_cnt[0] == 1'b0)) //每个CLK的第二个边沿
			MOSI_shift <= {MOSI_shift[6:0],MOSI_shift[7]};
end

//SPI读数据，流程与写数据类似
always@(posedge sys_clk or posedge rst)
begin
	if(rst)
		MISO_shift <= 8'd0;
	else if(state == IDLE && wr_req)
		MISO_shift <= 8'h00;
	else if(state == DCLK_EDGE)
		if(CPHA == 1'b0 && clk_edge_cnt[0] == 1'b0)	//此处的if判断还未理解
			MISO_shift <= {MISO_shift[6:0],MISO};		//把刚读到的位放到最低位
		else if(CPHA == 1'b1 && (clk_edge_cnt[0] == 1'b1))
			MISO_shift <= {MISO_shift[6:0],MISO};
end
endmodule 

