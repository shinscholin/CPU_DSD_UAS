module cpufinal_tb;
reg clk, rst;
reg [7:0] dataa;
wire [7:0] addr_out, out;
wire [7:0] data_in, data;

cpufinal CPU (.clk (clk), .rst (rst), .data (data), .data_in (data_in), .addr_out (addr_out), .out (out));
behaviour ROM (.clk (clk), .address (addr_out), .data (data_in));

initial begin
clk = 0;
rst = 0;
dataa = 5;
end
assign data = dataa;

always #5 clk = !clk;
initial begin
#250 rst = 1;
#50 rst = 0;
end

initial begin
	$dumpfile ("CPU.vcd");
	$dumpvars;
end

initial begin
	$display ("\t \t \t \t time \t clk rst address instruction data \t output");
	$monitor ("%d \t %b \t %b \t %b %b %b %b", $time, clk, rst, addr_out, data_in, data, out);
end
	
initial #600 $finish;
endmodule
