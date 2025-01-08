module key_filter(
    input clk,
    input rst_n,
    input key_in,
    output reg key_state,  //Ԥ��
    output key_flag
);

    parameter CNT_MAX = 1;   //20ms����ֵ 1_000_000

    reg [19:0] key_H, key_L;         //��������

//------------------����Ϊ�� ����-------------------------------------------------------------------------------------------------
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n)
            key_H <= 20'd0;
        else begin
            if(key_in)
                key_H <= key_H + 1;
            else
                key_H <= 20'd0;       
        end     
    end 

//-------------------����Ϊ�� ����-----------------------------------------------------------------------------------------------------    
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n)
            key_L <= 20'd0;
        else begin
            if(!key_in)
                key_L <= key_L + 1;
            else
                key_L <= 20'd0;       
        end     
    end 

//-------------------key_state����ж�-------------------------------------------------------------------------------------------------------   
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n)
            key_state <= 1'b1;
        else begin
            if(key_H > CNT_MAX)
                key_state <= 1'b1;
            else if(key_L > CNT_MAX)
                key_state <= 1'b0;            
        end 
    end 
//---------------------�������� �½����ж�-------------------------------------------------------------  
    reg state1, state2;
    always@(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            state1 <= 1'b0;
            state2 <= 1'b0;
        end 
        else begin
            state1 <= key_state;
            state2 <= state1;
        end    
    end 
    
    assign key_flag = (!state1) & state2;   //�������£�flagΪ��

endmodule 