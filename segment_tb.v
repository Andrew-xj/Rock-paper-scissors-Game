// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : segment_tb.v
// Module name  : segment_tb
// Author       : 薛骏
// Description  : 用于仿真2个7段数码管模块波形
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/10
// --------------------------------------------------------------------
// Module Function: 模块波形仿真

`timescale 1ns / 100ps
module segment_tb;

	reg clk, rst;
	reg [3:0] num1, num2;
	wire [7:0] DIG, Y;
	
	// 设置时钟信号
	parameter CLOCK = 1000_000;
	initial
		clk = 0;
	always
		#(CLOCK/2) clk = ~clk;
		
	// 设置复位信号
	initial
	begin
		rst = 0;
		#(CLOCK) rst = 1;
	end
	
	// 设置译码数字，以 1 2 为例
	initial
	begin
		num1 = 'd1;
		num2 = 'd2;
	end
	
	// 模块例化
	segment s1(.clk(clk),
				  .rst(rst),
				  .num1(num1),
				  .num2(num2),
				  .DIG(DIG),
				  .Y(Y));

endmodule
