module top_module(
        input clk,
        input areset,    // Freshly brainwashed Lemmings walk left.
        input bump_left,
        input bump_right,
        input ground,
        input dig,
        output reg walk_left,
        output reg walk_right,
        output reg aaah,
        output reg digging );

    // ADD SPLAT JUDGE
    parameter LEFT = 4'b0100, DIG_L = 4'b0110, FALL_L = 4'b0000, RIGHT = 4'b0101, DIG_R = 4'b0111, FALL_R = 4'b0001, SPLAT = 4'b1000;
    reg [3:0] state, next_state; // 4 bit state machine
    reg [4:0] SPLAT_Cnt;

    always @(*) begin
        case(state)
            LEFT:
                next_state = (!ground) ? FALL_L : (dig ? DIG_L : (bump_left ? RIGHT : LEFT));
            RIGHT:
                next_state = (!ground) ? FALL_R : (dig ? DIG_R : (bump_right ? LEFT : RIGHT));
            DIG_L:
                next_state = (ground ? DIG_L : FALL_L);
            DIG_R:
                next_state = (ground ? DIG_R : FALL_R);
            FALL_L:
                next_state = (SPLAT_Cnt==5'd21 && ground)?SPLAT:(ground ? LEFT : FALL_L);
            FALL_R:
                next_state = (SPLAT_Cnt==5'd21 && ground)?SPLAT:(ground ? RIGHT : FALL_R);
            default:
            ;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            SPLAT_Cnt <= 5'd0;
            state <= LEFT;
        end
        else begin
            state <= next_state;

            if (!ground && SPLAT_Cnt < 5'd21)
                SPLAT_Cnt <= SPLAT_Cnt + 1;
            else if (SPLAT_Cnt >= 5'd21)
                SPLAT_Cnt <= SPLAT_Cnt ;
            else
                SPLAT_Cnt <= 5'd0;
        end
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state==SPLAT)?0:(~state[2]);
    assign digging = state[1];

endmodule
