module wallace_tree_multiplier(
input [7:0]a,b,
output [15:0]prod
    );

wire p[7:0][7:0];
genvar i,j;
generate 
for(i=0;i<8;i=i+1)
begin
for(j=0;j<8;j=j+1)
begin
assign p[i][j] = a[j]&b[i];
end
end
endgenerate

halfadder ha1(p[1][0],p[0][1],c0,s0);
fulladder fa1(p[2][0],p[1][1],p[0][2],c1,s1);
fulladder fa2(p[3][0],p[2][1],p[1][2],c2,s2);
fulladder fa3(p[4][0],p[3][1],p[2][2],c3,s3);
fulladder fa4(p[5][0],p[4][1],p[3][2],c4,s4);
fulladder fa5(p[6][0],p[5][1],p[4][2],c5,s5);
fulladder fa6(p[7][0],p[6][1],p[5][2],c6,s6);
halfadder ha2(p[7][1],p[6][2],c7,s7);
halfadder ha3(p[1][3],p[0][4],c8,s8);
fulladder fa7(p[2][3],p[1][4],p[0][5],c9,s9);
fulladder fa8(p[3][3],p[2][4],p[1][5],c10,s10);
fulladder fa9(p[4][3],p[3][4],p[2][5],c11,s11);
fulladder fa10(p[5][3],p[4][4],p[3][5],c12,s12);
fulladder fa11(p[6][3],p[5][4],p[4][5],c13,s13);
fulladder fa12(p[7][3],p[6][4],p[5][5],c14,s14);
halfadder ha4(p[7][4],p[6][5],c15,s15);
halfadder ha5(s1,c0,c16,s16);
fulladder fa13(s2,c1,p[0][3],c17,s17);
fulladder fa14(s3,c2,s8,c18,s18);
fulladder fa15(s4,c3,s9,c19,s19);
fulladder fa16(s5,c4,s10,c20,s20);
fulladder fa17(s6,c5,s11,c21,s21);
fulladder fa18(s7,c6,s12,c22,s22);
fulladder fa19(c7,p[7][2],s13,c23,s23);
halfadder ha6(c9,p[0][6],c24,s24);
fulladder fa20(c10,p[1][6],p[0][7],c25,s25);
fulladder fa21(c11,p[2][6],p[1][7],c26,s26);
fulladder fa22(c12,p[3][6],p[2][7],c27,s27);
fulladder fa23(c13,p[4][6],p[3][7],c28,s28);
fulladder fa24(c14,p[5][6],p[4][7],c29,s29);
fulladder fa25(p[7][5],p[6][6],p[5][7],c30,s30);
halfadder ha7(p[7][6],p[6][7],c31,s31);
halfadder ha8(s17,c16,c32,s32);
halfadder ha9(s18,c17,c33,s33);
fulladder fa26(s19,c18,c8,c34,s34);
fulladder fa27(s20,c19,s24,c35,s35);
fulladder fa28(s21,c20,s25,c36,s36);
fulladder fa29(s22,c21,s26,c37,s37);
fulladder fa30(s23,c22,s27,c38,s38);
fulladder fa31(c23,s14,s28,c39,s39);
halfadder ha10(s15,s29,c40,s40);
halfadder ha11(c15,s30,c41,s41);
halfadder ha12(s33,c32,c42,s42);
halfadder ha13(s34,c33,c43,s43);
halfadder ha14(s35,c34,c44,s44);
fulladder fa32(s36,c35,c24,c45,s45);
fulladder fa33(s37,c36,c25,c46,s46);
fulladder fa34(s38,c37,c26,c47,s47);
fulladder fa35(s39,c38,c27,c48,s48);
fulladder fa36(s40,c39,c28,c49,s49);
fulladder fa37(s41,c40,c29,c50,s50);
fulladder fa38(c41,s31,c30,c51,s51);
halfadder ha15(c31,p[7][7],c52,s52);
halfadder ha16(s43,c42,c53,s53);
fulladder fa39(s44,c43,c53,c54,s54);
fulladder fa40(s45,c44,c54,c55,s55);
fulladder fa41(s46,c45,c55,c56,s56);
fulladder fa42(s47,c46,c56,c57,s57);
fulladder fa43(s48,c47,c57,c58,s58);
fulladder fa44(s49,c48,c58,c59,s59);
fulladder fa45(s50,c49,c59,c60,s60);
fulladder fa46(s51,c50,c60,c61,s61);
fulladder fa47(s52,c51,c61,c62,s62);
halfadder ha17(c52,c62,c63,s63);

assign prod[0]=p[0][0];
assign prod[1]=s0;
assign prod[2]=s16;
assign prod[3]=s32;
assign prod[4]=s42;
assign prod[5]=s53;
assign prod[6]=s54;
assign prod[7]=s55;
assign prod[8]=s56;
assign prod[9]=s57;
assign prod[10]=s58;
assign prod[11]=s59;
assign prod[12]=s60;
assign prod[13]=s61;
assign prod[14]=s62;
assign prod[15]=s63;
//assign prod[16]=c63;


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
assign cout = a&b;
assign sum = a^b;
endmodule