module regbank (clk, clear, ctrl, reg1, reg2, write, datareg, read1, read2);
	input clk, clear, ctrl;
	input [1:0] reg1, reg2, write;
	input [7:0] datareg;
	output reg [7:0] read1, read2;
	reg [7:0] registerfile [3:0];
	
	initial registerfile [0] <= 0;
	initial registerfile [1] <= 0;
	initial registerfile [2] <= 0;
	initial registerfile [3] <= 0;
	
	always @(negedge clk) 
	begin 
		if(ctrl) registerfile[write] <= datareg; 
			
		if(clear) 
		   begin
				registerfile [0] <= 0;
				registerfile [1] <= 0;
				registerfile [2] <= 0;
				registerfile [3] <= 0;
			end
			
		read1 <= registerfile[reg1]; 
		read2 <= registerfile[reg2];
	end
endmodule
