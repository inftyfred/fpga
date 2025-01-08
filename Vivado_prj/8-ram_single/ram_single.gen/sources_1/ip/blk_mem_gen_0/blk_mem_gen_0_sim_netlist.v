// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Fri Jan  3 20:45:08 2025
// Host        : infty running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/my_file/my_project/fpga_prj/Vivado_prj/8-ram_single/ram_single.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tfgg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
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
  blk_mem_gen_0_blk_mem_gen_v8_4_4 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20640)
`pragma protect data_block
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
/98jwFHX
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
