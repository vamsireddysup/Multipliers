module kogge_stone_adder(
input [3:0]a,b,
input cin,
output cout,
output [4:0]sum
    );
    wire p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11;
    wire g0,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11;
    wire c0,c1,c2,c3;
//legend
assign p0 = a[0]^b[0];
assign g0 = a[0]&b[0];
assign p1 = a[1]^b[1];
assign g1 = a[1]&b[1];
assign p2 = a[2]^b[2];
assign g2 = a[2]&b[2];
assign p3 = a[3]^b[3];
assign g3 = a[3]&b[3];
//2nd stage
//p0g0 remains same
assign p4 = p0;
assign g4 = g0;
assign p5 = p1&p0;
assign g5 = (p1&g0)|g1;
assign p6 = p2&p1;
assign g6 = (p2&g1)|g2;
assign p7 = p3&p2;
assign g7 = (p3&g2)|g3;
//3rd round
assign p8 = p4;
assign g8 = g4;
assign p9 = p5;
assign g9 = g5;
assign p10 = p6&p4;
assign g10 = (p6&g4)|g6;
assign p11 = p7&p5;
assign g11 = (p7&g5)|g7;
assign sum[0] = p0^cin;
assign sum[1] = p1^c0;
assign sum[2] = p2^c1;
assign sum[3] = p3^c2;
assign sum[4] = c3;
assign c0 = g4;
assign c1= g5;
assign c2 = g6;
assign c3 = g7;
//assign cout  = c3;
endmodule
