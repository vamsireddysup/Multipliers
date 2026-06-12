`timescale 1ns / 1ps

//Approximated CSA adder with Approximated Majority Logic adder 1
/*
module acsa1(
input [7:0]w,x,y,z,
output cout,
output [8:0]sum
);

    //wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c23;
    //wire s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s23;
//1st round
amla f1(x[0],y[0],z[0],c0,s0);
amla f2(x[1],y[1],z[1],c1,s1);
amla f3(x[2],y[2],z[2],c2,s2);
amla f4(x[3],y[3],z[3],c3,s3);
amla f5(x[4],y[4],z[4],c4,s4);
amla f6(x[5],y[5],z[5],c5,s5);
amla f7(x[6],y[6],z[6],c6,s6);
amla f8(x[7],y[7],z[7],c7,s7);

//2nd round
amla f9(s0,w[0],0,c8,s8);//halfadder
amla f10(c0,s1,w[1],c9,s9);
amla f11(c1,s2,w[2],c10,s10);
amla f12(c2,s3,w[3],c11,s11);
amla f13(c3,s4,w[4],c12,s12);
amla f14(c4,s5,w[5],c13,s13);
amla f15(c5,s6,w[6],c14,s14);
amla f16(c6,s7,w[7],c15,s15);


//3rd stage
amla f17(c8,s9,0,c16,s16);
amla f18(c9,c16,s10,c17,s17);
amla f19(c10,c17,s11,c18,s18);
amla f20(c11,c18,s12,c19,s19);
amla f21(c12,c19,s13,c20,s20);
amla f22(c13,c20,s14,c21,s21);
amla f23(c14,c21,s15,c22,s22);
amla f24(c15,c22,c7,c23,s23);

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




module amla(
input a,b,c,
output cout,sum
    );
    assign cout=(a&b)|(b&c)|(c&a);
    assign sum=(a&b)|(b&(~c))|((~c)&a);
endmodule
*/

module acsa1(
input [15:0]w,x,y,z,
output cout,
output [16:0]sum
);

    //wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c23;
    //wire s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s23;
//1st round
amla f1(w[0],x[0],y[0],c0,s0);
amla f2(w[1],x[1],y[1],c1,s1);
amla f3(w[2],x[2],y[2],c2,s2);
amla f4(w[3],x[3],y[3],c3,s3);
amla f5(w[4],x[4],y[4],c4,s4);
amla f6(w[5],x[5],y[5],c5,s5);
amla f7(w[6],x[6],y[6],c6,s6);
amla f8(w[7],x[7],y[7],c7,s7);
amla f9(w[8],x[8],y[8],c8,s8);
amla f10(w[9],x[9],y[9],c9,s9);
amla f11(w[10],x[10],y[10],c10,s10);
amla f12(w[11],x[11],y[11],c11,s11);
amla f13(w[12],x[12],y[12],c12,s12);
amla f14(w[13],x[13],y[13],c13,s13);
amla f15(w[14],x[14],y[14],c14,s14);
amla f16(w[15],x[15],y[15],c15,s15);

//2ns stage

amla f17(z[0],s0,0,c16,s16);
amla f18(z[1],c0,s1,c17,s17);
amla f19(z[2],c1,s2,c18,s18);
amla f20(z[3],c2,s3,c19,s19);
amla f21(z[4],c3,s4,c20,s20);
amla f22(z[5],c4,s5,c21,s21);
amla f23(z[6],c5,s6,c22,s22);
amla f24(z[7],c6,s7,c23,s23);
amla f25(z[8],c7,s8,c24,s24);
amla f26(z[9],c8,s9,c25,s25);
amla f27(z[10],c9,s10,c26,s26);
amla f28(z[11],c10,s11,c27,s27);
amla f29(z[12],c11,s12,c28,s28);
amla f30(z[13],c12,s13,c29,s29);
amla f31(z[14],c13,s14,c30,s30);
amla f32(z[15],c14,s15,c31,s31);

//3rd stage

amla fa33(c16,s17,0,c32,s32);
amla fa34(c17,s18,c32,c33,s33);
amla fa35(c18,s19,c33,c34,s34);
amla fa36(c19,s20,c34,c35,s35);
amla fa37(c20,s21,c35,c36,s36);
amla fa38(c21,s22,c36,c37,s37);
amla fa39(c22,s23,c37,c38,s38);
amla fa40(c23,s24,c38,c39,s39);
amla fa41(c24,s25,c39,c40,s40);
amla fa42(c25,s26,c40,c41,s41);
amla fa43(c26,s27,c41,c42,s42);
amla fa44(c27,s28,c42,c43,s43);
amla fa45(c28,s29,c43,c44,s44);
amla fa46(c29,s30,c44,c45,s45);
amla fa47(c30,s31,c45,c46,s46);
amla fa48(c31,c15,c46,c47,s47);

assign sum[0] = s16;
assign sum[1] = s32;
assign sum[2] = s33;
assign sum[3] = s34;
assign sum[4] = s35;
assign sum[5] = s36;
assign sum[6] = s37;
assign sum[7] = s38;
assign sum[8] = s39;
assign sum[9] = s40;
assign sum[10] = s41;
assign sum[11] = s42;
assign sum[12] = s43;
assign sum[13] = s44;
assign sum[14] = s45;
assign sum[15] = s46;
assign sum[16] = s47;
assign cout = s47;


endmodule



module amla(
input a,b,c,
output cout,sum
    );
    assign cout=(a&b)|(b&c)|(c&a);
    assign sum=(a&b)|(b&(~c))|((~c)&a);
endmodule