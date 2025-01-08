//---- key1 ���ڣ�ʱ���л�
//---- key2 ģʽ�л� ��ʱ����ʾ��У׼ʱ�䣬���ӣ� ���
//---- key3 ��ʱ����������ʱ��Сʱ�����������В�
//---- key4 +1 
//---- key5 -1
//---- key6 �����ͣ����ʼ���л�
//---- key7 ������

module key_module(
    input clk,
    input rst_n,
    input [6:0] key_in,
    
    output reg date_time_ch,      //ʱ��������л���־λ��0Ϊʱ�䣬1Ϊ����
    output [1:0] model,            //ģʽ��00��ʱ�ӣ�01�����ӣ�10�����11����ʱ
    output reg [1:0] adjust_shif,  //����ʱ��ʱ������λ�ã�00�����λ��01���ָ�λ��10��ʱ��λ
    output key_up,                 //����ʱ��+
    output key_down,               //����ʱ��-
    output reg pause,                  //�����ͣ/��ʼ  0����ͣ��1����ʼ
    output clear                  //������
);

//-------------------------------------- ����key_filter,����������Ӧ�ĸߵ�ƽ���� ----------------------------------------------------------------
    wire [6:0] key_out;
    genvar i;
    generate
        for(i = 0; i < 7; i = i + 1) begin: specify7_key_filter  //����
            key_filter fliter1(
                         .clk        (clk),
                         .rst_n      (rst_n),
                         .key_in     (key_in[i]),
                         .key_state  (),
                         .key_flag   (key_out[i])
                    );
        
        end 
    endgenerate  
   
    assign key_up   = key_out[3];
    assign key_down = key_out[4];
    assign clear    = key_out[6];
//-------------------------------------------- ���� model_change -------------------------------------------------------------------------------------------    
    model_change model1(
                    .clk    (clk),
                    .rst_n  (rst_n),
                    .key_in (key_out[1]),
                    .model  (model)
                );
//-------------------------------------------- adjust_shif ����ʱ��λ�� ------------------------------------------------------------------------------------
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            adjust_shif <= 2'b00;
        end 
        else begin
            if(key_out[2]) begin
                adjust_shif <= adjust_shif + 1'b1;  //��������ֵ����Ҫ�����̿�����Ÿ���ֵ������ adjust_shif == 2'b10��������11
                if(adjust_shif == 2'b10) 
                    adjust_shif <= 2'b00;
            end              
            if(key_out[1])                        // modelģʽ�ı�ʱ���ص���ʼλ
                adjust_shif <= 2'b00;
        end 
    end
//--------------------------------------------- date_time_ch ʱ��������л���־λ---------------------------------------------------------------------------------------------------------------    
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n)
            date_time_ch <= 1'b0;
        else if(key_out[0]) begin
            date_time_ch <= ~date_time_ch;   //�������£���־λ��ת       
        end 
        else
            date_time_ch <= date_time_ch;
    end
//------------------------------------------------ pause �����ͣ/��ʼ --------------------------------------------------------------------------------------------------
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n)
            pause <= 1'b0;
        else if(key_out[5])
            pause <= ~pause;
        else if(model != 2'b10)  //�˳����ģʽ��ͣ
            pause <= 1'b0; 
        else    
            pause <= pause;            
    end
    
endmodule 