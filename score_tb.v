// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : score_tb.v
// Module name  : score_tb
// Author       : 薛骏
// Description  : 用于仿真比分控制模块波形
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/10
// --------------------------------------------------------------------
// Module Function: 模块波形仿真

`timescale 1ns / 100ps
module score_tb;

	reg clk, rst;
	reg [3:0] key;
	reg start;
	wire [3:0] A, B;
	wire [1:0] player;
	
	// 设置时钟信号
	parameter CLOCK = 20;
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
	
	// 设置key控制信号
	initial
		key = 0;
	always
		#(CLOCK) key = key + 1;
	
	// 设置开始按键脉冲
	initial
		start = 0;
	always
	begin
		#(CLOCK*5) start = 1;
		#1 start = 0;
	end
	
	// 例化模块
	score s1(.clk(clk),
				.rst(rst),
				.key(key),
				.start(start),
				.A(A), .B(B),
				.player(player));

endmodule
