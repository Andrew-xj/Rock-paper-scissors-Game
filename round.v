// ********************************************************************
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// ********************************************************************
// File name    : round.v
// Module name  : round
// Author       : 薛骏
// Description  : 猜拳游戏 游戏过程用点阵显示
// 
// --------------------------------------------------------------------
// Code Revision History : 
// --------------------------------------------------------------------
// Version: |Mod. Date:
// V1.0     |2019/12/03
// --------------------------------------------------------------------
// Module Function: 点阵显示模块

module round(clk, clk_1k, rst, key, ready, start, col_r, col_g, row_o, A, B);

	input clk, clk_1k, rst;		// 50M时钟，1k时钟，复位信号
	input [3:0] key;				// 此轮猜拳状态
	input ready, start;			// 游戏过程控制按键
	output [7:0] col_r;			// 点阵列管脚（红色），高电平有效
	output [7:0] col_g;			// 点阵列管脚（绿色），高电平有效
	output [7:0] row_o;			// 点阵行管脚，低电平有效
	output [3:0] A, B;			// A B 双方比分
	
	reg [7:0] red, green;
	reg [7:0] row;
	reg show;						// 点阵显示控制
	reg [10:0] count;				// 此轮猜拳结果显示时间计数器
	
	integer pic;					// 开场动画切换
	integer over;					// 结束动画切换
	reg [8:0] cnt;					// 动画时间计数器
	
	wire [1:0] player;			// 获胜方：10表示甲胜，01表示乙胜
	
	// 初始化
	initial
	begin
		show <= 1'b0;
		row <= 8'h01;
		red <= 8'h00;
		green <= 8'h00;
		pic <= 0;
		cnt <= 9'h000;
		count <= 12'h001;
		over <= 0;
	end
	
	// 控制逻辑
	always@(posedge clk or negedge rst)
	if(!rst)
		show <= 1'b0;
	else
		if(~^player)
			begin
				if(ready)					// 点阵全灭
					show <= 1'b0;
				if(start && (~show))		// 点阵点亮
					show <= 1'b1;
			end
	
	// 动态扫描
	always@(posedge clk_1k)
	begin
		if(row == 8'h80)
			row <= 8'h01;
		else
			row <= row * 2;
	end
	
	// 输出端口绑定
	assign row_o = ~row;
	assign col_r = red;
	assign col_g = green;
	
	// 比分控制模块
	score s1(clk, rst, key, start, A, B, player);
	
	// 点阵显示
	always@(posedge clk_1k or negedge rst)
	if(!rst)
	begin
		red <= 8'h00;
		green <= 8'h00;
		pic <= 0;
		over <= 0;
		cnt <= 9'h000;
		count <= 11'h001;
	end
	else
		if(pic < 8)			// 开场动画
		begin
			case(pic)
			0: begin			// 石头
				case(row)
					8'h01: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h02: 
					begin
						red <= 8'he7;
						green <= 8'he7;
					end
					8'h04: 
					begin
						red <= 8'he7;
						green <= 8'he7;
					end
					8'h08: 
					begin
						red <= 8'he7;
						green <= 8'he7;
					end
					8'h10: 
					begin
						red <= 8'he7;
						green <= 8'he7;
					end
					8'h20: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h40: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h80: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			1: begin			// 剪刀
				case(row)
					8'h01: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h02: 
					begin
						red <= 8'h24;
						green <= 8'h24;
					end
					8'h04: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h08: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h10: 
					begin
						red <= 8'h24;
						green <= 8'h24;
					end
					8'h20: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h40: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h80: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			2: begin			// 布
				case(row)
					8'h01: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h02: 
					begin
						red <= 8'h42;
						green <= 8'h42;
					end
					8'h04: 
					begin
						red <= 8'he7;
						green <= 8'he7;
					end
					8'h08: 
					begin
						red <= 8'he7;
						green <= 8'he7;
					end
					8'h10: 
					begin
						red <= 8'h42;
						green <= 8'h42;
					end
					8'h20: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h40: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h80: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			3: begin			// S
				case(row)
					8'h01: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h02: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h04: 
					begin
						red <= 8'h0c;
						green <= 8'h0c;
					end
					8'h08: 
					begin
						red <= 8'h30;
						green <= 8'h30;
					end
					8'h10: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h20: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h40: 
					begin
						red <= 8'h3c;
						green <= 8'h3c;
					end
					8'h80: 
					begin
						red <= 8'h3c;
						green <= 8'h3c;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			4: begin			// T
				case(row)
					8'h01: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					8'h02: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h04: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h08: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h10: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h20: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h40: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h80: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			5: begin			// A
				case(row)
					8'h01: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h02: 
					begin
						red <= 8'h24;
						green <= 8'h24;
					end
					8'h04: 
					begin
						red <= 8'h24;
						green <= 8'h24;
					end
					8'h08: 
					begin
						red <= 8'h7e;
						green <= 8'h7e;
					end
					8'h10: 
					begin
						red <= 8'h7e;
						green <= 8'h7e;
					end
					8'h20: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h40: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h80: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			6: begin			// R
				case(row)
					8'h01: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h02: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h04: 
					begin
						red <= 8'h3f;
						green <= 8'h3f;
					end
					8'h08: 
					begin
						red <= 8'h1f;
						green <= 8'h1f;
					end
					8'h10: 
					begin
						red <= 8'h3b;
						green <= 8'h3b;
					end
					8'h20: 
					begin
						red <= 8'h73;
						green <= 8'h73;
					end
					8'h40: 
					begin
						red <= 8'he3;
						green <= 8'he3;
					end
					8'h80: 
					begin
						red <= 8'h3f;
						green <= 8'h3f;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			7: begin			// T
				case(row)
					8'h01: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					8'h02: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h04: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h08: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h10: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h20: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h40: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h80: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			default: begin	// 默认状态
				case(row)
					8'h01: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h02: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h04: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h08: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h10: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h20: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h40: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					8'h80: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
			endcase
			cnt <= cnt + 1;
			if(cnt == 9'd500)		// 显示半秒
			begin
				cnt <= 9'h000;
				pic <= pic + 1;
			end
		end
		
		else if(~show)	// 准备状态
		begin
			green = 8'h00;
			red = 8'h00;
			count <= 11'h001;
		end
		
		else if(show)				// 显示此轮双方出拳结果及胜负关系
										// 绿胜红负，平局均为绿色
			if(|count)
			begin
				case(key)
				4'b0001:			// 石头对石头
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h00;
							green <= 8'he7;
						end
						8'h04: 
						begin
							red <= 8'h00;
							green <= 8'he7;
						end
						8'h08: 
						begin
							red <= 8'h00;
							green <= 8'he7;
						end
						8'h10: 
						begin
							red <= 8'h00;
							green <= 8'he7;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b0010:			// 石头对剪刀
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h04;
							green <= 8'he0;
						end
						8'h04: 
						begin
							red <= 8'h03;
							green <= 8'he0;
						end
						8'h08: 
						begin
							red <= 8'h03;
							green <= 8'he0;
						end
						8'h10: 
						begin
							red <= 8'h04;
							green <= 8'he0;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b0011:			// 石头对布
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'he0;
							green <= 8'h02;
						end
						8'h04: 
						begin
							red <= 8'he0;
							green <= 8'h07;
						end
						8'h08: 
						begin
							red <= 8'he0;
							green <= 8'h07;
						end
						8'h10: 
						begin
							red <= 8'he0;
							green <= 8'h02;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b0100:			// 剪刀对石头
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h20;
							green <= 8'h07;
						end
						8'h04: 
						begin
							red <= 8'hc0;
							green <= 8'h07;
						end
						8'h08: 
						begin
							red <= 8'hc0;
							green <= 8'h07;
						end
						8'h10: 
						begin
							red <= 8'h20;
							green <= 8'h07;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b0101:			// 剪刀对剪刀
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h00;
							green <= 8'h24;
						end
						8'h04: 
						begin
							red <= 8'h00;
							green <= 8'hc3;
						end
						8'h08: 
						begin
							red <= 8'h00;
							green <= 8'hc3;
						end
						8'h10: 
						begin
							red <= 8'h00;
							green <= 8'h24;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b0110:			// 剪刀对布
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h02;
							green <= 8'h20;
						end
						8'h04: 
						begin
							red <= 8'h07;
							green <= 8'hc0;
						end
						8'h08: 
						begin
							red <= 8'h07;
							green <= 8'hc0;
						end
						8'h10: 
						begin
							red <= 8'h02;
							green <= 8'h20;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b0111:			// 布对石头
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h07;
							green <= 8'h40;
						end
						8'h04: 
						begin
							red <= 8'h07;
							green <= 8'he0;
						end
						8'h08: 
						begin
							red <= 8'h07;
							green <= 8'he0;
						end
						8'h10: 
						begin
							red <= 8'h07;
							green <= 8'h40;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b1000:			// 布对剪刀
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h40;
							green <= 8'h04;
						end
						8'h04: 
						begin
							red <= 8'he0;
							green <= 8'h03;
						end
						8'h08: 
						begin
							red <= 8'he0;
							green <= 8'h03;
						end
						8'h10: 
						begin
							red <= 8'h40;
							green <= 8'h04;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				4'b1001:			// 布对布
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h00;
							green <= 8'h42;
						end
						8'h04: 
						begin
							red <= 8'h00;
							green <= 8'he7;
						end
						8'h08: 
						begin
							red <= 8'h00;
							green <= 8'he7;
						end
						8'h10: 
						begin
							red <= 8'h00;
							green <= 8'h42;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				default:			// 默认状态
				begin
					case(row)
						8'h01: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h02: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h04: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h08: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h10: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h20: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h40: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						8'h80: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
						default: 
						begin
							red <= 8'h00;
							green <= 8'h00;
						end
					endcase
				end
				endcase
			count <= count + 1;
			end
			else
				if((A != 3) && (B != 3))		// 显示控制
					count <= 11'h001;
		
		else if(^player)			// 结束动画
		begin
			if(over < 4)
			begin
				case(over)
				0: begin				// O
					case(row)
					8'h01: 
					begin
						red <= 8'h3c;
						green <= 8'h3c;
					end
					8'h02: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h04: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h08: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h10: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h20: 
					begin
						red <= 8'h3c;
						green <= 8'h3c;
					end
					8'h40: 
					begin
						red <= 8'h3c;
						green <= 8'h3c;
					end
					8'h80: 
					begin
						red <= 8'h3c;
						green <= 8'h3c;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
				1: begin				// V
					case(row)
					8'h01: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h02: 
					begin
						red <= 8'h42;
						green <= 8'h42;
					end
					8'h04: 
					begin
						red <= 8'h66;
						green <= 8'h66;
					end
					8'h08: 
					begin
						red <= 8'h24;
						green <= 8'h24;
					end
					8'h10: 
					begin
						red <= 8'h3c;
						green <= 8'h3c;
					end
					8'h20: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h40: 
					begin
						red <= 8'h18;
						green <= 8'h18;
					end
					8'h80: 
					begin
						red <= 8'h81;
						green <= 8'h81;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
				2: begin				// E
					case(row)
					8'h01: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					8'h02: 
					begin
						red <= 8'h03;
						green <= 8'h03;
					end
					8'h04: 
					begin
						red <= 8'h3f;
						green <= 8'h3f;
					end
					8'h08: 
					begin
						red <= 8'h3f;
						green <= 8'h3f;
					end
					8'h10: 
					begin
						red <= 8'h03;
						green <= 8'h03;
					end
					8'h20: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					8'h40: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					8'h80: 
					begin
						red <= 8'hff;
						green <= 8'hff;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
				3: begin				// R
					case(row)
					8'h01: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h02: 
					begin
						red <= 8'hc3;
						green <= 8'hc3;
					end
					8'h04: 
					begin
						red <= 8'h3f;
						green <= 8'h3f;
					end
					8'h08: 
					begin
						red <= 8'h1f;
						green <= 8'h1f;
					end
					8'h10: 
					begin
						red <= 8'h3b;
						green <= 8'h3b;
					end
					8'h20: 
					begin
						red <= 8'h73;
						green <= 8'h73;
					end
					8'h40: 
					begin
						red <= 8'he3;
						green <= 8'he3;
					end
					8'h80: 
					begin
						red <= 8'h3f;
						green <= 8'h3f;
					end
					default: 
					begin
						red <= 8'h00;
						green <= 8'h00;
					end
				endcase
				end
				endcase
				cnt <= cnt + 1;
				if(cnt == 'd500)
				begin
					cnt <= 9'h000;
					over <= over + 1;
				end
			end
			else
			begin
				case(player)
				2'b10: 
				begin
					red <= 8'h0f;
					green <= 8'hf0;
				end
				2'b01:
				begin
					red <= 8'hf0;
					green <= 8'h0f;
				end
				endcase
			end
		end
	
		

endmodule
