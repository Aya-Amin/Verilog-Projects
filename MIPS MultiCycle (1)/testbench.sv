module testbench();

	reg clk,reset;
	//reg reset1;
	reg [5:0] op, funct;
	reg zero;

        

        reg        pcen, memwrite, irwrite, regwrite;
        reg        alusrca, iord, memtoreg, regdst;
        reg  [1:0] alusrcb;
	reg  [1:0] pcsrc;
        reg  [2:0] alucontrol;

	reg        pcenexpected, memwriteexpected, irwriteexpected, regwriteexpected;
        reg        alusrcaexpected, iordexpected, memtoregexpected, regdstexpected;
        reg  [1:0] alusrcbexpected;
	reg  [1:0] pcsrcexpected;
        reg  [2:0] alucontrolexpected;

	

	reg [31:0] vectornum, errors;
	reg [103:0] testvectors [10000:0];
	reg  [14:0] controls, controlsexpected;

         
	


	//instansiate device under test
	controller dut(clk, reset, op, funct, zero 
			,pcen, memwrite, irwrite, regwrite,
			alusrca, iord, memtoreg, regdst
			,alusrcb, pcsrc, alucontrol);



	//generate clock
	always
		begin
			clk = 1; #5; clk = 0; #5;
			//reset1 = 1; #5; reset1 = 0; #5;

 			
			
		end
	
	//at start of test, load vectors and pulse reset
	initial
		begin
			$readmemb("C:\\Users\\adelm\\Desktop\\MIPS MultiCycle (1)\\test.tv",testvectors);
			vectornum = 0; errors = 0;
                        reset = 1; #27; reset = 0;
			
			
		end

	
	
	//apply test vectors on rising edge of clk
	always @(posedge clk)
		begin
		        #1;{op,funct,zero, pcenexpected, memwriteexpected, irwriteexpected, regwriteexpected
             			,alusrcaexpected, iordexpected, memtoregexpected, regdstexpected
        			 ,alusrcbexpected, pcsrcexpected, alucontrolexpected} = testvectors[vectornum];

			assign controlsexpected = {pcenexpected, memwriteexpected, irwriteexpected, regwriteexpected,alusrcaexpected, iordexpected, 
			memtoregexpected, regdstexpected,alusrcbexpected,pcsrcexpected,alucontrolexpected};


	               assign controls = {pcen, memwrite, irwrite, regwrite,alusrca, iord, 
				memtoreg, regdst,alusrcb,pcsrc,alucontrol};


                          
		end 

	//check results on falling edge of clk
	always @(negedge clk)
		
		if(~reset)
		begin
			if(  controls!==  controlsexpected)
			begin
				$display("Error: inputs = op:%b,funct:%b,clk:%b,reset:%b",op,funct,clk,reset);
				$display("controls Output = %b (%b expected)", controls,controlsexpected);
				errors = errors + 1;
			end

			vectornum = vectornum + 1;

			if(vectornum === 23)
			begin
				$display("controls Output = %h (%h expected)",  controls, controlsexpected);
                                $display("%d tests completed with %d errors", vectornum,errors);
				$finish;
			end
		end

			
endmodule