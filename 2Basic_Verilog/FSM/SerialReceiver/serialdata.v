module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial

    // New: Datapath to latch input bits.

    localparam idle = 0;
    localparam start = 1;
    localparam data = 2;
    localparam stop =3;
    localparam error = 4;
    
    reg[2:0] state, next_state;
    reg[3:0] cnt;
    reg done_r;
    
//transition
    always@(*)begin
        case(state)
            idle:next_state=in?idle:start;
            start:next_state=data;
            data:next_state=(cnt==8)?(in?stop:error):data;
            stop:next_state=in?idle:start;
            error:next_state=in?idle:error;
        endcase
    end
    
//state
    always@(posedge clk)begin
        if(reset)
            state <= idle;
        else
            state <= next_state;
    end
    
//cnt
    always@(posedge clk)begin
        if(reset)
            cnt<=0;
        else
            case(next_state)
                start:cnt<=0;
                data:cnt<=cnt+1;
                default:cnt<=cnt;
            endcase
    end
    
//done_r
    always@(posedge clk)
        case(next_state)
            stop:done_r <= 1;
            default:done_r <= 0;
        endcase
    
    assign done = done_r;
    
//shift bytes
    reg [9:0]BYTE;
    always@(posedge clk)begin
        if(reset)begin
            BYTE<=10'd0;
        end
        else begin
            //发送最低有效位
        	BYTE>>=1;
            BYTE[9]<=in;
    	end
    end
    assign  out_byte=BYTE[8:1];
        
endmodule
