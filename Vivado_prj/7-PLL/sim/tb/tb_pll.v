`timescale 1ns/1ns  // ��λ/����

module tb_pll ();

parameter CLK_PERIOD = 20; //����ʱ�����ڣ������޸�

reg sys_clk; //����20ns
reg sys_rst_n;

wire clk_100M;
wire clk_50M;
wire clk_25M;
wire clk_100M_180;

//��ʼ��
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
end

always #(CLK_PERIOD/2) sys_clk = ~sys_clk; //10ns��תһ�� 50MHz

pll u_pll(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),

    .clk_100M(clk_100M),
    .clk_50M(clk_50M),
    .clk_25M(clk_25M),
    .clk_100M_180(clk_100M_180)
);

endmodule