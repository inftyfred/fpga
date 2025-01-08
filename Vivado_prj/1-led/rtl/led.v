module led(
    input   key, //输入按键
    output  led  //输出led，高电平点亮
);

//当按键为低电平时，led为高电平
assign led = ~key;

endmodule