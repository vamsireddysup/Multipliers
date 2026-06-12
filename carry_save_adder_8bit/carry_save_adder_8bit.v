module carry_save_adder_8bit(
input [7:0]w,x,y,z,
output cout,
output [8:0]sum
);

    wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c23;
    wire s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s23;
//1st round
fulladder f1(x[0],y[0],z[0],c0,s0);
fulladder f2(x[1],y[1],z[1],c1,s1);
fulladder f3(x[2],y[2],z[2],c2,s2);
fulladder f4(x[3],y[3],z[3],c3,s3);
fulladder f5(x[4],y[4],z[4],c4,s4);
fulladder f6(x[5],y[5],z[5],c5,s5);
fulladder f7(x[6],y[6],z[6],c6,s6);
fulladder f8(x[7],y[7],z[7],c7,s7);

//2nd round
halfadder f9(s0,w[0],c8,s8);//halfadder
fulladder f10(c0,s1,w[1],c9,s9);
fulladder f11(c1,s2,w[2],c10,s10);
fulladder f12(c2,s3,w[3],c11,s11);
fulladder f13(c3,s4,w[4],c12,s12);
fulladder f14(c4,s5,w[5],c13,s13);
fulladder f15(c5,s6,w[6],c14,s14);
fulladder f16(c6,s7,w[7],c15,s15);


//3rd stage
halfadder f17(c8,s9,c16,s16);
fulladder f18(c9,c16,s10,c17,s17);
fulladder f19(c10,c17,s11,c18,s18);
fulladder f20(c11,c18,s12,c19,s19);
fulladder f21(c12,c19,s13,c20,s20);
fulladder f22(c13,c20,s14,c21,s21);
fulladder f23(c14,c21,s15,c22,s22);
fulladder f24(c15,c22,c7,c23,s23);

assign cout = c23;
assign sum[0] = s8;
assign sum[1] = s16;
assign sum[2] = s17;
assign sum[3] = s18;
assign sum[4] = s19;
assign sum[5] = s20;
assign sum[6] = s21;
assign sum[7] = s22;
assign sum[8] = s23;


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
