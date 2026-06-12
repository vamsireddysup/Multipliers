module dadda_multiplier_8bit(
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
    assign p[i][j]= a[j] & b[i];
    end
    end
    endgenerate
    
    halfadder ha1(p[6][0],p[5][1],c0,s0);
    fulladder fa1(p[7][0],p[6][1],p[5][2],c1,s1);
    halfadder ha2(p[4][3],p[3][4],c2,s2);
    fulladder fa2(p[7][1],p[6][2],p[5][3],c3,s3);
    halfadder ha3(p[4][4],p[3][5],c4,s4);
    fulladder fa3(p[7][2],p[6][3],p[5][4],c5,s5);
    halfadder ha4(p[4][0],p[3][1],c6,s6);
    fulladder fa4(p[5][0],p[4][1],p[3][2],c7,s7);
    halfadder ha5(p[2][3],p[1][4],c8,s8);
    fulladder fa5(s0,p[4][2],p[3][3],c9,s9);
    fulladder fa6(p[2][4],p[1][5],p[0][6],c10,s10);
    fulladder fa7(s1,c0,s2,c11,s11);
    fulladder fa8(p[2][5],p[1][6],p[0][7],c12,s12);
    fulladder fa9(c1,c2,s3,c13,s13);
    fulladder fa10(s4,p[2][6],p[1][7],c14,s14);
    fulladder fa11(c3,c4,s5,c15,s15);
    fulladder fa12(p[4][5],p[3][6],p[2][7],c16,s16);
    fulladder fa13(c5,p[7][3],p[6][4],c17,s17);
    fulladder fa14(p[5][5],p[4][6],p[3][7],c18,s18);
    fulladder fa15(p[7][4],p[6][5],p[5][6],c19,s19);
    halfadder ha6(p[3][0],p[2][1],c20,s20);
    fulladder fa16(s6,p[2][2],p[1][3],c21,s21);
    fulladder fa17(c6,s7,s8,c22,s22);
    fulladder fa18(c7,c8,s9,c23,s23);
    fulladder fa19(c9,c10,s11,c24,s24);
    fulladder fa20(c11,c12,s13,c25,s25);
    fulladder fa21(c13,c14,s15,c26,s26);
    fulladder fa22(c15,c16,s17,c27,s27);
    fulladder fa23(c17,c18,s19,c28,s28);
    fulladder fa24(c19,p[7][5],p[6][6],c29,s29);
    halfadder ha7(p[2][0],p[1][1],c30,s30);
    fulladder fa25(s20,p[1][2],p[0][3],c31,s31);
    fulladder fa26(c20,s21,p[0][4],c32,s32);
    fulladder fa27(c21,s22,p[0][5],c33,s33);
    fulladder fa28(c22,s23,s10,c34,s34);
    fulladder fa29(c23,s24,s12,c35,s35);
    fulladder fa30(c24,s25,s14,c36,s36);
    fulladder fa31(c25,s26,s16,c37,s37);
    fulladder fa32(c26,s27,s18,c38,s38);
    fulladder fa33(c27,s28,p[4][7],c39,s39);
    fulladder fa34(c28,s29,p[5][7],c40,s40);
    fulladder fa35(c29,p[7][6],p[6][7],c41,s41);
    halfadder ha8(p[1][0],p[0][1],c42,s42);
    fulladder fa36(s30,p[0][2],c42,c43,s43);
    fulladder fa37(c30,s31,c43,c44,s44);
    fulladder fa38(c31,s32,c44,c45,s45);
    fulladder fa39(c32,s33,c45,c46,s46);
    fulladder fa40(c33,s34,c46,c47,s47);
    fulladder fa41(c34,s35,c47,c48,s48);
    fulladder fa42(c35,s36,c48,c49,s49);
    fulladder fa43(c36,s37,c49,c50,s50);
    fulladder fa44(c37,s38,c50,c51,s51);
    fulladder fa45(c38,s39,c51,c52,s52);
    fulladder fa46(c39,s40,c52,c53,s53);
    fulladder fa47(c40,s41,c53,c54,s54);
    fulladder fa48(c41,p[7][7],c54,c55,s55);
    
    assign prod[0] = p[0][0];
    assign prod[1] = s42;
    assign prod[2] = s43;
    assign prod[3] = s44;
    assign prod[4] = s45;
    assign prod[5] = s46;
    assign prod[6] = s47;
    assign prod[7] = s48;
    assign prod[8] = s49;
    assign prod[9] = s50;
    assign prod[10] = s51;
    assign prod[11] = s52;
    assign prod[12] = s53;
    assign prod[13] = s54;
    assign prod[14] = s55;
    assign prod[15] = c55;
    //assign prod[1] = 
    
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