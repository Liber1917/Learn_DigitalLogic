module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter A=4'b0000,B=4'b0001,C=4'b0010,D=4'b0011,E=4'b0100,F=4'b0101,G=4'b0110,H=4'b0111;
    reg [3:0] state,next;
    reg [11:0] counter;
    reg [3:0] delay;
    
    always@(*)
        begin
            case(state)
                A:next = data ? B : A;
                B:next = data ? C : A;
                C:next = data ? C : D;
                D:next = data ? E : A;
                E:next = (counter == 12'd0) ? F : E;
                F:next = G;
                G:next = (counter == 12'd0 && delay == 4'b0) ? H : G;
                H:next = ack ? A : H;
                default:next = A;
            endcase
        end
    
    always@(posedge clk)
        begin
            if(reset)
                begin
                    state = A;
                    counter = 12'd0;
                    delay = 4'b0;
                end
            else
                begin
                    if(state == D)
                        begin
                            counter = 12'd3;
                        end
                    else if(state == E)
                        begin
                        	counter--;
                            delay = {delay[2:0],data};
                        end
                    else if(state == F)
                        begin
                            counter = 12'd999 - 12'd1;
                        end
                    else if(state == G)
                        begin
                            if(counter == 12'd0)
                                begin
                                	counter = 12'd999;
                                    delay--;
                                end
                            else
                            	counter--;
                        end
                    state = next;
                end
        end
 
    assign count = delay;
    assign counting = (state == F | state == G);
    assign done = (state == H);
    
endmodule