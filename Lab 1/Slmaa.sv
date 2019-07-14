module alu (input logic [31:0]	a,b,	
	    input logic [3:0] 	f,
	    output logic [31:0] y,
	    output logic     [3:0] zero);

	reg [31:0] s;

	always @(*)
		begin
			case(f)
				
				//add
				2: y = a + b;

				//Sub 
				6: y = a - b;
	
				//Lst
				7:
				 begin
				 	s = a - b;	
					  if(s[31])
						y = 32'h00000001;
					  else
						y = 32'h00000000;	
				 end
				
				//And     
				1: y = a & b;

				//Or
				3: y = a | b;
			
				default: y = 32'h00000000;
			endcase
	
			//set zero flag
			zero = y ? 0 : 1; 		
				
		end
endmodule
