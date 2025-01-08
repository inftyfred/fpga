// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Fri Jan  3 16:54:14 2025
// Host        : infty running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk_100M, clk_100M_180, clk_50M, clk_25M, reset, 
  locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_100M,clk_100M_180,clk_50M,clk_25M,reset,locked,clk_in1" */;
  output clk_100M;
  output clk_100M_180;
  output clk_50M;
  output clk_25M;
  input reset;
  output locked;
  input clk_in1;
endmodule
