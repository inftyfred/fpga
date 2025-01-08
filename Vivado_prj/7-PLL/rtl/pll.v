module pll (
    input sys_clk,
    input sys_rst_n,

    output clk_100M,
    output clk_50M,
    output clk_25M,
    output clk_100M_180
);

wire locked;
assign rst_n = sys_rst_n & locked; // 当两个信号都为高电平时，模块输出有效

clk_wiz_0 u_clk_wiz_0
(
// Clock out ports
.clk_100M(clk_100M),     // output clk_100M
.clk_100M_180(clk_100M_180),     // output clk_100M_180
.clk_50M(clk_50M),     // output clk_50M
.clk_25M(clk_25M),     // output clk_25M
// Status and control signals
.reset(~sys_rst_n), // input reset 高电平有效
.locked(locked),       // output locked
// Clock in ports
.clk_in1(sys_clk));      // input clk_in1



    
endmodule