#时序约束
create_clock -period 20.000 -name sys_clk [get_ports sys_clk]

#IO引脚约束
#------------------------------系统时钟和复位-----------------------------------
set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports sys_clk]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]

#输出引脚分配
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports clk_100M]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports clk_50M]
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports clk_25M]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports clk_100M_180]
