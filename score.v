// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : score.v
// Module name  : score
// Author       : 薛骏
// Description  : 猜拳游戏 计分器
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/01
// --------------------------------------------------------------------
// Module Function: 比赛计分器

module score(clk, rst, key, start, A, B, player);

	input clk, rst, start;	// 时钟信号，复位信号，开始脉冲
	input [3:0] key;			// 双方出拳情况
	output [3:0] A, B;		// A B 对应分数
	output [1:0] player;		// 此次比赛结果
	
	reg [3:0] a, b;			// A B 对应分数
	reg [1:0] p;				// 此次比赛结果
	
	// 初始化
	initial
	begin
		a <= 4'h0;
		b <= 4'h0;
		p <= 2'b00;
	end
	
	assign A = a;			// 绑定 A 的分数
	assign B = b;			// 绑定 B 的分数
	assign player = p;	// 结果输出，用于触发结束动画
	
	// 比分统计
	always@(posedge clk or negedge rst)
	if(!rst)
	begin
		a <= 4'h0;
		b <= 4'h0;
	end
	else
		if(start && (~^p))
			case(key)
			4'b0010: a <= a + 4'h1;		// A 赢 1 局
			4'b0011: b <= b + 4'h1;		// B 赢 1 局
			4'b0100: b <= b + 4'h1;		// B 赢 1 局
			4'b0110: a <= a + 4'h1;		// A 赢 1 局
			4'b0111: a <= a + 4'h1;		// A 赢 1 局
			4'b1000: b <= b + 4'h1;		// B 赢 1 局
			default: ;
			endcase
	
	// 结果判定
	always@(posedge clk or negedge rst)
	if(!rst)
		p <= 2'b00;
	else
		if(~^p)
		begin
			if(a == 4'h3)		// A 获胜
				p <= 2'b10;
			if(b == 4'h3)		// B 获胜
				p <= 2'b01;
		end

endmodule
