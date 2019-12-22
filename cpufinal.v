module cpufinal (clk, rst, data, data_in, addr_out, out);
input clk, rst;
input [7:0] data_in, data;
output [7:0] addr_out, out;
wire ctrl0, ctrl1, carryout, clear;
wire [1:0] reg1, reg2, write;
wire [3:0] opcode;
wire [7:0] address, input1, input2, result, datareg, read1, read2, instruction;


cu2 CU (.clk (clk), .rst (rst),
				.ctrl0 (ctrl0), .address (address), .instruction (instruction), .data (data),
				.opcode (opcode), .input1 (input1), .input2 (input2), .carryout (carryout), .result (result), 
				.ctrl1 (ctrl1), .clear (clear), .reg1 (reg1), .reg2 (reg2), .write (write), .datareg (datareg), .read1 (read1), .read2 (read2), 
				.out (out));
				
memory MEM (.clk (clk), .ctrl (ctrl0), .address (address), .data_in (data_in), .addr_out (addr_out), .instruction (instruction));

alu ALU (.clk (clk), .opcode (opcode), .input1 (input1), .input2 (input2), .carryout (carryout), .result (result));

regbank BANK (.clk (clk), .clear (clear), .ctrl (ctrl1), .reg1 (reg1), .reg2 (reg2), .write (write), .datareg (datareg), .read1 (read1), .read2 (read2));

endmodule