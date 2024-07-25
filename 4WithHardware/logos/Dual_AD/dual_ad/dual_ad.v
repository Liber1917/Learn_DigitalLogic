module dual_ad(
    input sys_clk,         // ϵͳʱ��
    input sys_rst_n,       // ϵͳ��λ

    // ��һ·ADC
    input [9:0] ad_data_1 /* synthesis PAP_MARK_DEBUG="true" */,//��һ· ADC ���� 
    input ad_otr_1 /* synthesis PAP_MARK_DEBUG="true" */,       // ��һ·ADC�����ѹ�������̱�־
    output ad_clk_1,       // ��һ·ADC����ʱ��
    output ad_oe_1,        // ��һ·ADC���ʹ��

    // �ڶ�·ADC
    input [9:0] ad_data_2 /* synthesis PAP_MARK_DEBUG="true" */, // �ڶ�·ADC����
    input ad_otr_2 /* synthesis PAP_MARK_DEBUG="true" */,        // �ڶ�·ADC�����ѹ�������̱�־
    output ad_clk_2,       // �ڶ�·ADC����ʱ��
    output ad_oe_2         // �ڶ�·ADC���ʹ��
);

// wire define
wire clk_50m;              // 50MHzʱ��
wire clk_50m_deg180 /* synthesis PAP_MARK_DEBUG="<0/c0/0>" */;       // ��λƫ��180��50MHzʱ��

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
