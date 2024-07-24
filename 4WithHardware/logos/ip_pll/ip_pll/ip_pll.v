module ip_pll(
    input sys_clk         , //系统时钟 
    input sys_rst_n       , //系统复位，低电平有效

    output clk_100m       , //100Mhz 时钟频率
    output clk_100m_180deg, //100Mhz 时钟频率,相位偏移 180 度
    output clk_50m        , //50Mhz 时钟频率
    output clk_25m          //25Mhz 时钟频率
    );

//wire define
wire pll_lock;


//main
pll_clk my_pll_clk (
  .pll_rst(~sys_rst_n),      // input
  .clkin1(sys_clk),        // input
  .pll_lock(pll_lock),    // output
  .clkout0(clk_100m),      // output
  .clkout1(clk_100m_180deg),      // output
  .clkout2(clk_50m),      // output
  .clkout3(clk_25m)      // output
);

endmodule