#时序约束
create_clock -period 20.000 -name sys_clk [get_ports sys_clk]
#IO引脚约束
#系统时钟、复位按键、led[3:0]
set_property PACKAGE_PIN R4 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
set_property PACKAGE_PIN U2 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]
set_property PACKAGE_PIN R2 [get_ports {led[0]}]
set_property PACKAGE_PIN R3 [get_ports {led[1]}]
set_property PACKAGE_PIN V2 [get_ports {led[2]}]
set_property PACKAGE_PIN Y2 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

#SPI 相关设置
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
