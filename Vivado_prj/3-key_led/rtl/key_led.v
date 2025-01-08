module key_led (
    input               sys_clk,
    input               sys_rst_n,
    input      [3:0]    key,
    output reg [3:0]    led     
);

parameter CNT_MAX = 25'd25000000;//计数最大值 0.5s
//parameter CNT_MAX = 25'd25;//计数最大值，500ns 仅用于仿真

reg [24:0] cnt;
reg [1:0]  led_flag;

//计数器计时0.5s
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 0;
    else if(cnt < (CNT_MAX-1))
        cnt <= cnt + 1;
    else
        cnt <= 0;
end

//LED状态切换标志
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led_flag <= 2'd0;
    else if(cnt == (CNT_MAX-1))
        led_flag <= led_flag + 2'd1;
    else
        led_flag <= led_flag;
end

//LED控制（根据哪个按键被按下）
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 0;
    else begin
    case (key)
        4'b1111 : led <= 4'b0000; 
        4'b1110 : begin
            if(led_flag == 0)
                led <= 4'b0001;
            else if(led_flag == 1)
                led <= 4'b0010;
            else if(led_flag == 2)
                led <= 4'b0100;
            else 
                led <= 4'b1000;
        end
        4'b1101: begin
            if(led_flag == 0)
                led <= 4'b1000;
            else if(led_flag == 1)
                led <= 4'b0100;
            else if(led_flag == 2)
                led <= 4'b0010;
            else 
                led <= 4'b0001;
        end
        4'b1011:begin
            if(led_flag[0] == 1'b0)
                led <= 4'b1111;
            else 
                led <= 4'b0000;
        end
        4'b0111: begin
            led <= 4'b1111;
        end
        default: ; //不进行任何操作
    endcase
    end
end

endmodule