module led_flow  (
    input sys_clk,   //ϵͳʱ��
    input sys_rst_n, //ϵͳ��λ�ź�
    output reg [3:0] led //led
);

reg [24:0] cnt; //���24999999 25λ

//��ʱ����ʱ0.5s
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        cnt <= 25'd0;
    else if(cnt < (25'd25000000-25'd1))
        cnt <= cnt + 25'd1;
    else
        cnt <= 25'd0;
end

//LED��λ����
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 4'b0001;
    else if(cnt == (25'd25000000-25'd1))
        led <= {led[2:0],led[3]};
    else
        led <= led;
end

endmodule