module dual_ad(
    input sys_clk,         // 系统时钟
    input sys_rst_n,       // 系统复位

    // 第一路ADC
    input [9:0] ad_data_1 /* synthesis PAP_MARK_DEBUG="true" */,//第一路 ADC 数据 
    input ad_otr_1 /* synthesis PAP_MARK_DEBUG="true" */,       // 第一路ADC输入电压超过量程标志
    output ad_clk_1,       // 第一路ADC驱动时钟
    output ad_oe_1,        // 第一路ADC输出使能

    // 第二路ADC
    input [9:0] ad_data_2 /* synthesis PAP_MARK_DEBUG="true" */, // 第二路ADC数据
    input ad_otr_2 /* synthesis PAP_MARK_DEBUG="true" */,        // 第二路ADC输入电压超过量程标志
    output ad_clk_2,       // 第二路ADC驱动时钟
    output ad_oe_2         // 第二路ADC输出使能
);

// wire define
wire clk_50m;              // 50MHz时钟
wire clk_50m_deg180 /* synthesis PAP_MARK_DEBUG="<0/c0/0>" */;       // 相位偏移180的50MHz时钟

// Assignments
assign ad_oe_1 = 1'b0;
assign ad_oe_2 = 1'b0;
assign ad_clk_1 = clk_50m;
assign ad_clk_2 = clk_50m;

// PLL instance
pll_clk u_pll_clk (
    .clkin1(sys_clk),
    .pll_lock(pll_lock),
    .clkout0(clk_50m),
    .clkout1(clk_50m_deg180)
);

endmodule
