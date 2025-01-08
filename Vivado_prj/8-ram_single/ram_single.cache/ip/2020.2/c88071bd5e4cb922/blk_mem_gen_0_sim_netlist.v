// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Fri Jan  3 20:45:08 2025
// Host        : infty running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [4:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [4:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [4:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [4:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "5" *) 
  (* C_ADDRB_WIDTH = "5" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.3883 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "32" *) 
  (* C_READ_DEPTH_B = "32" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "32" *) 
  (* C_WRITE_DEPTH_B = "32" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[4:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[4:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20672)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
