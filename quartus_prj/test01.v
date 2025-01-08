module test01(A, B, Sum, Carry);
	input A, B;
	output Sum, Carry;
	
	assign Sum = A^B;
	assign Carry = A&B;
endmodule











































/*
 
Altera 美国可编程芯片系统企业 二十年前发明世界上第一个可编程逻辑器件
Xilinx(赛灵思) 全球最大的可编程芯片（FPGA）厂商


模块编写风格：
数据流描述风格   ->  基本机制：使用连续赋值语句——assign	语句并发执行(wire)
行为描述风格	->   使用always和initial语句进行赋值   （只可以赋值reg类型变量）
结构描述风格    ->   内建门级基元、开关级基元、用户定义的基元、模块实例 ————门电路
上述风格的混合



 Verilog HDL描述的四个层次的电路模型:
 1)行为级或算法级
 2)寄存器传输级
 3)门级
 4)开关级
 
 1.1 PLD 和 FPGA
术语: Programmable Logic Device可编程逻辑器件
概念：可由用户通过软件进行配置和编程，从而完成某种
特定功能且可反复擦写的通用芯片。

*****
FPGA是ASIC领域中的一种半定制电路。
半定制：通过编程，FGPA可以实现不同的功能；
（一次性编程 或 反复编程）
FPGA 是复杂度最高的可编程器件；是当前可编程器件的主流。

***
FPGA的三大应用领域
1)数字信号处理中的信号变换
2）高速交换中的数据收发
3）求解中的复杂计算
***
FPGA的优势：
1)小批量专用硬件芯片的开发(FPGA的典型应用)
2）芯片原型产品的快速实现（快速开发ASIC）
e.g.: 通用芯片(CPU);专用芯片(编解码器)
3)算法的硬件化实现(执行速度快)
e.g.:数据预处理用一片FPGA实现
***
FPGA的局限性：
1)一般来说，FGPA比ASIC的工作频率要低;
2)不能完成非常复杂的设计；
3)能耗可能会高于ASIC。


*****FPGA的基本组成
1)可编程IO单元(可适配不同的电气标准与物理特性)
2）基本可编程逻辑单元（FPGA的主体）
LUT（查找表)+寄存器（Register）
Altera称LE(Logic Element); Xilinx称Slice
3)内嵌RAM块(没有ROM,用RAM实现ROM)
4）布线资源
5)底层嵌入功能单元(CPU, DSP , PLL-锁相环等)
6)内嵌专用硬核(不是所有FPGA都有)

FPGA的结构
1) FGPA的基本特点
用通过结构实现各种电路
2) FGPA的基本要素
逻辑要素
I/O要素
布线要素
其他要素:
	存储
	测试
	处理器
	乘法器

****
流水线设计就是将组合逻辑系统地分割，并在各个部分（分级）之间插入寄存器，并暂存中间数据的方法。
目的是将一个大操作分解成若干的小操作，每一步小操作的时间较小，所以能提高频率，各小操作能并行
执行，所以能提高数据吞吐率（提高处理速度）。
*****
什么是时序：在单元模块的输入/输出，模块内部乃至整个芯片中，
电平信号或跳沿信号发生变化的快慢和变换的顺序。
****
时序的重要性：
1)走线导致的最长时延，决定了FPGA最高可以达到的工作频率；
(FPGA设计出的电路，可达到的最高工作频率会比ASIC低。)
****
保证时序正确性的手段
1)QuartusⅡI 在编译时，同时进行时序分析；
2）设计人员提供时序约束文件。

*****
时序分析
时序分析通常采用有两种手段
1）时序仿真（Timing Simulation）
2）静态时序分析（STA,Static Timing Analysis)
*****
出现时序问题的可能原因：
1）走线导致的时延
2)时钟的频率偏移，抖动，上下跳延的过渡过程。


*****
IP核————知识产权
Soft IP Core（软核)： Verilog语言形式 可实现功能）
Firm IP Core(固核)：网表形式（可硬件化）
Hard IP Core（硬核）：版图形式（可制片）

*/


