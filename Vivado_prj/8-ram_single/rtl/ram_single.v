module ram_single (
    input sys_clk,
    input sys_rst_n
);


wire [7:0] ram_rd_data; //RAM读出的数据
wire [7:0] ram_wr_data;//RAM写入的数据
wire [4:0] ram_addr;  //RAM读写地址
wire ram_en;          //RAM使能信号，高电平有效
wire ram_we;           //RAM写使能信号，高电平有效

//ram读写控制
ram_rw u_ram_rw (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .ram_rd_data(ram_rd_data), //RAM读出的数据

    .ram_wr_data(ram_wr_data),//RAM写入的数据
    .ram_addr(ram_addr),  //RAM读写地址
    .ram_en(ram_en),          //RAM使能信号，高电平有效
    .ram_we(ram_we)           //RAM写使能信号，高电平有效
);

//RAM IP核
blk_mem_gen_0 u_blk_mem_gen_0 (
  .clka(sys_clk),    // input wire clka
  .ena(ram_en),      // input wire ena
  .wea(ram_we),      // input wire [0 : 0] wea
  .addra(ram_addr),  // input wire [4 : 0] addra
  .dina(ram_wr_data),    // input wire [7 : 0] dina
  .douta(ram_rd_data)  // output wire [7 : 0] douta
);



endmodule