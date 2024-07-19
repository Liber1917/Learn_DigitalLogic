module top_module(// 顶层模块，奇校验串口数据传输
    input clk,      // 输入时钟信号
    input in,       // 输入数据信号
    input reset,    // 同步复位信号
    output reg [7:0] out_byte,  // 输出字节
    output done            // 完成标志
);

    // Modify FSM and datapath from Fsm_serialdata
    parameter START = 0, CHECK = 9, STOP = 10, IDEL = 11, ERROR = 12; // 定义状态常量
    reg [4:0] state, next_state;  // 状态寄存器和下一状态寄存器
    reg valid, start;             // 数据有效标志和启动标志

    always @(*) begin
        start = 0; // 默认启动信号为0
        case (state)
            IDEL: begin next_state = in ? IDEL : START; start = 1; end // 空闲状态
            STOP: begin next_state = in ? IDEL : START; start = 1; end // 停止状态
            CHECK: next_state = in ? STOP : ERROR;                   // 校验状态
            ERROR: next_state = in ? IDEL : ERROR;                   // 错误状态
            default: next_state = state + 1;                         // 其他状态
        endcase  
    end
    
    always @(posedge clk)
        if (reset)
            state <= IDEL;  // 复位时状态置为IDEL
        else begin
            state <= next_state; // 非复位时状态更新为下一状态
            valid <= odd;        // 数据有效标志由奇偶校验模块输出
        end
    
    always @(posedge clk)
        if ((0 <= state) & (state < 8))
            out_byte[state] <= in;  // 在数据状态下将输入数据存入输出字节中
    
    wire odd; // 奇偶校验输出
    parity check(clk, reset | start, in, odd);  // 调用奇偶校验模块，reset信号加上start信号用于同步复位
    
    assign done = (valid & (state == STOP));  // 完成标志为数据有效并且状态为STOP

endmodule


module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule
