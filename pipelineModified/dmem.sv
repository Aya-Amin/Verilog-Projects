module dmem (input clk, we,sbM,
				
input [31:0] a, wd,
				
output [31:0] rd);

	
reg [31:0] RAM[63:0];
	
assign rd = RAM[a[31:2]]; 
// word aligned
	
	
always @ (posedge clk)
	
if (we & ~sbM)
	
RAM[a[31:2]] <= wd;
	
else if (we & sbM)
	
RAM[a[31:2]] <= RAM[a[31:2]][31:8] & wd[7:0];
	
	
endmodule
