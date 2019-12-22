module alu (clk , opcode, input1, input2, carryout, result);
input [7:0] input1, input2;
input [3:0] opcode;
input clk;
reg [8:0] temp = 0;
output reg [7:0] result = 0;
output reg carryout = 0;

always @(posedge clk) 
	begin
	    
		case(opcode)
			4'b0000 : temp <= input1 + input2; // ADD
			4'b0001 : temp <= input1 - input2; //SUB (unsigned)
			4'b0010 : begin temp <= input1 + ~input2; if(temp[8]) temp = temp + 1; end //SUB (signed) 
			4'b0011 : temp [7:0] <= input1 | input2; //OR
			4'b0100 : temp [7:0] <= input1 & input2; //AND
			4'b0101 : temp [7:0] <= input1 ^ input2; //XOR
			4'b0110 : temp [7:0] <= ~input1; //NOT
			4'b0111 : temp [7:0] <= input1 << 1; // shiftleft input1
			4'b1000 : temp [7:0] <= input1 >> 1; // shiftright input1
			4'b1001 : temp [7:0] <= {input1[6:0], input1[7]};//rotate left input1
			4'b1010 : temp [7:0] <= {input1[0], input1[7:1]}; //rotate right input1
			default : temp <= temp;
		endcase
		//yg logic (and, or, gitu2) ga main carryout jd tempnya cm masuk bit 7-0 yg 8 diemin
		carryout <= temp[8]; // tidak sequential
		result <= temp;
	end
endmodule