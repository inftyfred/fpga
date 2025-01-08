#ʱ��Լ��
create_clock -period 20.000 -name sys_clk [get_ports sys_clk]

#IO����Լ��
#------------------------------ϵͳʱ�Ӻ͸�λ-----------------------------------
set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports sys_clk]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]

#----------------------------------��������-------------------------------------
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports touch_key]

#-----------------------------------LED-----------------------------------------
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {led}]

#------------------------------------SPI-------------------------------------------
#SPI �������
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]