module behaviour (clk, address, data);
input clk;
input [7:0] address;
output reg [7:0] data;

always@(posedge clk)begin
	case (address)
		8'b00000000 : data <= 8'b10110010; //load (data) to register 2
		8'b00000001 : data <= 8'b10110000; //load (data) to register 0
		8'b00000010 : data <= 8'b10001000; //lrotate register 2
		8'b00000011 : data <= 8'b00001000; //add register 2 to register 0
		8'b00000100 : data <= 8'b01010000; //not register 0
		8'b00000101 : data <= 8'b11111111; //do nothing
		8'b00000110 : data <= 8'b10110001; //load (data) to register 1
		8'b00000111 : data <= 8'b10100000; //clear registers
		8'b00001000 : data <= 8'b10000111; //subtract register 1 to register 3
		8'b00001001 : data <= 8'b11000000; //jump to address (data)
	endcase //data = 5
end
endmodule