//单端口RAM读写模块
module ram_rw (
    input sys_clk,
    input sys_rst_n,
    input [7:0] ram_rd_data, //RAM读出的数据

    output reg [7:0] ram_wr_data,//RAM写入的数据
    output reg [4:0] ram_addr,  //RAM读写地址
    output reg ram_en,          //RAM使能信号，高电平有效
    output ram_we           //RAM写使能信号，高电平有效
);

reg [5:0]  rw_cnt;//0-63计数

assign ram_we = (rw_cnt <= 6'd31 && ram_en == 1'b1) ? 1'b1 : 1'b0;//0-31写使能 32-63读使能

//RAM使能
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ram_en <= 1'b0;
    else
        ram_en <= 1'b1;
end

//rm_cnt 0-63计数
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        rw_cnt <= 6'b0;
    else if(ram_en && rw_cnt == 6'd63)
        rw_cnt <= 6'b0;
    else if(ram_en)
        rw_cnt <= rw_cnt + 1;
    else
        rw_cnt <= 6'b0;
end


//对RAM地址进行赋值
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ram_addr <= 5'b0;
    else if(ram_en && rw_cnt <= 6'd31)
        ram_addr <= ram_addr + 1;
    else
        ram_addr <= 5'b0;
end


//对RAM写入数据进行赋值
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        ram_wr_data <= 8'b0;
    else if(ram_we && ram_wr_data <= 6'd31)
        ram_wr_data <= ram_wr_data + 1;
    else
        ram_wr_data <= 8'b0;
end




endmodule