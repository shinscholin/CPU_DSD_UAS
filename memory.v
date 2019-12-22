module memory (clk, ctrl, address, data_in, addr_out, instruction);
	input clk, ctrl;
	input [7:0] address; //input from CU
	input [7:0] data_in;//input from memory 
	output reg [7:0] addr_out = 0; //output to memory
	output reg [7:0] instruction = 0;//output to CU
		
	always @(posedge clk) begin
		//ctrl 0 = read; ctrl 1 = write;
		if(!ctrl)
			addr_out <= address;
		else
			instruction <= data_in;
	end
endmodule
