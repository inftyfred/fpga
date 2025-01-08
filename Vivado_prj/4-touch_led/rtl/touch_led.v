module touch_led (
    input       sys_clk,
    input       sys_rst_n,
    input       touch_key,
    output reg  led
);

//打拍
reg touch_key_d0;
reg touch_key_d1;

//按键上升沿
wire pos_touch_key;

always @(posedge touch_key or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 1'b0;
    else
        led <= ~led;
end


// //组合逻辑 使用assign
// //采上升沿
// assign pos_touch_key = ~touch_key_d1 & touch_key_d0;

// //打两拍
// always @(posedge sys_clk or negedge sys_rst_n) begin
//     if(!sys_rst_n) begin
//         touch_key_d0 <= 1'b0;
//         touch_key_d1 <= 1'b0;
//     end
//     else begin
//         touch_key_d0 <= touch_key;
//         touch_key_d1 <= touch_key_d0;
//     end
// end

// //LED信号翻转
// always @(posedge sys_clk or negedge sys_rst_n) begin
//     if(!sys_rst_n) begin
//         led <= 1'b1;
//     end
//     else if(pos_touch_key) begin
//         led <= ~led;
//     end
//     else
//         led <= led;
// end
    
endmodule