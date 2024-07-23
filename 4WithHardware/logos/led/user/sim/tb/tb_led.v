`timescale 1ns / 1ns // 仿真单位/仿真精度
module tb_led();
    // reg define
    reg key;
    // wire define
    wire led;

    // 信号初始化
    initial begin
        key = 1'b1;
        // 按键上电默认高电平
        // key信号变化
        #200; // 延迟200ns
        key = 1'b1; // 按键没有被按下
        #1000;
        key = 1'b0; // 按键被按下
        #600;
        key = 1'b1;
        #1000;
        key = 1'b0;
    end

    // 例化led模块
    led u_led(
            .key(key),
            .led(led)
        );
endmodule
