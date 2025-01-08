//按键消抖模块
module key_debounce (
    input wire sys_clk,
    input wire sys_rst_n,
    input wire key,
    output reg key_filter
);

parameter CNT_MAX = 20'd1000000;//计时20ms

reg [19:0] cnt; 
reg key_d0, key_d1;

//对key打两拍
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        key_d0 <= 1'b1;
        key_d1 <= 1'b1;
    end
    else begin
        key_d0 <= key;
        key_d1 <= key_d0;
    end
end

//计时按键变化时间
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        cnt <=20'd0;
    end
    else if(key_d0 != key_d1)begin
        cnt <= CNT_MAX;
    end
    else if(cnt > 20'd0)begin
        cnt <= cnt - 20'd1;
    end
    else
        cnt <= 20'd0;
end

//对key_filter进行赋值
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        key_filter <= 1'b1;
    end
    else if(cnt == 20'd1)begin //说明按键已经稳定
        key_filter <= key_d1;
    end
    else
        key_filter <= key_filter;
end

endmodule