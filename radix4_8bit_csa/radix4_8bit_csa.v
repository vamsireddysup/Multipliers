`timescale 1ns / 1ps




module radix4_8bit_csa(
input [7:0]m,q,
output [15:0]prod
);
    reg [2:0]br[3:0];//Booth recoding
    reg [9:0]pp[3:0];//partial products
    reg [15:0]spp[3:0];//sign extended partial products
    wire [15:0]prod1;//temp product
    integer i,j;
    wire [8:0]inv_m;//inverter of multiplicand with one bit extended
    assign inv_m={~m[7],~m}+1;
    
    always@(m or q or inv_m)
    begin
    br[0]={q[1],q[0],1'b0};
    for(i=1;i<4;i=i+1)
    br[i] ={q[2*i+1],q[2*i],q[2*i-1]};
    for(i=0;i<4;i=i+1)
    begin
    case(br[i])
    3'b001,3'b010:pp[i]={m[7],m[7],m};
    3'b011:pp[i]={m[7],m,1'b0};
    3'b100:pp[i]={inv_m,1'b0};
    3'b101,3'b110:pp[i]={inv_m[8],inv_m};
    default:pp[i]=0;
    endcase
    spp[i]=$signed(pp[i]);
    for(j=0;j<i;j=j+1)
    spp[i]={spp[i],2'b00};
    end
    end
    csa csa_0(spp[0],spp[1],spp[2],spp[3],cout,prod1);
    assign prod=prod1[15:0];
endmodule



module csa(
input [15:0]w,x,y,z,
output cout,
output [16:0]sum
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
assign sum[16] = s47;
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
