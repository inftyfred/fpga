module pwm_led (
    input wire sys_clk,       // Clock input
    input wire sys_rst_n,       // Reset input
    output reg led        // LED output
);

parameter CNT_2US = 7'd100;
parameter CNT_2MS = 10'd1000;
parameter CNT_2S = 10'd1000;

//计时器
reg [6:0] cnt_2us;//0-99
reg [9:0] cnt_2ms;//0-999
reg [9:0] cnt_2s;//0-999


reg direction;//1代表递减，0代表递增

//2us计时器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        cnt_2us <= 0;
    end else begin
        if(cnt_2us < CNT_2US-1) begin
            cnt_2us <= cnt_2us + 1;
        end else begin
            cnt_2us <= 0;
        end
    end
end

//2ms计时器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        cnt_2ms <= 0;
    end else if((cnt_2us == (CNT_2US - 1)) && (cnt_2ms == (CNT_2MS-1))) begin
        cnt_2ms <= 0;
    end else if(cnt_2us == (CNT_2US - 1)) begin
        cnt_2ms <= cnt_2ms + 1;
    end
    else begin
        cnt_2ms <= cnt_2ms;
    end
end

//2s计时器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        cnt_2s <= 0;
    end else if((cnt_2us == (CNT_2US - 1)) && (cnt_2ms == (CNT_2MS - 1)) && (cnt_2s == (CNT_2S-1))) begin
        cnt_2s <= 0;
    end else if(cnt_2ms == (CNT_2MS - 1) && cnt_2us == (CNT_2US - 7'b1)) begin
        cnt_2s <= cnt_2s + 1;
    end
    else begin
        cnt_2s <= cnt_2s;
    end
end

//亮度变换
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        direction <= 0;
    end
    else if(cnt_2s == (CNT_2S - 10'b1) && cnt_2ms ==( CNT_2MS - 10'b1) && cnt_2us == (CNT_2US - 7'b1)) begin
        direction <= ~direction;
    end
    else begin
        direction <= direction;
    end
end

//控制LED PWM输出
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        led <= 0;
    end
    else if(direction == 1'b0 && cnt_2ms <= cnt_2s) begin
        led <= 1;
    end
    else if(direction == 1'b1 && cnt_2ms >= cnt_2s) begin
        led <= 1;
    end
    else begin
        led <= 0;
    end
end


// ila_0 u_ila_0 (
// 	.clk(sys_clk), // input wire clk


// 	.probe0(sys_rst_n), // input wire [0:0]  probe0  
// 	.probe1(led), // input wire [0:0]  probe1 
// 	.probe2(cnt_2us), // input wire [6:0]  probe2 
// 	.probe3(cnt_2ms), // input wire [9:0]  probe3 
// 	.probe4(cnt_2s), // input wire [9:0]  probe4 
// 	.probe5(direction) // input wire [0:0]  probe5
// );


endmodule