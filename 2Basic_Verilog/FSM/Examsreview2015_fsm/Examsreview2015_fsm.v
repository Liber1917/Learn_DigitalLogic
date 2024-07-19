module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    reg [3:0]state,next;
    parameter IDLE=4'b0000,B1=4'b0001,B2=4'b0011,B3=4'b0110,B4=4'b1101,S1=4'b0111,S2=4'b1111,S3=4'b1110,S4=4'b1100,S5=4'b1000;
    always @(*)begin
        case(state)
            IDLE:next=data?B1:IDLE;
            B1:next=data?B2:IDLE;
            B2:next=data?B2:B3;
            B3:next=data?B4:IDLE;
            B4:next=S1;
            S1:next=S2;
            S2:next=S3;
            S3:next=S4;
            S4:next=done_counting?S5:S4;
            S5:next=ack?IDLE:S5;
            default:next=IDLE;
        endcase
    end
    always @(posedge clk)begin
        if(reset)
            state<=IDLE;
        else
            state<=next;
    end
    assign shift_ena=(state == B4 || state==S1 || state==S2 || state==S3);
    assign counting=(state==S4);
    assign done=(state==S5);
endmodule
