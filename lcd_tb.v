// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : lcd_tb.v
// Module name  : lcd_tb
// Author       : 薛骏
// Description  : 用于仿真LCD模块波形
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/09
// --------------------------------------------------------------------
// Module Function: 模块波形仿真

`timescale 1ns / 100ps
module lcd_tb;

	// 设置系统时钟
	reg sys_clk;
	initial
		sys_clk = 1'b0;
	always
		#10 sys_clk = ~sys_clk;
		
	// 设置复位信号
	reg sys_rst;
	initial
	begin
		sys_rst = 1;
		#2;
		sys_rst = 0;
		#40;
		sys_rst = 1;
	end
	
	// 设置初始A,B
	reg [3:0] A;
	reg [3:0] B;
	initial
	begin
		A = 4'd0;
		#100;
		B = 4'd0;
		#120;
		A = 4'd1;
		#140;
		A = 4'd2;
		#160;
		B = 4'd1;
		#180;
		B = 4'd2;
		#200;
		A = 4'd3;
	end
	
	wire lcd_en, lcd_rw, lcd_rs;
	wire [7:0] lcd_data;
	
	// 模块例化
	lcd_1602_driver l1(.clk(sys_clk),
							 .rst_n(sys_rst),
							 .lcd_en(lcd_en),
							 .lcd_rw(lcd_rw),
							 .lcd_rs(lcd_rs),
							 .lcd_data(lcd_data),
							 .A(A), .B(B));

endmodule
