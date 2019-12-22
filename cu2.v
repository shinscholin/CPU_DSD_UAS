module cu2 (clk, rst,
				ctrl0, address, instruction, data,
				opcode, input1, input2, carryout, result, 
				ctrl1, clear, reg1, reg2, write, datareg, read1, read2, 
				out);
input clk, rst, carryout;
input [7:0] result, read1, read2;
input [7:0] instruction, data;
output reg ctrl0 = 0, ctrl1, clear;
output reg [1:0] reg1, reg2, write;
output reg [3:0] opcode;
output reg [7:0] address, input1, input2, datareg, out;
reg jump = 0, nop, single;
reg [1:0] cycle = 0;
reg [7:0] jumpaddress, inst, instruction_c, temp = 0;

always @ (*) begin
	instruction_c <= instruction;
	single <= (instruction_c[7:4] <= 4'b1010);
	nop <= (instruction_c == 8'b11111111);
	
end

always @ (posedge clk) begin
	if(rst) begin //clear output
        jump <= 0;
	    temp <= 0;
		address <= 0;
		out <= 0;
		ctrl0 <= 0;
		ctrl1 <= 0;
		clear  <= 0;
		reg1 <= 0;
		reg2 <= 0;
		write  <= 0;
		opcode <= 0;
		input1 <= 0;
		input2 <= 0;
		datareg <= 0;
		cycle <= 2'b11;
	end
    
    if(cycle == 2'b00) 
    begin //program counter
		if (jump) temp <= jumpaddress; 
		else temp <= temp + 1;
		
		if (ctrl0) begin //send counter
		    ctrl0 <= 0;
			cycle <= 2'b01;
		end
		address <= temp;
		cycle <= 2'b01;
	end
	
	else if (cycle == 2'b01) begin //fetch
        jump <= 0;
		
		if(!ctrl0) begin //get instruction
			jump <= 0;
			ctrl0 <= 1;
			inst <= instruction;
			cycle <= 2'b01;
		end
		
		
		if (single) begin //do single cycle operation
			if(instruction_c[7:4] == 4'b1010) clear <= 1;
			else begin
				clear <= 0;
				ctrl1 <= 1;
				reg1 <= instruction_c[3:2];
				reg2 <= instruction_c[1:0];
				input1 <= read1;
				input2 <= read2;
				opcode <= instruction_c[7:4];
				if(instruction_c[7:4] <= 4'b0101) write <= instruction_c[1:0];
				else write <= instruction_c[3:2];
				datareg <= result;
				out <= datareg;
			end
			cycle <= 2'b00;
		end
		else begin
			if (nop) cycle <= 2'b00;
			else cycle <= 2'b10;
		end
	end
	
	else if (cycle == 2'b10) begin //do two cycle operation 
		case (inst[7:4])
			4'b1011 : begin //load to register
							ctrl1 <= 1;
							write <= inst[1:0];
							datareg <= data;
							out <= datareg;
							cycle <= 2'b00;
						end
			4'b1100 : begin //jump
							jump <= 1;
							jumpaddress <= data;
							cycle <= 2'b11;
						end
			4'b1101 : begin
			                if (carryout) jump <= 1;
			                jumpaddress <= data;
			                cycle <= 2'b11;
			            end
		endcase
	end
	
	else if (cycle == 2'b11) begin
		inst <= instruction;
		cycle <= 2'b00;
		end
end
endmodule