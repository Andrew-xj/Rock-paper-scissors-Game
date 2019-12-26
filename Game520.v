// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : Game520.v
// Module name  : Game520
// Author       : 薛骏
// Description  : 猜拳游戏
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/01
// --------------------------------------------------------------------
// Module Function: 猜拳游戏顶层模块

module Game520(clk, rst, row, r_col, g_col, led,
	btn1_i, btn2_i, btn3_i, ready_i, start_i, btn6_i, btn7_i, btn8_i,
	DIG, Y, lcd_en, lcd_rw, lcd_rs, lcd_data, speaker);

	input clk, rst;						// 时钟信号，复位信号
	input btn1_i, btn2_i, btn3_i, btn6_i, btn7_i, btn8_i;		// 选择按键
	input ready_i, start_i;				// 游戏过程控制按键
	
	output [7:0] row, r_col, g_col;	// 点阵显示输出端口
	output [7:0] led;						// 按键显示
	output [7:0] DIG, Y;					// 数码管输出端口
	output       lcd_en ;				// 使能端
	output       lcd_rw ;				// 读写信号控制端
	output       lcd_rs ;				// 数据/指令寄存器选择控制端
	output [7:0] lcd_data;				// 八位并行数据输出
	output speaker;						// 音乐模块发生端口
	
	// 时钟脉冲
	wire clk_1k;
	
	// 按键脉冲
	wire btn1, btn2, btn3, btn6, btn7, btn8;
	wire [2:0] btn123, btn678;
	wire ready, start;
	
	// 按键控制
	reg btn;
	
	// 游戏双方选择
	reg [2:0] b123, b678;
	reg [3:0] a;
	wire [3:0] key;		// 此轮猜拳状态变量
	
	// 游戏双方比分
	wire [3:0] A, B;
	
	// 按键测试
	reg r;
	assign led = {btn123, ~r, r, btn678};
	
	// 初始化
	initial
	begin
		b123 = 3'b000;
		b678 = 3'b000;
		btn <= 1'b0;
		r <= 1'b0;
	end
	
	// 分频模块
	clk #(.num(1000)) c1(clk, clk_1k);
	
	// 按键消抖
	debounce u2(clk, rst, btn1_i, btn1);
	debounce u3(clk, rst, btn2_i, btn2);
	debounce u4(clk, rst, btn3_i, btn3);
	debounce u5(clk, rst, btn6_i, btn6);
	debounce u6(clk, rst, btn7_i, btn7);
	debounce u7(clk, rst, btn8_i, btn8);
	debounce u8(clk, rst, ready_i, ready);
	debounce u9(clk, rst, start_i, start);
	
	
	// 准备阶段(ready)
	
	// 阶段切换
	always@(posedge clk or negedge rst)
	if(!rst)
	begin
		btn <= 1'b0;
		r <= 1'b0;
	end
	else
		if((A != 3) && (B != 3))
		begin
			if(ready)
			begin
				btn <= 1'b1;
				r <= 1'b1;
			end
			if(start)
			begin
				btn <= 1'b0;
				r <= 1'b0;
			end
		end
	
	// 甲的选择
	always@(posedge clk or negedge rst)
	if(!rst)
		b123 <= 3'b000;
	else
	begin
		if(ready)
			b123 <= 3'b000;
		if(btn)
			if(btn1)
				b123 <= 3'b1000;
			else if(btn2)
				b123 <= 3'b010;
			else if(btn3)
				b123 <= 3'b001;
	end

	// 乙的选择
	always@(posedge clk or negedge rst)
	if(!rst)
		b678 <= 3'b000;
	else
	begin
		if(ready)
			b678 <= 3'b000;
		if(btn)
			if(btn6)
				b678 <= 3'b100;
			else if(btn7)
				b678 <= 3'b010;
			else if(btn8)
				b678 <= 3'b001;
	end
	
	// 保存选择
	assign btn123 = b123;
	assign btn678 = b678;
	
	// 根据甲乙选择，得到对应猜拳状态
	always@*
	begin
		case(btn123)
		'b100: a = 'd0;
		'b010: a = 'd3;
		'b001: a = 'd6;
		default: a = 'd0;
		endcase
		case(btn678)
		'b100: a = a + 'd1;
		'b010: a = a + 'd2;
		'b001: a = a + 'd3;
		default: a = 'd0;
		endcase
	end
	
	assign key = a;	// 绑定 key

	// 点阵显示模块
	round r1(clk, clk_1k, rst, key, ready, start, r_col, g_col, row, A, B);
	
	// 数码管显示模块
	segment s1(clk_1k, rst, A, B, DIG, Y);
	
	// LCD1602字符液晶模块
	lcd_1602_driver l1(clk, rst, lcd_en, lcd_rw, lcd_rs, lcd_data, A, B);
	
	// 音乐模块
	beep b1(clk, rst, speaker);
	
endmodule
