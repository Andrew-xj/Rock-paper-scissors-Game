`timescale 1ns / 100ps
module round_tb;

	reg clk, clk_1k, rst;
	reg [3:0] key;
	reg ready, start;
	wire [7:0] col_r, col_g, row_o;
	wire [3:0] A, B;
	
	// 设置时钟信号
	// 50MHz
	parameter CLOCK = 20;
	initial
		clk = 0;
	always
		#(CLOCK/2) clk = ~clk;
	// 1kHz
	initial
		clk_1k = 0;
	always
		#(CLOCK*25_000) clk_1k = ~clk_1k;
	
	// 设置复位信号
	initial
	begin
		rst = 0;
		#(CLOCK) rst = 1;
	end
	
	// 设置比赛状态（为方便起见，始终置为状态0001）
	initial
		key = 'd1;
	
	// 设置准备、开始脉冲
	initial
	begin
		ready = 0;
		start = 0;
		#(CLOCK*50_000_000*4) ready = 0;	// 延时4s
	end
	always
	begin
		#(CLOCK*50_000_000-1) ready = 1;
		#1 ready = 0;
		#(CLOCK*50_000_000-1) start = 1;
		#1 start = 0;
	end
	
	round r1(.clk(clk), .clk_1k(clk_1k), .rst(rst),
				.key(key), .ready(ready), .start(start),
				.col_r(col_r), .col_g(col_g), .row_o(row_o),
				.A(A), .B(B));

endmodule
