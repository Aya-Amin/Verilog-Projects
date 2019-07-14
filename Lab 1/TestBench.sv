module alutestbench();

	reg clk,reset;
	reg a, b, f, yexpected, zeroexpected;
	wire y,zero;
	reg [31:0] vectornum, errors;
	reg [103:0] testvectors [10000:0];
	
	//instansiate device under test
	alu dut(a, b, c, y, zero);

	//generate clock
	always
		begin
			clk = 1;#5; clk = 0;#5;
		end
	
	//at start of test, load vectors and oulse reset
	initial
		begin
			$readmemh("alu.tv",testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #27; reset = 0;
		end
	
	//apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
			#1; {a,b,f,yexpected,zeroexpected} =
					 testvectors[vectornum];
		end 

	//check results on falling edge of clk
	always @(negedge clk)
		
		if(~reset)
		begin
			if(y != yexpected)
			begin
				$display("Error: inputs = %b", {a,b,f});
				$display("Y Output = %b (%b expected)", y,yexpected);
				$display("Zero Output = %b (%b expected)", zero,zeroexpected);
				errors = errors + 1;
			end

			vectornum = vectornum + 1;

			if(testvectors[vectornum] === 4'bx)
			begin
				$display("%d tests completed with %d errors", vectornum,errors);
				$finish;
			end
		end

			
endmodule
