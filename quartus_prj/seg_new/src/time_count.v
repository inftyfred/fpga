module time_count
(
	input             sys_clk,
	input	    	  sys_rst_n,
	
	output reg [19:0] data,		//记录数码管需要显示的数字，
								//6位数码管最大能显示的十进制数为999999,因此需要20位
	output reg [5:0]  point,	//6个位的小数点显示控制，相当于把每个位的小数点段选单独提出来
	output reg        en,		//数码管使能标志
	output reg 		  sign		//正负符号显示标志
);

parameter max_count = 23'd2_400_000;	//计数器定时0.1s，

reg[22:0] count;	//定时器计数器
reg		  change_flag;	//数码管改变信号

//0.1秒计数
always @(posedge sys_clk or negedge sys_rst_n)
begin
	if(sys_rst_n==0)
	begin
		change_flag <= 1'b0;
		count <= 24'b0;
	end
	
	else if(count<max_count-1'b1)
	begin
		count <= count + 1'b1;	//自加1
		change_flag <= 1'b0;
	end
	
	else
	begin
		count <= 24'b0;
		change_flag <= 1'b1;	//计到0.1s，给出改变信号
	end
end

//计数到0.1s，显示值加1
always @(posedge sys_clk or negedge sys_rst_n)
begin
	if(sys_rst_n==0)
	begin
		data  <= 20'b0;			//显示值复位
		point <= 6'b000000;		//关闭所有小数点显示，在数码管显示模块中会对其取反，因此此处低电平为关闭
		en 	<= 1'b0;	
		sign  <= 1'b0;
	end
	else
	begin
		point <= 6'b000000;
		en    <= 1'b1;
		sign  <= 1'b0;
		if(change_flag)
		begin
			if(data<20'd999_999)
				data <= data + 1'b1;	//显示值加1
			else
				data <= 20'b0;
		end
	end
end

endmodule 
