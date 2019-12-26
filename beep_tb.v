// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : beep_tb.v
// Module name  : beep_tb
// Author       : 薛骏
// Description  : 用于仿真蜂鸣器模块波形
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/10
// --------------------------------------------------------------------
// Module Function: 模块波形仿真

`timescale 1ns / 100ps
module beep_tb;

	reg clk;
	reg rst;
	wire beep;
	
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
	
	// 模块例化
	beep b1(.clk(clk),
			  .rst(rst),
			  .beep(beep));

endmodule
