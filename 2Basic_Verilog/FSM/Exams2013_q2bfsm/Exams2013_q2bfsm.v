module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    reg [3:0] state,next,cnt;
    //直接使用状态机，取消计数
    parameter  A=0,A_d=1,A_dd=8,S1=2,S2=3,M1=4,M1_d1=5,M1_d2=6,M2=7;

    always @(posedge clk)begin
        if(~resetn) begin
            state<=A;
        end
        else begin
            state<=next;
        end
    end

    always @(*)begin
        case(state)
            A:next=A_d;
            A_d:next=A_dd;
            A_dd:next=x?S1:A_dd;
            S1:next=x?S1:S2;
            S2:next=x?M1:A_dd;
            M1:next=y?M1_d2:M1_d1;
            M1_d1:next=y?M1_d2:M2;
            M1_d2:next=M1_d2;
            M2:next=M2;
            default:next=A;
        endcase
    end


    always @(*) begin
        f =(state==A_d);
        g = (state == M1 || state == M1_d1 || state == M1_d2 || state == M1_d3);
    end
    
endmodule
