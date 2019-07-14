module controller(input clk, reset,
input [5:0] opD, functD,
input flushE, equalD,
output memtoregE, memtoregM,
output memtoregW, memwriteM,
output pcsrcD, branchD,bneD,alusrcE,
output  regdstE, regwriteE,
output  regwriteM, regwriteW,
output jumpD,jalD,jrD,lbW,sbM,muldivE,mfloM,mfhiM,
output [3:0] alucontrolE);

reg [2:0] aluopD;
reg memtoregD, memwriteD, alusrcD,
regdstD, regwriteD,lbD,sbD,lbE,lbM,sbE,muldivD,mfloD,mfhiD,mfloE,mfhiE;
reg [3:0] alucontrolD;
reg memwriteE;


maindec md(opD,functD,memtoregD, memwriteD, branchD,bneD,
alusrcD, regdstD, regwriteD, jumpD,jalD,jrD,lbD,sbD,muldivD,mfloD,mfhiD,
aluopD);

aludec ad(functD, aluopD, alucontrolD);

assign pcsrcD = (branchD & equalD) | (bneD & ~equalD);

// pipeline registers

floprc #(14) regE(clk, reset, flushE,
{memtoregD, memwriteD, alusrcD,
regdstD, regwriteD, alucontrolD,muldivD,mfloD,mfhiD,sbD,lbD},
{memtoregE, memwriteE, alusrcE,
regdstE, regwriteE, alucontrolE,muldivE,mfloE,mfhiE,sbE,lbE});

flopr #(7) regM(clk, reset,
{memtoregE, memwriteE, regwriteE,mfloE,mfhiE,sbE,lbE},
{memtoregM, memwriteM, regwriteM,mfloM,mfhiM,sbM,lbM});


flopr #(3) regW(clk, reset,
{memtoregM, regwriteM,lbM},
{memtoregW, regwriteW,lbW});



endmodule
