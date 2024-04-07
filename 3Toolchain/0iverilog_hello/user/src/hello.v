//用iverilog完成一个hello world
module hello;
    initial begin
        $display("hello world");
        $finish;
    end
endmodule