/*
`timescale 1ns/100ps   //明确单位时间大小为1ns   精度100ps
initial					//初始化 只执行一次
	begin
		A = 0;
		B = 0;
	end

assign A = #2 1;  //延时赋值  assign只能赋值wire（线网）型
assign B = #4 1;	//语句内延迟  先计算右边 延时4个单位赋值给左边


sum = (a ^ b) ^ cin;
#4 t1 = a&cin;		//语句间延迟   在上一句执行完 延迟4个单位在执行该语句



阻塞赋值 =
非阻塞赋值 <=
阻塞赋值是按照顺序执行的，排列在前面的语句完成赋值后，在执行下面的赋值语句
非阻塞赋值把想要赋给左式的值安排在未来时刻，然后继续执行，———— 先计算右值，最后同时赋值给左边

模块实例化：
模块名  实例名  （端口连接）;
例：
fa_seq uf1	(pa, pb, pci, psum, pco); //按端口位置连接
fa_str ufa1 (.a(fa[1]), .b(fb[1]), .cin(fcin), .sum(fsum[1]), .cout(ftemp[2]));  //按照端口名连接

test_bench

module test_rs;  //空列表



内建门电路	关键字
与门		and
与非门  	nand
或门		or
或非门		nor
异或门		xor
同或门		xnor
（输出在前）

0、1、x（未知）、z（高阻）

条件操作符：  cond_expr  ?  expr1 : expr2
位拼接	：	{a, b, c}   //{1, 0, 1} --> 101

用户定义的原语（UDP）：
1）UDP只能有一个输出和多个输入， 第一个端口必须是输出端口
2）不依赖于module，出现在module之外。也可在单独的文件中

UDP语法格式：
primitive UDP_name (outputName, list_of_inputs);
	output_declaration
	list_of_inputs_declarations
	[Reg_declaration]
	[Initial_statement]
	
	table
		list_of_table_entries
	endtable
endprimitive

例: 2-1多路选择器
primitive mux_2by1(y,a,b,select);
	output y;
	input a,b,select;
	
	table
		//a		b 	 select 	: y;
		  0    	?	    1		: 0;	//?代表任意
		  1		?		1		: 1;
		  ?		0		0		: 0;	// “ - ”表示不变
		  ?		1		0		: 1;
		  0		0		x 		: 0;	// (01)  代表电平从0跳转到1
										//若是有其它组合没有列出，比如这里没有列出 01x， 则输出默认为x
	endtable
	
endprimitive

时序逻辑UDP中有寄存器描述内部状态，


#(上升延迟， 下降延迟， 截止延迟)			//延迟



 always 语句 带有触发条件的语句
always@(敏感信息列表)
	begin

	end

只有 敏感信息列表 中的条件满足时才会执行begin-end中的语句
 如@（a）//当信号a的值发生改变时
 @（a or b） //当a或者b的信号发生改变时
 @（posedge clk) //当clk的上升沿来临时
 @ （negedge reset）//当reset的下降沿来临时
 @（*）//表示该过程块中的所有变量


always语句注意点：

1、不要在不同的always块内为同一个变量赋值。即某个信号出现在<=或者=左边时，只能在一个always块内。

2、不要在同一个always块内同时使用阻塞赋值（=）和非阻塞赋值（<=）。

3、在使用always块描述组合逻辑时使用阻塞赋值(=)；使用always块描述时序逻辑时使用非阻塞赋值（<=）。

4、任何在always块内被赋值的变量都必须是寄存器型（reg）。

5、always的敏感列表中可以同时包括多个电平敏感事件，也可以包括多个边沿敏感事件，
   但不能同时有电平和边沿敏感事件。另外，在敏感列表中，同时包括一个信号的上升沿敏感事件和下降沿敏感事件是不容许的，因为这两个事件可以合并为一个电平事件。





task任务:
task [automatic] task_id[(...)];
	[declarations]
	procedural_statement	//任务描述
endtask
//被声明为automatic类型代表内部局部变量在每一次任务调用时都会进行动态分配


function函数：
function [automatic] [signed] [range_or_type] function_id;
	input_declaration
	other_declarations
	procedural_statement
endfunction

函数与task的不同之处：
1）只能有一个返回值
2）不能包含任何延迟
3）不能调用任何其它任务，可以调用其它函数
4）不能有output、inout语句




输入管脚配置之后要全编译
烧写程序：tools-》programmer -》add file 选中.sof -》start



常见代码：
//3-8译码器
module decoder
(
	input wire in_1,
	input wire in_2,
	input wire in_3,
	
	output reg  [7:0] out
);

always@(*)
	case({in_1,in_2,in_3})
		3'b000: out = 8'b0000_0001;
		3'b001: out = 8'b0000_0010;
		3'b010: out = 8'b0000_0100;
		3'b011: out = 8'b0000_1000;
		3'b100: out = 8'b0001_0000;
		3'b101: out = 8'b0010_0000;
		3'b110: out = 8'b0100_0000;
		3'b111: out = 8'b1000_0000;
		default: out = 8'b0000_0001;
	endcase
endmodule

//D触发器 异步复位
module Dff_
(
	input wire clk,//时钟信号
	input wire rs, //复位信号 低电平有效
	input wire d,  //输入信号

	output reg out //输出信号
);

always@(posedge clk or negedge rs)//异步复位
	if(rs == 1'b0)
		out <= 1'b0;
	else
		out <= d;
endmodule

//ppt_d触发器
module trigger_d(clk, d, q, qb);
input clk, d;
output q, qb;
reg q;

assign qb = ~q;
always@(posedge clk)
begin
	q <= d;
end
endmodule

//rs触发器
module trigger_rs(clk,r,s,q,qb);
input clk,r,s;
output q,qb;
reg q;

assign qb = ~q;
always@(posedge clk)
begin
	case({r,s})
		2'b00: q<=q;
		2'b01: q<=1;
		2'b10: q<=0;
		2'b11: q<=1'bx;
	endcase
end
endmodule

//带异步清零、异步置1的JK触发器
module jkff_rs
(
	input clk, j, k, set, rs,
	output reg q
);

always@(posedge clk, negedge rs, negedge set)
begin
	if(!rs) q <= 1'b0;
	else if(!set) q <= 1'b1;
	else 
		case({j,k})
		2'b00: q <= q;
		2'b01: q <= 1'b0;
		2'b10: q <= 1'b1;
		2'b11: q <= ~q;
		default: q <= 1'bx;
		endcase
end
endmodule


//T触发器
module trigger_t(clk,r,t,q,qb);
	input clk,r,t;
	output q,qb;
	reg q;
	
	assign qb = ~q;
	always@(posedge clk)
	begin
		if(r) q<=0;
		else
			if(t) q<=t;
			else q<=~q;
	end
endmodule




//将系统时钟分频为 1KHz
//sys_clk为1MHz
reg clk;		//分频时钟
reg[8:0] count;//9位宽

always@(negedge rst_n or posedge sys_clk)
begin
	if(rst_n == 1'b0)	begin clk <= 0; count <= 0; end
	else if(count == 500) 
	begin 
		count <= 0;
		clk <= ~clk;	//每计数500，将时钟翻转一次
	end
	else
		count <= count + 1;
end

//计数器
module counter
(
	input clk, en, reset,
	output reg[3:0] cnt
);
always@(posedge clk or posedge reset)
begin
	if(reset) cnt <= 0;
	else if(en == 1'b1) cnt <= cnt + 1;
end
endmodule



//锁存器
//le为高电平时，输入锁存，oe为无效时（低电平有效），输出为高阻态
module latch74LS373
(
	input le, oe,
	input [7:0] d,
	output reg[7:0] q
);
always@(*)
begin
	if(~oe & le) q <= d;	//或( (!oe) && (le) )
	else q <= 8'bz;

end
endmodule

//寄存器
module reg_w
#(parameter WIDTH = 8)
(
	input clk, clr,
	input [WIDTH-1:0] din,
	output reg[WIDTH-1:0] dout
);
always@(posedge clk, posedge clr)
begin
	if(clr) dout <= 0;
	else dout <= din;
end
endmodule
//锁存器一般由电平信号控制，属于电平敏感型；寄存器由时钟信号控制，属于边沿敏感型


//8位移位寄存器
module shift8
(
	input din, clk, clr,
	output reg[7:0] dout
);

always@(posedge clk)
begin
	if(clr) dout <= 8'b0;//同步清零
	else
	begin
		dout <= dout << 1;
		dout[0] <= din;
	end
end
endmodule

//数码管
module re(data,en,out);
input[3:0] data;
input en;
output[6:0] out;
reg[6:0] out;
always @(data or en)
begin
	out = {7{1'b0}};
	if(en==1)
	begin
	case(data) //共阳接法
	4'b0000 : out [6:0] = 7'b1000000;
	4'b0001 : out [6:0] = 7'b1111001;
	4'b0010 : out [6:0] = 7'b0100100;
	4'b0011 : out [6:0] = 7'b0110000;
	4'b0100 : out [6:0] = 7'b0011001;
	4'b0101 : out [6:0] = 7'b0010010;
	4'b0110 : out [6:0] = 7'b0000010;
	4'b0111 : out [6:0] = 7'b1111000;
    4'b1000 : out [6:0] = 7'b0000000;
	4'b1001 : out [6:0] = 7'b0011000;
	default : out [6:0] = {7{1'b0}};

	endcase
	end
end
endmodule
*/