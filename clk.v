// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : clk.v
// Module name  : clk
// Author       : 薛骏
// Description  : MAX II 分频器
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/01
// --------------------------------------------------------------------
// Module Function: 时钟分频

module clk (clk, clkout);
 
   input clk;			// 原始时钟
   output clkout;		// 输出时钟
	
	parameter num = 1;					// 所需频率
	parameter clk0 = 'd50_000_000;	// 原始时钟频率
	parameter width = 'd26;				// 计数器位数
	
	reg [width-1:0] count;		// 分频计数器
	reg out;							// 输出时钟
	
	reg[25:0] a;					// 分频比
	
	// 初始化
	initial
	begin
		out <= 1'b0;
		count <= 'd0;
		a <= clk0 / num;
	end
	
	assign clkout = out;			// 绑定输出
	
	// 分频模块
	always@(posedge clk)
		if(count < a)				// 计数
			count <= count + 'd1;
		else
		begin
			count <= 'd0;			// 重新计数
			out <= ~out;			// 输出时钟翻转
		end
   
endmodule     