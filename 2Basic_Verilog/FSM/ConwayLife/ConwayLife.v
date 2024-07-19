module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [17:0] grid_2d [17:0];
    reg [2:0] sum;
    integer m, n;

    // 数据展开并升维,组合逻辑
    always @(*) begin
        grid_2d[0] = {q[16*15], q[16*15 +: 16], q[16*16 -1]};
        grid_2d[17] = {q[16*0], q[16*0 +: 16], q[16*1 -1]};
        for (m = 1; m < 17; m++) begin
            grid_2d[m] = {q[16*(m-1)], q[16*(m-1) +: 16], q[16*m-1]};
        end
    end

    // 状态转移,时序逻辑
    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            // 数据处理
            for (m = 0; m < 16; m = m + 1) begin : row
                for (n = 0; n < 16; n = n + 1) begin : col
                    sum = grid_2d[m][n] + grid_2d[m][n+1] + grid_2d[m][n+2] // 上方
                        + grid_2d[m+1][n] + grid_2d[m+1][n+2]
                        + grid_2d[m+2][n] + grid_2d[m+2][n+1] + grid_2d[m+2][n+2]; // 下方
                    case(sum)
                        3'd2: q[16*m+n] <= q[16*m+n];
                        3'd3: q[16*m+n] <= 1'b1;
                        default: q[16*m+n] <= 1'b0;
                    endcase
                end
            end
        end
    end

endmodule
