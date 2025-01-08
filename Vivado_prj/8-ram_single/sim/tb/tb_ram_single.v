`timescale 1ns/1ns  // 单位/精度

module tb_ram_single ();

parameter CLK_PERIOD = 20; //定义时钟周期，方便修改

reg sys_clk; //周期20ns
reg sys_rst_n;


//初始化
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
end

always #(CLK_PERIOD/2) sys_clk = ~sys_clk; //10ns翻转一次

ram_single u_ram_single(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n)
);

endmodule