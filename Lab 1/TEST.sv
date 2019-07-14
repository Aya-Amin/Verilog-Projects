
//‘timescale 1ns/1ns
module alutestbench();

	reg clk,reset;
	reg [31:0] a, b, yexpected;
	reg [3:0]zeroexpected;
	reg [3:0] f; 
	wire[31:0] y;
	wire[3:0] zero;
	reg [31:0] vectornum, errors;
	reg [103:0] testvectors [10000:0];
	
	//instansiate device under test
	alu dut(a, b, f, y, zero);

	//generate clock
	always
		begin
			clk = 1; #5; clk = 0; #5;
		end
	
	//at start of test, load vectors and pulse reset
	initial
		begin
			$readmemh("vectors.tv",testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #27; reset = 0;
		end
	
	//apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			#1; {a,b,f,yexpected,zeroexpected} =testvectors[vectornum];
                          
		end 

	//check results on falling edge of clk
	always @(negedge clk)
		
		if(~reset)
		begin
			if(y !== yexpected | zero !== zeroexpected)
			begin
				$display("Error: inputs = a:%h,b:%h,F:%h",a,b,f);
				$display("Y Output = %h (%h expected)", y,yexpected);
				$display("Zero Output = %h (%h expected)", zero,zeroexpected);
				errors = errors + 1;
			end

			vectornum = vectornum + 1;

			if(vectornum===21'h4)
			begin
				$display("%d tests completed with %d errors", vectornum,errors);
				$finish;
			end
		end

			
endmodule