`timescale 1ns / 1ps
//approximation done in lsb using 4:2 compressor and
// in mSB used exact carry save adder
module radix4_8bit_approx2(
input [7:0]m,q,
output [15:0]prod
    );
    
    wire [2:0]br[3:0];
    wire [9:0]pp[3:0];
    wire [15:0]spp[3:0];
    wire [15:0]s;
    //wire [8:0]inv_m;
    assign br[0]={q[1],q[0],1'b0};
    assign br[1]={q[3],q[2],q[1]};
    assign br[2]={q[5],q[4],q[3]};
    assign br[3]={q[7],q[6],q[5]};
    
    partial_product pp0(.m(m), .br(br[0]), .pp(pp[0]));
    partial_product pp1(.m(m), .br(br[1]), .pp(pp[1]));
    partial_product pp2(.m(m), .br(br[2]), .pp(pp[2]));
    partial_product pp3(.m(m), .br(br[3]), .pp(pp[3]));
    
    sign_extend se0(.in(pp[0]), .out(spp[0]));
    sign_extend se1(.in(pp[1]), .out(spp[1]));
    sign_extend se2(.in(pp[2]), .out(spp[2]));
    sign_extend se3(.in(pp[3]), .out(spp[3]));
    
    // AC 8
    approx1_4x2com cm0(spp[0][0],0,0,0,0,c0,prod[0]);
    approx1_4x2com cm1(spp[0][1],0,0,0,c0,c1,prod[1]);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,c1,c2,prod[2]);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,c2,c3,prod[3]);
    approx1_4x2com cm4(spp[0][4],spp[1][2],spp[2][0],0,c3,c4,prod[4]);
    approx1_4x2com cm5(spp[0][5],spp[1][3],spp[2][1],0,c4,c5,prod[5]);
    approx1_4x2com cm6(spp[0][6],spp[1][4],spp[2][2],spp[3][0],c5,c6,prod[6]);
    approx1_4x2com cm7(spp[0][7],spp[1][5],spp[2][3],spp[3][1],c6,c7,prod[7]);
    csa cs1(spp[0][15:8],spp[1][15:6],spp[2][15:4],spp[3][15:2],cout,s[7:0]);
    
    halfadder h1(s[0],c7,c8,prod[8]);
    halfadder h2(s[1],c8,c9,prod[9]);
    halfadder h3(s[2],c9,c10,prod[10]);
    halfadder h4(s[3],c10,c11,prod[11]);
    halfadder h5(s[4],c11,c12,prod[12]);
    halfadder h6(s[5],c12,c13,prod[13]);
    halfadder h7(s[6],c13,c14,prod[14]);
    halfadder h8(s[7],c14,c15,prod[15]);
    
    //AC 2
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,c0,prod[0]);
    approx1_4x2com cm1(spp[0][1],0,0,0,c0,c1,prod[1]);
    csa cs1(spp[0][15:2],spp[1][15:0],spp[2][15:0]<<2,spp[3][15:0]<<4,cout,s[13:0]);
    halfadder h1(s[0],c1,c2,prod[2]);
    halfadder h2(s[1],c2,c3,prod[3]);
    halfadder h3(s[2],c3,c4,prod[4]);
    halfadder h4(s[3],c4,c5,prod[5]);
    halfadder h5(s[4],c5,c6,prod[6]);
    halfadder h6(s[5],c6,c7,prod[7]);
    halfadder h7(s[6],c7,c8,prod[8]);
    halfadder h8(s[7],c8,c9,prod[9]);
    halfadder h9(s[8],c9,c10,prod[10]);
    halfadder h10(s[9],c10,c11,prod[11]);
    halfadder h11(s[10],c11,c12,prod[12]);
    halfadder h12(s[11],c12,c13,prod[13]);
    halfadder h13(s[12],c13,c14,prod[14]);
    halfadder h14(s[13],c14,c15,prod[15]);*/
    
    //AC 4
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,c0,prod[0]);
    approx1_4x2com cm1(spp[0][1],0,0,0,c0,c1,prod[1]);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,c1,c2,prod[2]);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,c2,c3,prod[3]);
    csa cs1(spp[0][15:4],spp[1][15:2],spp[2][15:0],spp[3][15:0]<<2,cout,s[11:0]);
    halfadder h1(s[0],c3,c4,prod[4]);
    halfadder h2(s[1],c4,c5,prod[5]);
    halfadder h3(s[2],c5,c6,prod[6]);
    halfadder h4(s[3],c6,c7,prod[7]);
    halfadder h5(s[4],c7,c8,prod[8]);
    halfadder h6(s[5],c8,c9,prod[9]);
    halfadder h7(s[6],c9,c10,prod[10]);
    halfadder h8(s[7],c10,c11,prod[11]);
    halfadder h9(s[8],c11,c12,prod[12]);
    halfadder h10(s[9],c12,c13,prod[13]);
    halfadder h11(s[10],c13,c14,prod[14]);
    halfadder h12(s[11],c14,c15,prod[15]);*/
    
    //AC 6
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,c0,prod[0]);
    approx1_4x2com cm1(spp[0][1],0,0,0,c0,c1,prod[1]);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,c1,c2,prod[2]);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,c2,c3,prod[3]);
    approx1_4x2com cm4(spp[0][4],spp[1][2],spp[2][0],0,c3,c4,prod[4]);
    approx1_4x2com cm5(spp[0][5],spp[1][3],spp[2][1],0,c4,c5,prod[5]);
    csa cs1(spp[0][15:6],spp[1][15:4],spp[2][15:2],spp[3][15:0],cout,s[9:0]);
    halfadder h1(s[0],c5,c6,prod[6]);
    halfadder h2(s[1],c6,c7,prod[7]);
    halfadder h3(s[2],c7,c8,prod[8]);
    halfadder h4(s[3],c8,c9,prod[9]);
    halfadder h5(s[4],c9,c10,prod[10]);
    halfadder h6(s[5],c10,c11,prod[11]);
    halfadder h7(s[6],c11,c12,prod[12]);
    halfadder h8(s[7],c12,c13,prod[13]);
    halfadder h9(s[8],c13,c14,prod[14]);
    halfadder h10(s[9],c14,c15,prod[15]);*/
    
    //AC 10
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,c0,prod[0]);
    approx1_4x2com cm1(spp[0][1],0,0,0,c0,c1,prod[1]);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,c1,c2,prod[2]);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,c2,c3,prod[3]);
    approx1_4x2com cm4(spp[0][4],spp[1][2],spp[2][0],0,c3,c4,prod[4]);
    approx1_4x2com cm5(spp[0][5],spp[1][3],spp[2][1],0,c4,c5,prod[5]);
    approx1_4x2com cm6(spp[0][6],spp[1][4],spp[2][2],spp[3][0],c5,c6,prod[6]);
    approx1_4x2com cm7(spp[0][7],spp[1][5],spp[2][3],spp[3][1],c6,c7,prod[7]);
    approx1_4x2com cm8(spp[0][8],spp[1][6],spp[2][4],spp[3][2],c7,c8,prod[8]);
    approx1_4x2com cm9(spp[0][9],spp[1][7],spp[2][5],spp[3][3],c8,c9,prod[9]);
    csa cs1(spp[0][15:10],spp[1][15:8],spp[2][15:6],spp[3][15:4],cout,s[5:0]);
    halfadder h1(s[0],c9,c10,prod[10]);
    halfadder h2(s[1],c10,c11,prod[11]);
    halfadder h3(s[2],c11,c12,prod[12]);
    halfadder h4(s[3],c12,c13,prod[13]);
    halfadder h5(s[4],c13,c14,prod[14]);
    halfadder h6(s[5],c14,c15,prod[15]);*/
endmodule


module inverter(
input [7:0] a,
output [8:0] b
);
    assign b = {~a[7],~a}+1;
endmodule
module partial_product(
input [7:0]m,
input [2:0]br,
output reg [9:0]pp
);

wire [8:0]inv_m;
inverter invm1(.a(m),.b(inv_m));

always@*
begin
case(br)
    3'b001,3'b010:pp={m[7],m[7],m};
    3'b011:pp={m[7],m,1'b0};
    3'b100:pp={inv_m,1'b0};
    3'b101,3'b110:pp={inv_m[8],inv_m};
    default:pp=0;

endcase
end

endmodule


module sign_extend(
input [9:0]in,
output reg [15:0]out

);
always@*
begin
out[15]=in[9];
out[14:0]=in[8:0];
if(in[9]==1'b1) begin
out[15:9]=7'b1111111;
end

end
endmodule


module approx1_4x2com(
input a,b,c,d,e,
output cout,
output sum
);
assign sum = (~(c&b))^a;
assign cout = e;


endmodule


// AC 8
/*module csa(
input [7:0]w,x,y,z,
output cout,
output [7:0]sum
);

//1st round
fulladder f0(x[0],y[0],z[0],c0,s0);
fulladder f1(x[1],y[1],z[1],c1,s1);
fulladder f2(x[2],y[2],z[2],c2,s2);
fulladder f3(x[3],y[3],z[3],c3,s3);
fulladder f4(x[4],y[4],z[4],c4,s4);
fulladder f5(x[5],y[5],z[5],c5,s5);
fulladder f6(x[6],y[6],z[6],c6,s6);
fulladder f7(x[7],y[7],z[7],c7,s7);
//2nd round
fulladder f8(w[0],s0,0,c8,s8);
fulladder f9(w[1],c0,s1,c9,s9);
fulladder f10(w[2],c1,s2,c10,s10);
fulladder f11(w[3],c2,s3,c11,s11);
fulladder f12(w[4],c3,s4,c12,s12);
fulladder f13(w[5],c4,s5,c13,s13);
fulladder f14(w[6],c5,s6,c14,s14);
fulladder f15(w[7],c6,s7,c15,s15);

//3rd round
fulladder fa16(c8,s9,0,c16,s16);
fulladder fa17(c9,s10,c16,c17,s17);
fulladder fa18(c10,s11,c17,c18,s18);
fulladder fa19(c11,s12,c18,c19,s19);
fulladder fa20(c12,s13,c19,c20,s20);
fulladder fa21(c13,s14,c20,c21,s21);
fulladder fa22(c14,s15,c21,c22,s22);
fulladder fa23(c15,c7,c22,c23,s23);

assign sum[0] = s8;
assign sum[1] = s16;
assign sum[2] = s17;
assign sum[3] = s18;
assign sum[4] = s19;
assign sum[5] = s20;
assign sum[6] = s21;
assign sum[7] = s22;
assign cout = s23;

endmodule*/


//AC 2
module csa(
input [13:0]w,x,y,z,
output cout,
output [13:0]sum
);

//1st round
fulladder f0(x[0],y[0],z[0],c0,s0);
fulladder f1(x[1],y[1],z[1],c1,s1);
fulladder f2(x[2],y[2],z[2],c2,s2);
fulladder f3(x[3],y[3],z[3],c3,s3);
fulladder f4(x[4],y[4],z[4],c4,s4);
fulladder f5(x[5],y[5],z[5],c5,s5);
fulladder f6(x[6],y[6],z[6],c6,s6);
fulladder f7(x[7],y[7],z[7],c7,s7);
fulladder f8(x[8],y[8],z[8],c8,s8);
fulladder f9(x[9],y[9],z[9],c9,s9);
fulladder f10(x[10],y[10],z[10],c10,s10);
fulladder f11(x[11],y[11],z[11],c11,s11);
fulladder f12(x[12],y[12],z[12],c12,s12);
fulladder f13(x[13],y[13],z[13],c13,s13);
//2nd round
fulladder f14(w[0],s0,0,c14,s14);
fulladder f15(w[1],c0,s1,c15,s15);
fulladder f16(w[2],c1,s2,c16,s16);
fulladder f17(w[3],c2,s3,c17,s17);
fulladder f18(w[4],c3,s4,c18,s18);
fulladder f19(w[5],c4,s5,c19,s19);
fulladder f20(w[6],c5,s6,c20,s20);
fulladder f21(w[7],c6,s7,c21,s21);
fulladder f22(w[8],c7,s8,c22,s22);
fulladder f23(w[9],c8,s9,c23,s23);
fulladder f24(w[10],c9,s10,c24,s24);
fulladder f25(w[11],c10,s11,c25,s25);
fulladder f26(w[12],c11,s12,c26,s26);
fulladder f27(w[13],c12,s13,c27,s27);
//3rd round
fulladder f28(c14,s15,0,c28,s28);
fulladder f29(c15,s16,c28,c29,s29);
fulladder f30(c16,s17,c29,c30,s30);
fulladder f31(c17,s18,c30,c31,s31);
fulladder f32(c18,s19,c31,c32,s32);
fulladder f33(c19,s20,c32,c33,s33);
fulladder f34(c20,s21,c33,c34,s34);
fulladder f35(c21,s22,c34,c35,s35);
fulladder f36(c22,s23,c35,c36,s36);
fulladder f37(c23,s24,c36,c37,s37);
fulladder f38(c24,s25,c37,c38,s38);
fulladder f39(c25,s26,c38,c39,s39);
fulladder f40(c26,s27,c39,c40,s40);
fulladder f41(c27,c13,c40,c41,s41);

assign sum[0] = s14;
assign sum[1] = s28;
assign sum[2] = s29;
assign sum[3] = s30;
assign sum[4] = s31;
assign sum[5] = s32;
assign sum[6] = s33;
assign sum[7] = s34;
assign sum[8] = s35;
assign sum[9] = s36;
assign sum[10] = s37;
assign sum[11] = s38;
assign sum[12] = s39;
assign sum[13] = s40;
assign cout = s41;

endmodule

//AC 4
/*module csa(
input [11:0]w,x,y,z,
output cout,
output [11:0]sum
);

//1st round
fulladder f0(x[0],y[0],z[0],c0,s0);
fulladder f1(x[1],y[1],z[1],c1,s1);
fulladder f2(x[2],y[2],z[2],c2,s2);
fulladder f3(x[3],y[3],z[3],c3,s3);
fulladder f4(x[4],y[4],z[4],c4,s4);
fulladder f5(x[5],y[5],z[5],c5,s5);
fulladder f6(x[6],y[6],z[6],c6,s6);
fulladder f7(x[7],y[7],z[7],c7,s7);
fulladder f8(x[8],y[8],z[8],c8,s8);
fulladder f9(x[9],y[9],z[9],c9,s9);
fulladder f10(x[10],y[10],z[10],c10,s10);
fulladder f11(x[11],y[11],z[11],c11,s11);
//2nd round
fulladder f12(w[0],s0,0,c12,s12);
fulladder f13(w[1],c0,s1,c13,s13);
fulladder f14(w[2],c1,s2,c14,s14);
fulladder f15(w[3],c2,s3,c15,s15);
fulladder f16(w[4],c3,s4,c16,s16);
fulladder f17(w[5],c4,s5,c17,s17);
fulladder f18(w[6],c5,s6,c18,s18);
fulladder f19(w[7],c6,s7,c19,s19);
fulladder f20(w[8],c7,s8,c20,s20);
fulladder f21(w[9],c8,s9,c21,s21);
fulladder f22(w[10],c9,s10,c22,s22);
fulladder f23(w[11],c10,s11,c23,s23);
//3rd round
fulladder f24(c12,s13,0,c24,s24);
fulladder f25(c13,s14,c24,c25,s25);
fulladder f26(c14,s15,c25,c26,s26);
fulladder f27(c15,s16,c26,c27,s27);
fulladder f28(c16,s17,c27,c28,s28);
fulladder f29(c17,s18,c28,c29,s29);
fulladder f30(c18,s19,c29,c30,s30);
fulladder f31(c19,s20,c30,c31,s31);
fulladder f32(c20,s21,c31,c32,s32);
fulladder f33(c21,s22,c32,c33,s33);
fulladder f34(c22,s23,c33,c34,s34);
fulladder f35(c23,c11,c34,c35,s35);



assign sum[0] = s12;
assign sum[1] = s24;
assign sum[2] = s25;
assign sum[3] = s26;
assign sum[4] = s27;
assign sum[5] = s28;
assign sum[6] = s29;
assign sum[7] = s30;
assign sum[8] = s31;
assign sum[9] = s32;
assign sum[10] = s33;
assign sum[11] = s34;

assign cout = s35;

endmodule*/

//AC 6
/*module csa(
input [9:0]w,x,y,z,
output cout,
output [9:0]sum
);

//1st round
fulladder f0(x[0],y[0],z[0],c0,s0);
fulladder f1(x[1],y[1],z[1],c1,s1);
fulladder f2(x[2],y[2],z[2],c2,s2);
fulladder f3(x[3],y[3],z[3],c3,s3);
fulladder f4(x[4],y[4],z[4],c4,s4);
fulladder f5(x[5],y[5],z[5],c5,s5);
fulladder f6(x[6],y[6],z[6],c6,s6);
fulladder f7(x[7],y[7],z[7],c7,s7);
fulladder f8(x[8],y[8],z[8],c8,s8);
fulladder f9(x[9],y[9],z[9],c9,s9);

//2nd round
fulladder f10(w[0],s0,0,c10,s10);
fulladder f11(w[1],c0,s1,c11,s11);
fulladder f12(w[2],c1,s2,c12,s12);
fulladder f13(w[3],c2,s3,c13,s13);
fulladder f14(w[4],c3,s4,c14,s14);
fulladder f15(w[5],c4,s5,c15,s15);
fulladder f16(w[6],c5,s6,c16,s16);
fulladder f17(w[7],c6,s7,c17,s17);
fulladder f18(w[8],c7,s8,c18,s18);
fulladder f19(w[9],c8,s9,c19,s19);

//3rd round
fulladder f20(c10,s11,0,c20,s20);
fulladder f21(c11,s12,c20,c21,s21);
fulladder f22(c12,s13,c21,c22,s22);
fulladder f23(c13,s14,c22,c23,s23);
fulladder f24(c14,s15,c23,c24,s24);
fulladder f25(c15,s16,c24,c25,s25);
fulladder f26(c16,s17,c25,c26,s26);
fulladder f27(c17,s18,c26,c27,s27);
fulladder f28(c18,s19,c27,c28,s28);
fulladder f29(c19,c9,c28,c29,s29);

assign sum[0] = s10;
assign sum[1] = s20;
assign sum[2] = s21;
assign sum[3] = s22;
assign sum[4] = s23;
assign sum[5] = s24;
assign sum[6] = s25;
assign sum[7] = s26;
assign sum[8] = s27;
assign sum[9] = s28;


assign cout = s29;

endmodule*/

//AC 10
/*module csa(
input [5:0]w,x,y,z,
output cout,
output [5:0]sum
);

//1st round
fulladder f0(x[0],y[0],z[0],c0,s0);
fulladder f1(x[1],y[1],z[1],c1,s1);
fulladder f2(x[2],y[2],z[2],c2,s2);
fulladder f3(x[3],y[3],z[3],c3,s3);
fulladder f4(x[4],y[4],z[4],c4,s4);
fulladder f5(x[5],y[5],z[5],c5,s5);

//2nd round
fulladder f6(w[0],s0,0,c6,s6);
fulladder f7(w[1],c0,s1,c7,s7);
fulladder f8(w[2],c1,s2,c8,s8);
fulladder f9(w[3],c2,s3,c9,s9);
fulladder f10(w[4],c3,s4,c10,s10);
fulladder f11(w[5],c4,s5,c11,s11);


//3rd round
fulladder f12(c6,s7,0,c12,s12);
fulladder f13(c7,s8,c12,c13,s13);
fulladder f14(c8,s9,c13,c14,s14);
fulladder f15(c9,s10,c14,c15,s15);
fulladder f16(c10,s11,c15,c16,s16);
fulladder f17(c11,c5,c16,c17,s17);


assign sum[0] = s6;
assign sum[1] = s12;
assign sum[2] = s13;
assign sum[3] = s14;
assign sum[4] = s15;
assign sum[5] = s16;

assign cout = s17;

endmodule*/


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