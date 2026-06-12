module array_multiplier_8bit(
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
    
    //halfadder ha1(p[1][0],p[0][1],c0,s0);
    fulladder fa0(p[1][0],p[0][1],0,c0,s0);
    fulladder fa1(p[2][0],p[1][1],c0,c1,s1);
    fulladder fa2(p[3][0],p[2][1],c1,c2,s2);
    fulladder fa3(p[4][0],p[3][1],c2,c3,s3);
    fulladder fa4(p[5][0],p[4][1],c3,c4,s4);
    fulladder fa5(p[6][0],p[5][1],c4,c5,s5);
    fulladder fa6(p[7][0],p[6][1],c5,c6,s6);
    fulladder fa7(c6,p[7][1],0,c7,s7);
    fulladder fa8(s1,p[0][2],0,c8,s8);
    fulladder fa9(s2,p[1][2],c8,c9,s9);
    fulladder fa10(s3,p[2][2],c9,c10,s10);
    fulladder fa11(s4,p[3][2],c10,c11,s11);
    fulladder fa12(s5,p[4][2],c11,c12,s12);
    fulladder fa13(s6,p[5][2],c12,c13,s13);
    fulladder fa14(s7,p[6][2],c13,c14,s14);
    fulladder fa15(c7,p[7][2],c14,c15,s15);
    fulladder fa16(s9,p[0][3],0,c16,s16);
    fulladder fa17(s10,p[1][3],c16,c17,s17);
    fulladder fa18(s11,p[2][3],c17,c18,s18);
    fulladder fa19(s12,p[3][3],c18,c19,s19);
    fulladder fa20(s13,p[4][3],c19,c20,s20);
    fulladder fa21(s14,p[5][3],c20,c21,s21);
    fulladder fa22(s15,p[6][3],c21,c22,s22);
    fulladder fa23(c15,p[7][3],c22,c23,s23);
    fulladder fa24(s17,p[0][4],0,c24,s24);
    fulladder fa25(s18,p[1][4],c24,c25,s25);
    fulladder fa26(s19,p[2][4],c25,c26,s26);
    fulladder fa27(s20,p[3][4],c26,c27,s27);
    fulladder fa28(s21,p[4][4],c27,c28,s28);
    fulladder fa29(s22,p[5][4],c28,c29,s29);
    fulladder fa30(s23,p[6][4],c29,c30,s30);
    fulladder fa31(c23,p[7][4],c30,c31,s31);
    fulladder fa32(s25,p[0][5],0,c32,s32);
    fulladder fa33(s26,p[1][5],c32,c33,s33);
    fulladder fa34(s27,p[2][5],c33,c34,s34);
    fulladder fa35(s28,p[3][5],c34,c35,s35);
    fulladder fa36(s29,p[4][5],c35,c36,s36);
    fulladder fa37(s30,p[5][5],c36,c37,s37);
    fulladder fa38(s31,p[6][5],c37,c38,s38);
    fulladder fa39(c31,p[7][5],c38,c39,s39);
    fulladder fa40(s33,p[0][6],0,c40,s40);
    fulladder fa41(s34,p[1][6],c40,c41,s41);
    fulladder fa42(s35,p[2][6],c41,c42,s42);
    fulladder fa43(s36,p[3][6],c42,c43,s43);
    fulladder fa44(s37,p[4][6],c43,c44,s44);
    fulladder fa45(s38,p[5][6],c44,c45,s45);
    fulladder fa46(s39,p[6][6],c45,c46,s46);
    fulladder fa47(c39,p[7][6],c46,c47,s47);
    fulladder fa48(s41,p[0][7],0,c48,s48);
    fulladder fa49(s42,p[1][7],c48,c49,s49);
    fulladder fa50(s43,p[2][7],c49,c50,s50);
    fulladder fa51(s44,p[3][7],c50,c51,s51);
    fulladder fa52(s45,p[4][7],c51,c52,s52);
    fulladder fa53(s46,p[5][7],c52,c53,s53);
    fulladder fa54(s47,p[6][7],c53,c54,s54);
    fulladder fa55(c47,p[7][7],c54,c55,s55);
    
    assign prod[0] = p[0][0];
    assign prod[1] = s0;
    assign prod[2] = s8;
    assign prod[3] = s16;
    assign prod[4] = s24;
    assign prod[5] = s32;
    assign prod[6] = s40;
    assign prod[7] = s48;
    assign prod[8] = s49;
    assign prod[9] = s50;
    assign prod[10] = s51;
    assign prod[11] = s52;
    assign prod[12] = s53;
    assign prod[13] = s54;
    assign prod[14] = s55;
    assign prod[15] = c55;
    
    
    
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

/*
module halfadder(
input a,b,
output cout,sum
);

assign sum=a^b;
assign cout=a&b;
endmodule
*/