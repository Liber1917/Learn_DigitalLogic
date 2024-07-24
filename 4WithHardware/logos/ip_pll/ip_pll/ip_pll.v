module ip_pll(
    input sys_clk         , //ϵͳʱ�� 
    input sys_rst_n       , //ϵͳ��λ���͵�ƽ��Ч

    output clk_100m       , //100Mhz ʱ��Ƶ��
    output clk_100m_180deg, //100Mhz ʱ��Ƶ��,��λƫ�� 180 ��
    output clk_50m        , //50Mhz ʱ��Ƶ��
    output clk_25m          //25Mhz ʱ��Ƶ��
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