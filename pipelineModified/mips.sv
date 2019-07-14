module mips(input clk, reset,
output [31:0] pcF,
input [31:0] instrF,
output memwriteM,sbM,
output [31:0] aluoutM, writedataM,
input [31:0] readdataM,
input [31:0] srcaD,srca2E,srcbD,srcb3E);



reg [5:0] opD, functD;
reg regdstE, alusrcE,jalD,jrD,lbW,muldivE,mflM,mfhM,
pcsrcD,
memtoregE, memtoregM, memtoregW,
regwriteE, regwriteM, regwriteW;
reg [3:0] alucontrolE;

reg flushE, equalD;


controller c(clk, reset, opD, functD, flushE,
equalD,memtoregE, memtoregM,
memtoregW, memwriteM, pcsrcD,
branchD,bneD,alusrcE, regdstE, regwriteE,
regwriteM, regwriteW, jumpD,jalD,jrD,lbW,sbM,muldivE,mflM,mfhM,
alucontrolE);


			
datapath dp(clk, reset, memtoregE, memtoregM,
memtoregW, pcsrcD, branchD,bneD,
alusrcE, regdstE, regwriteE,
regwriteM, regwriteW, jumpD,jalD,jrD,lbW,muldivE,mflM,mfhM,
alucontrolE,equalD, pcF, instrF,
aluoutM, writedataM, readdataM,
opD, functD, flushE,
srcaD,srca2E,srcbD,srcb3E);

endmodule

