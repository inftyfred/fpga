`timescale 1ns / 1ns

module testbench();

parameter CLK_PERIOD = 20;//ns
parameter CNT_MAX = 20'd10;//计时200ns

    // Inputs
    reg sys_clk;
    reg sys_rst_n;
    reg key;

    // Outputs
    wire beep;

    top_beep #(.CNT_MAX(CNT_MAX))
    uut (
        .sys_clk(sys_clk), 
        .sys_rst_n(sys_rst_n), 
        .key(key),
        .beep(beep)
    );

    initial begin
        // Initialize Inputs
        sys_clk <= 0;
        sys_rst_n <= 0;
        key <= 1'b1;
        // Wait for global reset
        #100; 
        // Apply test vectors
        sys_rst_n = 1;
        #200
        key <= 1'b0;//按键按下
        #40
        key <= 1'b1; //按键抖动
        #30
        key <= 1'b0;//抖动结束
        #500
        key <= 1'b1;//松开按键
        #50
        key <=1'b0;//按键抖动
        #1000
        key <= 1'b1;//抖动结束
    end

    always #(CLK_PERIOD/2) sys_clk = ~sys_clk; // Generate clock with period of 10ns

endmodule