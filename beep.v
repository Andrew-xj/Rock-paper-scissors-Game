// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : beep.v
// Module name  : beep
// Author       : 薛骏
// Description  : 给游戏增加背景音乐
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/05
// --------------------------------------------------------------------
// Module Function: 音乐播放模块

module beep(clk, rst, beep);
	
	input clk;				// 原始时钟 50M
	input rst;				// 复位信号
	output beep;			// 输出蜂鸣器信号
 
	reg [23:0] counter4Hz;		// 4Hz时钟计数器
	reg [3:0] counter5MHz;		// 5MHz时钟计数器
	reg [13:0] count, origin;	// 计数器
	reg audiof;						// 输出信号
	reg clk_5MHz, clk_4Hz;		// 4Hz 50MHz 时钟
	reg [4:0] j;					// 音阶控制
	reg [5:0] len;					// 播放时长控制
	
	assign beep= audiof;  		// 控制开关

	always @(posedge clk or negedge rst)      // 5MHz分频
	if(!rst)
	begin
		counter5MHz <= 0;
		clk_5MHz <= 0;
	end
	else
		if(counter5MHz==4)
		begin
			counter5MHz <= 0;
			clk_5MHz <= ~clk_5MHz;
		end
		else
			counter5MHz <= counter5MHz + 1;

	always @(posedge clk or negedge rst)      // 4Hz分频
	if(!rst)
	begin
		counter4Hz <= 0;
		clk_4Hz <= 0;
	end
	else
		if(counter4Hz == 6250000)              
		begin
			counter4Hz <= 0;
			clk_4Hz <= ~clk_4Hz;
		end
		else
			counter4Hz <= counter4Hz + 1;

	// 输出信号控制
	always @(posedge clk_5MHz or negedge rst)
	if(!rst)
	begin
		audiof <= 0;
		count <= 0;
	end
	else
		if(origin == 'd10000)
			audiof <= 0;
		else if(count == 'd9556)
		begin
			count <= origin;
			audiof <= ~audiof;
		end
		else
			count <= count + 1;

	// 音阶选择
	always @(posedge clk_4Hz or negedge rst)
	if(!rst)
		origin <= 'd10000;
	else
		 case(j)
		 'd0 : origin <= 'd10000;
		 'd1 : origin <= 'd0;		// 低音部分
		 'd2 : origin <= 'd1045;
		 'd3 : origin <= 'd1972;
		 'd4 : origin <= 'd2398;
		 'd5 : origin <= 'd3180;
		 'd6 : origin <= 'd3875;
		 'd7 : origin <= 'd4495;
		 'd8 : origin <= 'd4779;  	// 中音部分
		 'd9 : origin <= 'd5300;
		 'd10: origin <= 'd5765;
		 'd11: origin <= 'd5978;
		 'd12: origin <= 'd6368;
		 'd13: origin <= 'd6716;
		 'd14: origin <= 'd7026;
		 'd15: origin <= 'd7175;  	// 高音部分
		 'd16: origin <= 'd7428;
		 'd17: origin <= 'd7660;
		 'd18: origin <= 'd7767;
		 'd19: origin <= 'd7962;
		 'd20: origin <= 'd8136;
		 'd21: origin <= 'd8291;
		 default: origin <= 'd011111;
		 endcase

	// 播放曲目控制
	always @(posedge clk_4Hz or negedge rst)
	if(!rst)
	begin
		len <= 0;
		j <= 0;
	end
	else
		begin
			len <= len + 1;
			case(len)			// 乐谱
			0 : j <= 10;
			1 : j <= 6;
			2 : j <= 5;
			3 : j <= 6;
			4 : j <= 6;
			5 : j <= 9;
			6 : j <= 9;
			7 : j <= 10;
			8 : j <= 9;
			9 : j <= 5;
			10: j <= 3;
			11: j <= 5;
			12: j <= 5;
			13: j <= 5;
			14: j <= 5;
			15: j <= 3;
			16: j <= 5;
			17: j <= 5;
			18: j <= 3;
			19: j <= 5;
			20: j <= 5;
			21: j <= 5;
			22: j <= 5;
			23: j <= 9;
			24: j <= 8;
			25: j <= 8;
			26: j <= 7;
			27: j <= 8;
			28: j <= 8;
			29: j <= 8;
			30: j <= 8;
			31: j <= 9;
			32: j <= 10;
			33: j <= 6;
			34: j <= 5;
			35: j <= 6;
			36: j <= 6;
			37: j <= 6;
			38: j <= 9;
			39: j <= 10;
			40: j <= 9;
			41: j <= 5;
			42: j <= 3;
			43: j <= 8;
			44: j <= 5;
			45: j <= 5;
			46: j <= 5;
			47: j <= 5;
			48: j <= 3;
			49: j <= 5;
			50: j <= 5;
			51: j <= 3;
			52: j <= 5;
			53: j <= 5;
			54: j <= 5;
			55: j <= 9;
			56: j <= 8;
			57: j <= 8;
			58: j <= 6;
			59: j <= 6;
			60: j <= 6;
			61: j <= 6;
			62: j <= 6;
			63: j <= 0;
			default: j <= 0;
			endcase
		end

endmodule
