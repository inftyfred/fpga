-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Fri Jan  3 16:54:14 2025
-- Host        : infty running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/my_file/my_project/fpga_prj/Vivado_prj/7-PLL/prj/pll.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.vhdl
-- Design      : clk_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tfgg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_0 is
  Port ( 
    clk_100M : out STD_LOGIC;
    clk_100M_180 : out STD_LOGIC;
    clk_50M : out STD_LOGIC;
    clk_25M : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_wiz_0;

architecture stub of clk_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_100M,clk_100M_180,clk_50M,clk_25M,reset,locked,clk_in1";
begin
end;
