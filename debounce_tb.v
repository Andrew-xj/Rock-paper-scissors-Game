// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : debounce_tb.v
// Module name  : debounce_tb
// Author       : 薛骏
// Description  : 用于仿真按键消抖模块波形
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/10
// --------------------------------------------------------------------
// Module Function: 模块波形仿真

`timescale 1ns / 100ps
module debounce_tb;

	reg clk, rst, key;
	wire key_pulse;
	
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
	
	// 模拟按键抖动信号
	initial
	begin
		key = 1;
		#15 key = 0;
		#15 key = 1;
		#15 key = 0;
		#15 key = 1;
		#15 key = 0;
		#(CLOCK*25_000_000) key = 1;
		#15 key = 0;
		#15 key = 1;
	end
	
	// 例化模块
	debounce d1(.clk(clk),
					.rst(rst),
					.key(key),
					.key_pulse(key_pulse));

endmodule
