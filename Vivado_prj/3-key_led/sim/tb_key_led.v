`timescale 1ns/1ns
module tb_key_led ();

parameter CLK_PERIOD = 20;

reg sys_clk;
reg sys_rst_n;
reg [3:0] key;

wire [3:0] led;

initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b0;
    key <= 4'b1111;
    #200
    sys_rst_n <= 1'b1;
    #2000
    key <= 4'b1110;//按下key0
    #2000
    key <= 4'b1111;//松开
    #2000
    key <= 4'b1101;
    #2000
    key <= 4'b1111;
    #2000
    key <= 4'b1011;
    #2000
    key <= 4'b1111;
    #2000
    key <= 4'b0111;
    #2000
    key <= 4'b1111;
end

always #(CLK_PERIOD/2) sys_clk = ~sys_clk;
  
key_led u_key_led(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .key(key),
    .led(led)     
);


endmodule