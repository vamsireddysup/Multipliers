module carry_save_adder(
input [3:0] w,x,y,z,
output cout,
output [4:0]sum
    );
    wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11;
    wire s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11;
 //1st csa begins   
fulladder f1(x[0],y[0],z[0],c0,s0);
fulladder f2(x[1],y[1],z[1],c1,s1);
fulladder f3(x[2],y[2],z[2],c2,s2);
fulladder f4(x[3],y[3],z[3],c3,s3);
//2nd CSA begins
halfadder f5(s0,w[0],c4,s4);//halfadder
fulladder f6(c0,s1,w[1],c5,s5);
fulladder f7(c1,s2,w[2],c6,s6);
fulladder f8(c2,s3,w[3],c7,s7);
//3rd Carry Propagation adder begins
halfadder f9(c4,s5,c8,s8);
fulladder f10(c8,c5,s6,c9,s9);
fulladder f11(c9,c6,s7,c10,s10);
fulladder f12(c10,c7,c3,c11,s11);
assign sum[0] = s4;
assign sum[1] = s8;
assign sum[2] = s9;
assign sum[3] = s10;
assign sum[4] = s11;
assign cout = c11;

endmodule

module fulladder(a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;

    wire x, y, z;

    assign x = a ^ b;
    assign y = a & b;
    assign sum = x ^ cin;
    assign z = x & cin;
    assign cout = z | y;
endmodule
module halfadder(
input a,b,
output cout,sum
);
assign sum = a^b;
assign cout = a&b;
endmodule