`timescale 1ns / 1ps
//approximation done in lsb using 4:2 compressor and
// in mSB used exact carry save adder
module radix4_8bit_approx5(
input [7:0]m,q,
output [15:0]prod
    );
    wire [15:0]s;
    wire [2:0]br[3:0];
    wire [9:0]pp[3:0];
    wire [15:0]spp[3:0];
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
    
    // AC 2
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,sa0);
    approx1_4x2com cm1(spp[0][1],0,0,0,co0,co1,cr1,sa1);
    csa cs1(.w(spp[0][15:2]),.x(spp[1][15:0]),.y(spp[2][15:0]<<2),.z(spp[3][15:0]<<4),.cout(cout),.sum(s[13:0]));
    
    halfadder ha0(sa1,cr0,c1,s1);
    fulladder fa0(s[0],co1,cr1,c2,s2);
    halfadder ha1(s[1],c2,c3,s3);
    halfadder ha2(s[2],c3,c4,s4);
    halfadder ha3(s[3],c4,c5,s5);
    halfadder ha4(s[4],c5,c6,s6);
    halfadder ha5(s[5],c6,c7,s7);
    halfadder ha6(s[6],c7,c8,s8);
    halfadder ha7(s[7],c8,c9,s9);
    halfadder ha8(s[8],c9,c10,s10);
    halfadder ha9(s[9],c10,c11,s11);
    halfadder ha10(s[10],c11,c12,s12);
    halfadder ha11(s[11],c12,c13,s13);
    halfadder ha12(s[12],c13,c14,s14);
    halfadder ha13(s[13],c14,c15,s15);
    
    halfadder ha14(s2,c1,c16,s16);
    halfadder ha15(s3,c16,c17,s17);
    halfadder ha16(s4,c17,c18,s18);
    halfadder ha17(s5,c18,c19,s19);
    halfadder ha18(s6,c19,c20,s20);
    halfadder ha19(s7,c20,c21,s21);
    halfadder ha20(s8,c21,c22,s22);
    halfadder ha21(s9,c22,c23,s23);
    halfadder ha22(s10,c23,c24,s24);
    halfadder ha23(s11,c24,c25,s25);
    halfadder ha24(s12,c25,c26,s26);
    halfadder ha25(s13,c26,c27,s27);
    halfadder ha26(s14,c27,c28,s28);
    halfadder ha27(s15,c28,c29,s29);
    
    assign prod[0] = sa0;
    assign prod[1] = s1;
    assign prod[2] = s16;
    assign prod[3] = s17;
    assign prod[4] = s18;
    assign prod[5] = s19;
    assign prod[6] = s20;
    assign prod[7] = s21;
    assign prod[8] = s22;
    assign prod[9] = s23;
    assign prod[10] = s24;
    assign prod[11] = s25;
    assign prod[12] = s26;
    assign prod[13] = s27;
    assign prod[14] = s28;
    assign prod[15] = s29;*/
    
    //AC 4
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,sa0);
    approx1_4x2com cm1(spp[0][1],0,0,0,co0,co1,cr1,sa1);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,co1,co2,cr2,sa2);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,co2,co3,cr3,sa3);
    csa cs1(.w(spp[0][15:4]),.x(spp[1][15:2]),.y(spp[2][15:0]),.z(spp[3][15:0]<<2),.cout(cout),.sum(s[11:0]));
    
    halfadder ha0(sa1,cr0,c1,s1);
    fulladder fa0(sa2,cr1,c1,c2,s2);
    fulladder fa1(sa3,cr2,c2,c3,s3);
    fulladder fa2(s[0],co3,cr3,c4,s4);
    halfadder ha1(s[1],c4,c5,s5);
    halfadder ha2(s[2],c5,c6,s6);
    halfadder ha3(s[3],c6,c7,s7);
    halfadder ha4(s[4],c7,c8,s8);
    halfadder ha5(s[5],c8,c9,s9);
    halfadder ha6(s[6],c9,c10,s10);
    halfadder ha7(s[7],c10,c11,s11);
    halfadder ha8(s[8],c11,c12,s12);
    halfadder ha9(s[9],c12,c13,s13);
    halfadder ha10(s[10],c13,c14,s14);
    halfadder ha11(s[11],c14,c15,s15);
    
    halfadder ha12(s4,c3,c16,s16);
    halfadder ha13(s5,c16,c17,s17);
    halfadder ha14(s6,c17,c18,s18);
    halfadder ha15(s7,c18,c19,s19);
    halfadder ha16(s8,c19,c20,s20);
    halfadder ha17(s9,c20,c21,s21);
    halfadder ha18(s10,c21,c22,s22);
    halfadder ha19(s11,c22,c23,s23);
    halfadder ha20(s12,c23,c24,s24);
    halfadder ha21(s13,c24,c25,s25);
    halfadder ha22(s14,c25,c26,s26);
    halfadder ha23(s15,c26,c27,s27);
    
    assign prod[0] = sa0;
    assign prod[1] = s1;
    assign prod[2] = s2;
    assign prod[3] = s3;
    assign prod[4] = s16;
    assign prod[5] = s17;
    assign prod[6] = s18;
    assign prod[7] = s19;
    assign prod[8] = s20;
    assign prod[9] = s21;
    assign prod[10] = s22;
    assign prod[11] = s23;
    assign prod[12] = s24;
    assign prod[13] = s25;
    assign prod[14] = s26;
    assign prod[15] = s27;*/
    
    //AC 6
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,sa0);
    approx1_4x2com cm1(spp[0][1],0,0,0,co0,co1,cr1,sa1);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,co1,co2,cr2,sa2);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,co2,co3,cr3,sa3);
    approx1_4x2com cm4(spp[0][4],spp[1][2],spp[2][0],0,co3,co4,cr4,sa4);
    approx1_4x2com cm5(spp[0][5],spp[1][3],spp[2][1],0,co4,co5,cr5,sa5);
    csa cs1(.w(spp[0][15:6]),.x(spp[1][15:4]),.y(spp[2][15:2]),.z(spp[3][15:0]),.cout(cout),.sum(s[9:0]));
    
    halfadder ha0(sa1,cr0,c1,s1);
    fulladder fa0(sa2,cr1,c1,c2,s2);
    fulladder fa1(sa3,cr2,c2,c3,s3);
    fulladder fa2(sa4,cr3,c3,c4,s4);
    fulladder fa3(sa5,cr4,c4,c5,s5);
    fulladder fa4(s[0],co5,cr5,c6,s6);
    halfadder ha1(s[1],c6,c7,s7);
    halfadder ha2(s[2],c7,c8,s8);
    halfadder ha3(s[3],c8,c9,s9);
    halfadder ha4(s[4],c9,c10,s10);
    halfadder ha5(s[5],c10,c11,s11);
    halfadder ha6(s[6],c11,c12,s12);
    halfadder ha7(s[7],c12,c13,s13);
    halfadder ha8(s[8],c13,c14,s14);
    halfadder ha9(s[9],c14,c15,s15);
    
    halfadder ha10(s6,c5,c16,s16);
    halfadder ha11(s7,c16,c17,s17);
    halfadder ha12(s8,c17,c18,s18);
    halfadder ha13(s9,c18,c19,s19);
    halfadder ha14(s10,c19,c20,s20);
    halfadder ha15(s11,c20,c21,s21);
    halfadder ha16(s12,c21,c22,s22);
    halfadder ha17(s13,c22,c23,s23);
    halfadder ha18(s14,c23,c24,s24);
    halfadder ha19(s15,c24,c25,s25);
    
    assign prod[0] = sa0;
    assign prod[1] = s1;
    assign prod[2] = s2;
    assign prod[3] = s3;
    assign prod[4] = s4;
    assign prod[5] = s5;
    assign prod[6] = s16;
    assign prod[7] = s17;
    assign prod[8] = s18;
    assign prod[9] = s19;
    assign prod[10] = s20;
    assign prod[11] = s21;
    assign prod[12] = s22;
    assign prod[13] = s23;
    assign prod[14] = s24;
    assign prod[15] = s25;*/
    
    //AC 8
    approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,sa0);
    approx1_4x2com cm1(spp[0][1],0,0,0,co0,co1,cr1,sa1);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,co1,co2,cr2,sa2);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,co2,co3,cr3,sa3);
    approx1_4x2com cm4(spp[0][4],spp[1][2],spp[2][0],0,co3,co4,cr4,sa4);
    approx1_4x2com cm5(spp[0][5],spp[1][3],spp[2][1],0,co4,co5,cr5,sa5);
    approx1_4x2com cm6(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co5,co6,cr6,sa6);
    approx1_4x2com cm7(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co6,co7,cr7,sa7);
    csa cs1(.w(spp[0][15:8]),.x(spp[1][15:6]),.y(spp[2][15:4]),.z(spp[3][15:2]),.cout(cout),.sum(s[7:0]));
    
    halfadder ha0(sa1,cr0,c1,s1);
    fulladder fa0(sa2,cr1,c1,c2,s2);
    fulladder fa1(sa3,cr2,c2,c3,s3);
    fulladder fa2(sa4,cr3,c3,c4,s4);
    fulladder fa3(sa5,cr4,c4,c5,s5);
    fulladder fa4(sa6,cr5,c5,c6,s6);
    fulladder fa5(sa7,cr6,c6,c7,s7);
    fulladder fa6(s[0],co7,cr7,c8,s8);
    halfadder ha1(s[1],c8,c9,s9);
    halfadder ha2(s[2],c9,c10,s10);
    halfadder ha3(s[3],c10,c11,s11);
    halfadder ha4(s[4],c11,c12,s12);
    halfadder ha5(s[5],c12,c13,s13);
    halfadder ha6(s[6],c13,c14,s14);
    halfadder ha7(s[7],c14,c15,s15);
    
    halfadder ha8(s8,c7,c16,s16);
    halfadder ha9(s9,c16,c17,s17);
    halfadder ha10(s10,c17,c18,s18);
    halfadder ha11(s11,c18,c19,s19);
    halfadder ha12(s12,c19,c20,s20);
    halfadder ha13(s13,c20,c21,s21);
    halfadder ha14(s14,c21,c22,s22);
    halfadder ha15(s15,c22,c23,s23);
    
    assign prod[0] = sa0;
    assign prod[1] = s1;
    assign prod[2] = s2;
    assign prod[3] = s3;
    assign prod[4] = s4;
    assign prod[5] = s5;
    assign prod[6] = s6;
    assign prod[7] = s7;
    assign prod[8] = s16;
    assign prod[9] = s17;
    assign prod[10] = s18;
    assign prod[11] = s19;
    assign prod[12] = s20;
    assign prod[13] = s21;
    assign prod[14] = s22;
    assign prod[15] = s23;
    
    //AC 10
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,sa0);
    approx1_4x2com cm1(spp[0][1],0,0,0,co0,co1,cr1,sa1);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,co1,co2,cr2,sa2);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,co2,co3,cr3,sa3);
    approx1_4x2com cm4(spp[0][4],spp[1][2],spp[2][0],0,co3,co4,cr4,sa4);
    approx1_4x2com cm5(spp[0][5],spp[1][3],spp[2][1],0,co4,co5,cr5,sa5);
    approx1_4x2com cm6(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co5,co6,cr6,sa6);
    approx1_4x2com cm7(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co6,co7,cr7,sa7);
    approx1_4x2com cm8(spp[0][8],spp[1][6],spp[2][4],spp[3][2],co7,co8,cr8,sa8);
    approx1_4x2com cm9(spp[0][9],spp[1][7],spp[2][5],spp[3][3],co8,co9,cr9,sa9);
    csa cs1(.w(spp[0][15:10]),.x(spp[1][15:8]),.y(spp[2][15:6]),.z(spp[3][15:4]),.cout(cout),.sum(s[5:0]));
    
    halfadder ha0(sa1,cr0,c1,s1);
    fulladder fa0(sa2,cr1,c1,c2,s2);
    fulladder fa1(sa3,cr2,c2,c3,s3);
    fulladder fa2(sa4,cr3,c3,c4,s4);
    fulladder fa3(sa5,cr4,c4,c5,s5);
    fulladder fa4(sa6,cr5,c5,c6,s6);
    fulladder fa5(sa7,cr6,c6,c7,s7);
    fulladder fa6(sa8,cr7,c7,c8,s8);
    fulladder fa7(sa9,cr8,c8,c9,s9);
    fulladder fa8(s[0],co9,cr9,c10,s10);
    halfadder ha1(s[1],c10,c11,s11);
    halfadder ha2(s[2],c11,c12,s12);
    halfadder ha3(s[3],c12,c13,s13);
    halfadder ha4(s[4],c13,c14,s14);
    halfadder ha5(s[5],c14,c15,s15);
    
    halfadder ha6(s10,c9,c16,s16);
    halfadder ha7(s11,c16,c17,s17);
    halfadder ha8(s12,c17,c18,s18);
    halfadder ha9(s13,c18,c19,s19);
    halfadder ha10(s14,c19,c20,s20);
    halfadder ha11(s15,c20,c21,s21);
    
    assign prod[0] = sa0;
    assign prod[1] = s1;
    assign prod[2] = s2;
    assign prod[3] = s3;
    assign prod[4] = s4;
    assign prod[5] = s5;
    assign prod[6] = s6;
    assign prod[7] = s7;
    assign prod[8] = s8;
    assign prod[9] = s9;
    assign prod[10] = s16;
    assign prod[11] = s17;
    assign prod[12] = s18;
    assign prod[13] = s19;
    assign prod[14] = s20;
    assign prod[15] = s21;*/
    
    
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
output cout,carry,
output sum
);
assign sum = ((~(a&b))|(~(c&d)))^e;

assign cout = d;

assign carry=a;

endmodule


module csa(
input [15:0]w,x,y,z,
output cout,
output [15:0]sum
);

    //wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c23;
    //wire s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s23;
//1st round
fulladder f1(x[0],y[0],z[0],c0,s0);
fulladder f2(x[1],y[1],z[1],c1,s1);
fulladder f3(x[2],y[2],z[2],c2,s2);
fulladder f4(x[3],y[3],z[3],c3,s3);
fulladder f5(x[4],y[4],z[4],c4,s4);
fulladder f6(x[5],y[5],z[5],c5,s5);
fulladder f7(x[6],y[6],z[6],c6,s6);
fulladder f8(x[7],y[7],z[7],c7,s7);
fulladder f9(x[8],y[8],z[8],c8,s8);
fulladder f10(x[9],y[9],z[9],c9,s9);
fulladder f11(x[10],y[10],z[10],c10,s10);
fulladder f12(x[11],y[11],z[11],c11,s11);
fulladder f13(x[12],y[12],z[12],c12,s12);
fulladder f14(x[13],y[13],z[13],c13,s13);
fulladder f15(x[14],y[14],z[14],c14,s14);
fulladder f16(x[15],y[15],z[15],c15,s15);

//2ns stage

fulladder f17(w[0],s0,0,c16,s16);
fulladder f18(w[1],c0,s1,c17,s17);
fulladder f19(w[2],c1,s2,c18,s18);
fulladder f20(w[3],c2,s3,c19,s19);
fulladder f21(w[4],c3,s4,c20,s20);
fulladder f22(w[5],c4,s5,c21,s21);
fulladder f23(w[6],c5,s6,c22,s22);
fulladder f24(w[7],c6,s7,c23,s23);
fulladder f25(w[8],c7,s8,c24,s24);
fulladder f26(w[9],c8,s9,c25,s25);
fulladder f27(w[10],c9,s10,c26,s26);
fulladder f28(w[11],c10,s11,c27,s27);
fulladder f29(w[12],c11,s12,c28,s28);
fulladder f30(w[13],c12,s13,c29,s29);
fulladder f31(w[14],c13,s14,c30,s30);
fulladder f32(w[15],c14,s15,c31,s31);

//3rd stage

fulladder fa33(c16,s17,0,c32,s32);
fulladder fa34(c17,s18,c32,c33,s33);
fulladder fa35(c18,s19,c33,c34,s34);
fulladder fa36(c19,s20,c34,c35,s35);
fulladder fa37(c20,s21,c35,c36,s36);
fulladder fa38(c21,s22,c36,c37,s37);
fulladder fa39(c22,s23,c37,c38,s38);
fulladder fa40(c23,s24,c38,c39,s39);
fulladder fa41(c24,s25,c39,c40,s40);
fulladder fa42(c25,s26,c40,c41,s41);
fulladder fa43(c26,s27,c41,c42,s42);
fulladder fa44(c27,s28,c42,c43,s43);
fulladder fa45(c28,s29,c43,c44,s44);
fulladder fa46(c29,s30,c44,c45,s45);
fulladder fa47(c30,s31,c45,c46,s46);
fulladder fa48(c31,c15,c46,c47,s47);

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
//assign sum[16] = s47;
assign cout = s47;


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