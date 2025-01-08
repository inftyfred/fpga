module led_flow  (
    input sys_clk,   //系统时钟
    input sys_rst_n, //系统复位信号
    output reg [3:0] led //led
);

reg [24:0] cnt; //最大24999999 25位

//计时器计时0.5s
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 25'd0;
    else if(cnt < (25'd25000000-25'd1))
        cnt <= cnt + 25'd1;
    else
        cnt <= 25'd0;
end

//LED移位控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 4'b0001;
    else if(cnt == (25'd25000000-25'd1))
        led <= {led[2:0],led[3]};
    else
        led <= led;
end

endmodule