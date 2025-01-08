`timescale 1ns/1ns

module tb_pwm_led();

parameter CLOCK_PERIOD = 20;//ns

parameter CNT_2US = 2;
parameter CNT_2MS = 10;
parameter CNT_2S = 10;

reg sys_clk;
reg sys_rst_n;

wire led;


initial begin
    sys_clk <= 0;
    sys_rst_n <= 0;
    #100
    sys_rst_n <= 1;
end

always begin
    #(CLOCK_PERIOD/2) sys_clk = ~sys_clk;
end

pwm_led #(.CNT_2US(CNT_2US), .CNT_2MS(CNT_2MS), .CNT_2S(CNT_2S))
u_pwm_led(
    .sys_clk(sys_clk),           // Clock input
    .sys_rst_n(sys_rst_n),       // Reset input
    .led(led)                    // LED output
);



endmodule