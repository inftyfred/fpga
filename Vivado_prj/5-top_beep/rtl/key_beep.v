module key_beep (
    input wire sys_clk,
    input wire sys_rst_n,
    input wire key_filter, //下降沿代表按键按下
    output reg beep
);

reg key_filter_d0; //打拍

wire neg_key_filter;

assign neg_key_filter = key_filter_d0 & (~key_filter);//两者都为1 说明按键按下

//打1拍
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        key_filter_d0 <= 1'b1;
    end else begin
        key_filter_d0 <= key_filter;
    end
end

//控制蜂鸣器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        beep <= 1'b0;
    end else if(neg_key_filter) begin
        beep <= ~beep; //鸣叫
    end else begin
        beep <= beep;
    end
end

endmodule