module beep(
    input clk,  //24MHz
    input rst_n,
    input Value_en,			//数码管使能端,使能信号从按键模块中来
	input [3:0]KEY_Value,	//按键值
    input beep_flag,
    input [7:0] now_time,
    input [15:0] adj_time,
    input clock_en,
    output reg clock_ack,
    input [15:0]Max_beep_times,
    
    output beep
    
);



reg beep_r;   
reg beep_r1; 
reg flag_en;
reg [7:0] state;
reg [15:0] state2;
reg beep_switch;
reg [5:0] beep_times;
reg clock_flag;

always@(posedge clk)
begin
    if(clock_en)   
        clock_flag <= 1'b1;
    else 
        clock_flag <= 1'b0;
end


always@(posedge clk, negedge rst_n) 
begin
        if(!rst_n)
        begin
            flag_en <= 1'b0;
            beep_switch <= 1'b0;
            clock_ack <= 1'b0;
        end
        else if(((Value_en) && (KEY_Value == 4'd10)) || clock_flag) //闹钟时间到  now_time[7:0] == 8'h00
        begin
            clock_ack <= 1'b0;
            flag_en <= 1'b1;
        end
        else if(state == 8'd63 || (Value_en) && (KEY_Value == 4'd0))  //一首音乐结束
        begin
            flag_en <= 1'b0;
            clock_ack <= 1'b1;
        end
        else if(state2 == Max_beep_times) //次数beep_times == Max_beep_times
            beep_switch <= 1'b0;
        else if(beep_flag || ((Value_en) && (KEY_Value == 4'd9)))  //((now_time[7:0] == 8'h00) && (now_time[15:8] == 8'h00) )
        begin
            beep_switch <= 1'b1;
        end            
        else
        begin
            flag_en <= flag_en;
            beep_switch <= beep_switch;
        end
end 




reg [16:0] count, count_end;
reg [23:0] count3,count3_end;
reg [23:0] count1,count2;

localparam  L_3 = 17'd36408, 
            L_5 = 17'd30612,
            L_6 = 17'd27272,
            L_7 = 17'd24296,
            M_1 = 17'd22931, 
            M_2 = 17'd20432,
            M_3 = 17'd18201,
            M_5 = 17'd15306,
            M_6 = 17'd13636,
            P_0 = 17'd0,
            H_1 = 17'd11466;
 localparam TIME = 6000000;  //每个音的长短（250ms） 
 localparam TIME2 = 6000000;  

assign beep = beep_r;


always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
    begin
            count <= 17'h0;
            count3 <= 23'd0;
            beep_r <= 1'b1;
    end 
    else if(flag_en) 
    begin
            count <= count + 1'b1;
            if(count == count_end) 
            begin
                count <= 17'h0;
                beep_r <= !beep_r;
            end 
    end
    else if(beep_switch)
    begin
        count3 <= count3 + 1'b1;
        if(count3 == count3_end)
        begin
            count3 <= 24'd0;
            beep_r <= !beep_r;
        end
    end
    else begin
            count <= 17'h0;
            count3 <= 16'h0;
            beep_r <= 1'b1;            
        end 
end 

always@(posedge clk, negedge rst_n) 
begin
        if(!rst_n) begin
            count1 <= 24'd0;
            count2 <= 24'd0;
            state <= 8'd0;
        end
        else if(flag_en) 
        begin
            if(count1 < TIME) 
                count1 <= count1 + 1'b1;
            else begin
                count1 <= 24'd0;
                if(state == 8'd63)
                    state <= 8'd0;
                else
                    state <= state + 1'b1;        
            end         
        end
        else if(beep_switch)
        begin
            if(count2 < TIME2)
                count2 <= count2 + 1'b1;
            else
            begin
                count2 <= 24'd0;
                if(state2 == Max_beep_times)  //Max_beep_times
                    state2 <= 16'd0;
                else
                    state2 <= state2 + 1'd1;
            end
        end
        else 
        begin
            count1 <= 24'd0;
            count2 <= 24'd0;
            state <= 8'd0;
            state2 <= 16'd0;
        end            
end 

always@(posedge clk, negedge rst_n)
begin
        case(state)
            8'd0, 8'd1, 8'd2, 8'd3:      count_end  = L_3;
            8'd4, 8'd5, 8'd6:            count_end  = L_5;
            8'd7:                        count_end  = L_6;
            
            8'd8, 8'd9, 8'd10:           count_end  = M_1;
            8'd11:                       count_end  = M_2;
            8'd12:                       count_end  = L_6;
            8'd13:                       count_end  = M_1;
            8'd14, 8'd15:                count_end  = L_5;
            
            8'd16, 8'd17, 8'd18:         count_end  = M_5;
            8'd19:                       count_end  = H_1;
            8'd20:                       count_end  = M_6;
            8'd21:                       count_end  = M_5;
            8'd22:                       count_end  = M_3;
            8'd23:                       count_end  = M_5;
            
            8'd24, 8'd25, 8'd26, 8'd27, 
            8'd28, 8'd29, 8'd30, 8'd31:  count_end  = M_2;
            
            8'd32, 8'd33, 8'd34:         count_end  = M_2;
            8'd35:                       count_end  = M_3;
            8'd36, 8'd37:                count_end  = L_7;
            8'd38, 8'd39:                count_end  = L_6;
            
            8'd40, 8'd41, 8'd42:         count_end  = L_5;
            8'd43:                       count_end  = L_6;
            8'd44, 8'd45:                count_end  = M_1;
            8'd46, 8'd47:                count_end  = M_2;
            8'd48, 8'd49:                count_end  = L_3;
            
            8'd50, 8'd51:                count_end  = M_1;
            8'd52:                       count_end  = L_6;
            8'd53:                       count_end  = L_5;
            8'd54:                       count_end  = L_5;
            8'd55:                       count_end  = M_1;
            
            8'd56, 8'd57, 8'd58, 8'd59, 
            8'd60, 8'd61, 8'd62, 8'd63:  count_end  = L_5;  
            default:                     count_end  = 17'hxxxxx; 
        endcase     
    end 


//控制蜂鸣器响的次数
always@(posedge clk)
begin
        case(state2)
            16'd0, 16'd4, 16'd8,16'd12,16'd16,16'd20,16'd24:        count3_end  = M_1;
            16'd28,16'd32,16'd36,16'd40,16'd44,16'd48:              count3_end  = M_1;
            16'd52,16'd56,16'd60,16'd64,16'd68,16'd72,16'd76:       count3_end  = M_1;
            16'd82,16'd86,16'd90,16'd94,16'd98,16'd102:             count3_end  = M_1;
            default:                     count3_end  = P_0; 
        endcase     
    end 

endmodule
