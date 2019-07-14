module mux3 #(parameter WIDTH = 8)

(input [WIDTH-1:0] d0, d1, d2,
input [1:0] s,
output [WIDTH-1:0] y);

assign #1
 y = s[1] ? d2 : (s[0] ? d1 : d0);


endmodule
