// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : segement.v
// Module name  : segement
// Author       : 薛骏
// Description  : MAX II 数码管显示
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/01
// --------------------------------------------------------------------
// Module Function: 数码管显示

module segment(clk, rst, num1, num2, DIG, Y);

	input clk, rst;				// 时钟信号1kHz，复位信号
	input [3:0] num1, num2;		// 须译码数字
	output [7:0] DIG;				// 数码管选择
	output [7:0] Y;				// 数码管信号分别对应：
										// point, g, f, e, d, c, b, a
	reg cnt;							// 扫描计数器
	reg [7:0] seg[9:0];			// 译码器
	reg [7:0] DIG_r, Y_r;		// 数码管信号分配
	
	// 初始化
	initial
	begin
		cnt <= 'b000;			// 扫描计数器
		seg[0] <= 8'hc0;		// 数字 0
		seg[1] <= 8'hf9;		// 数字 1
		seg[2] <= 8'ha4;		// 数字 2
		seg[3] <= 8'hb0;		// 数字 3
		seg[4] <= 8'h99;		// 数字 4
		seg[5] <= 8'h92;		// 数字 5
		seg[6] <= 8'h82;		// 数字 6
		seg[7] <= 8'hf8;		// 数字 7
		seg[8] <= 8'h80;		// 数字 8
		seg[9] <= 8'h90;		// 数字 9
	end
	
	assign DIG = ~DIG_r;		// 数码管选择，低电平有效
	assign Y = ~Y_r;			// 数码管信号，高电平有效
	
	// 动态扫描
	always@(posedge clk or negedge rst)
	if(!rst)
		cnt <= 'b000;
	else
		cnt <= cnt + 'd1;
	
	// 数码管选择 扫描
	always@(posedge clk or negedge rst)
	if(!rst)
		DIG_r <= 8'h00;
	else
		case(cnt)
			'b0: DIG_r <= 8'h10;
			'b1: DIG_r <= 8'h20;
			default: DIG_r <= 8'h00;
		endcase
	
	// 译码：数码管信号 扫描
	always@(posedge clk or negedge rst)
	if(!rst)
		Y_r <= 8'h00;
	else
		case(cnt)
			'b0: Y_r <= seg[num1];
			'b1: Y_r <= seg[num2];
		endcase

endmodule
