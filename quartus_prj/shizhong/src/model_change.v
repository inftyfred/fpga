module model_change(
    input clk,
    input rst_n,
    input key_in,
    output [1:0] model
);

//------------------------------------------- ģʽ��00��ʱ�ӣ�01�����ӣ�10�����11����ʱ --------------------------------------------------------------------------
    reg [1:0] cnt;

    always@(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            cnt <= 2'd0;
        end
        else if(key_in)  //��������
            cnt <= cnt + 1'b1;   // 00 01 10 11ѭ��
        else 
            cnt <= cnt;
    end 

    assign model = cnt;  //�Ƿ���Ҫ��ʱ���߼�ͬ�������������


endmodule 