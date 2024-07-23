module led(
        input wire key,
        output wire led
    );
    //上电按键默认高电平，led 灯保持常灭
    //按键被按下，按键值为低电平，led 灯被点亮
    assign led = ~key; //将按键的值取反后赋值给 led 灯
endmodule
