module top_beep (
    input wire sys_clk,
    input wire sys_rst_n,
    input wire key,
    output wire beep
);

parameter CNT_MAX = 20'd1000000;//计时20ms

wire key_filter;

//例化按键消抖模块
key_debounce  #(
    .CNT_MAX(CNT_MAX)
)
u_key_debounce (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .key(key),
    .key_filter(key_filter)
);
//例化蜂鸣器模块
key_beep u_key_beep
(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .key_filter(key_filter),
    .beep(beep)
);

endmodule