module led(
input key,
output led
);
//�ϵ簴��Ĭ�ϸߵ�ƽ��led �Ʊ��ֳ���
//���������£�����ֵΪ�͵�ƽ��led �Ʊ�����
assign led = ~key; //��������ֵȡ����ֵ�� led ��
endmodule
