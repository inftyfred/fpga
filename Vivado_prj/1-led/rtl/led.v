module led(
    input   key, //���밴��
    output  led  //���led���ߵ�ƽ����
);

//������Ϊ�͵�ƽʱ��ledΪ�ߵ�ƽ
assign led = ~key;

endmodule