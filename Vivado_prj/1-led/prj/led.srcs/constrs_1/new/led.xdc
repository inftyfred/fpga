set_property PACKAGE_PIN T1 [get_ports key]
set_property IOSTANDARD LVCMOS33 [get_ports key]
set_property PACKAGE_PIN R2 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports led]

#SPI 相关设置   上电后快速启动
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]