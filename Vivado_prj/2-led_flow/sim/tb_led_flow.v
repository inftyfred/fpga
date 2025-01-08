`timescale 1ns/1ns  // ��λ/����

module tb_led_flow ();

parameter CLK_PERIOD = 20; //����ʱ�����ڣ������޸�

reg sys_clk; //����20ns
reg sys_rst_n;

wire [3:0] led;

//��ʼ��
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
end

always #(CLK_PERIOD/2) sys_clk = ~sys_clk; //10ns��תһ��

led_flow u_led_flow(
    .sys_clk    (sys_clk),
    .sys_rst_n  (sys_rst_n),
    .led        (led)
);

endmodule