`timescale 1ns / 1ps

module carry_save_adder_8op_32bit(
input [31:0]a,b,c,d,e,f,g,h,
output cout,
output [31:0]sum
    );
    //Stage 1
    fulladder f0(a[0],b[0],c[0],c0,s0);
    fulladder f1(a[1],b[1],c[1],c1,s1);
    fulladder f2(a[2],b[2],c[2],c2,s2);
    fulladder f3(a[3],b[3],c[3],c3,s3);
    fulladder f4(a[4],b[4],c[4],c4,s4);
    fulladder f5(a[5],b[5],c[5],c5,s5);
    fulladder f6(a[6],b[6],c[6],c6,s6);
    fulladder f7(a[7],b[7],c[7],c7,s7);
    fulladder f8(a[8],b[8],c[8],c8,s8);
    fulladder f9(a[9],b[9],c[9],c9,s9);
    fulladder f10(a[10],b[10],c[10],c10,s10);
    fulladder f11(a[11],b[11],c[11],c11,s11);
    fulladder f12(a[12],b[12],c[12],c12,s12);
    fulladder f13(a[13],b[13],c[13],c13,s13);
    fulladder f14(a[14],b[14],c[14],c14,s14);
    fulladder f15(a[15],b[15],c[15],c15,s15);
    fulladder f16(a[16],b[16],c[16],c16,s16);
    fulladder f17(a[17],b[17],c[17],c17,s17);
    fulladder f18(a[18],b[18],c[18],c18,s18);
    fulladder f19(a[19],b[19],c[19],c19,s19);
    fulladder f20(a[20],b[20],c[20],c20,s20);
    fulladder f21(a[21],b[21],c[21],c21,s21);
    fulladder f22(a[22],b[22],c[22],c22,s22);
    fulladder f23(a[23],b[23],c[23],c23,s23);
    fulladder f24(a[24],b[24],c[24],c24,s24);
    fulladder f25(a[25],b[25],c[25],c25,s25);
    fulladder f26(a[26],b[26],c[26],c26,s26);
    fulladder f27(a[27],b[27],c[27],c27,s27);
    fulladder f28(a[28],b[28],c[28],c28,s28);
    fulladder f29(a[29],b[29],c[29],c29,s29);
    fulladder f30(a[30],b[30],c[30],c30,s30);
    fulladder f31(a[31],b[31],c[31],c31,s31);
    
    //Stage 2
    fulladder f32(d[0],s0,0,c32,s32);
    fulladder f33(d[1],s1,c0,c33,s33);
    fulladder f34(d[2],s2,c1,c34,s34);
    fulladder f35(d[3],s3,c2,c35,s35);
    fulladder f36(d[4],s4,c3,c36,s36);
    fulladder f37(d[5],s5,c4,c37,s37);
    fulladder f38(d[6],s6,c5,c38,s38);
    fulladder f39(d[7],s7,c6,c39,s39);
    fulladder f40(d[8],s8,c7,c40,s40);
    fulladder f41(d[9],s9,c8,c41,s41);
    fulladder f42(d[10],s10,c9,c42,s42);
    fulladder f43(d[11],s11,c10,c43,s43);
    fulladder f44(d[12],s12,c11,c44,s44);
    fulladder f45(d[13],s13,c12,c45,s45);
    fulladder f46(d[14],s14,c13,c46,s46);
    fulladder f47(d[15],s15,c14,c47,s47);
    fulladder f48(d[16],s16,c15,c48,s48);
    fulladder f49(d[17],s17,c16,c49,s49);
    fulladder f50(d[18],s18,c17,c50,s50);
    fulladder f51(d[19],s19,c18,c51,s51);
    fulladder f52(d[20],s20,c19,c52,s52);
    fulladder f53(d[21],s21,c20,c53,s53);
    fulladder f54(d[22],s22,c21,c54,s54);
    fulladder f55(d[23],s23,c22,c55,s55);
    fulladder f56(d[24],s24,c23,c56,s56);
    fulladder f57(d[25],s25,c24,c57,s57);
    fulladder f58(d[26],s26,c25,c58,s58);
    fulladder f59(d[27],s27,c26,c59,s59);
    fulladder f60(d[28],s28,c27,c60,s60);
    fulladder f61(d[29],s29,c28,c61,s61);
    fulladder f62(d[30],s30,c29,c62,s62);
    fulladder f63(d[31],s31,c30,c63,s63);
    
    //Stage 3
    fulladder f64(e[0],s32,0,c64,s64);
    fulladder f65(e[1],s33,c32,c65,s65);
    fulladder f66(e[2],s34,c33,c66,s66);
    fulladder f67(e[3],s35,c34,c67,s67);
    fulladder f68(e[4],s36,c35,c68,s68);
    fulladder f69(e[5],s37,c36,c69,s69);
    fulladder f70(e[6],s38,c37,c70,s70);
    fulladder f71(e[7],s39,c38,c71,s71);
    fulladder f72(e[8],s40,c39,c72,s72);
    fulladder f73(e[9],s41,c40,c73,s73);
    fulladder f74(e[10],s42,c41,c74,s74);
    fulladder f75(e[11],s43,c42,c75,s75);
    fulladder f76(e[12],s44,c43,c76,s76);
    fulladder f77(e[13],s45,c44,c77,s77);
    fulladder f78(e[14],s46,c45,c78,s78);
    fulladder f79(e[15],s47,c46,c79,s79);
    fulladder f80(e[16],s48,c47,c80,s80);
    fulladder f81(e[17],s49,c48,c81,s81);
    fulladder f82(e[18],s50,c49,c82,s82);
    fulladder f83(e[19],s51,c50,c83,s83);
    fulladder f84(e[20],s52,c51,c84,s84);
    fulladder f85(e[21],s53,c52,c85,s85);
    fulladder f86(e[22],s54,c53,c86,s86);
    fulladder f87(e[23],s55,c54,c87,s87);
    fulladder f88(e[24],s56,c55,c88,s88);
    fulladder f89(e[25],s57,c56,c89,s89);
    fulladder f90(e[26],s58,c57,c90,s90);
    fulladder f91(e[27],s59,c58,c91,s91);
    fulladder f92(e[28],s60,c59,c92,s92);
    fulladder f93(e[29],s61,c60,c93,s93);
    fulladder f94(e[30],s62,c61,c94,s94);
    fulladder f95(e[31],s63,c62,c95,s95);
    
    //Stage 4
    fulladder f96(f[0],s64,0,c96,s96);
    fulladder f97(f[1],s65,c64,c97,s97);
    fulladder f98(f[2],s66,c65,c98,s98);
    fulladder f99(f[3],s67,c66,c99,s99);
    fulladder f100(f[4],s68,c67,c100,s100);
    fulladder f101(f[5],s69,c68,c101,s101);
    fulladder f102(f[6],s70,c69,c102,s102);
    fulladder f103(f[7],s71,c70,c103,s103);
    fulladder f104(f[8],s72,c71,c104,s104);
    fulladder f105(f[9],s73,c72,c105,s105);
    fulladder f106(f[10],s74,c73,c106,s106);
    fulladder f107(f[11],s75,c74,c107,s107);
    fulladder f108(f[12],s76,c75,c108,s108);
    fulladder f109(f[13],s77,c76,c109,s109);
    fulladder f110(f[14],s78,c77,c110,s110);
    fulladder f111(f[15],s79,c78,c111,s111);
    fulladder f112(f[16],s80,c79,c112,s112);
    fulladder f113(f[17],s81,c80,c113,s113);
    fulladder f114(f[18],s82,c81,c114,s114);
    fulladder f115(f[19],s83,c82,c115,s115);
    fulladder f116(f[20],s84,c83,c116,s116);
    fulladder f117(f[21],s85,c84,c117,s117);
    fulladder f118(f[22],s86,c85,c118,s118);
    fulladder f119(f[23],s87,c86,c119,s119);
    fulladder f120(f[24],s88,c87,c120,s120);
    fulladder f121(f[25],s89,c88,c121,s121);
    fulladder f122(f[26],s90,c89,c122,s122);
    fulladder f123(f[27],s91,c90,c123,s123);
    fulladder f124(f[28],s92,c91,c124,s124);
    fulladder f125(f[29],s93,c92,c125,s125);
    fulladder f126(f[30],s94,c93,c126,s126);
    fulladder f127(f[31],s95,c94,c127,s127);
    
    
    //Stage 5
    fulladder f128(g[0],s96,0,c128,s128);
    fulladder f129(g[1],s97,c96,c129,s129);
    fulladder f130(g[2],s98,c97,c130,s130);
    fulladder f131(g[3],s99,c98,c131,s131);
    fulladder f132(g[4],s100,c99,c132,s132);
    fulladder f133(g[5],s101,c100,c133,s133);
    fulladder f134(g[6],s102,c101,c134,s134);
    fulladder f135(g[7],s103,c102,c135,s135);
    fulladder f136(g[8],s104,c103,c136,s136);
    fulladder f137(g[9],s105,c104,c137,s137);
    fulladder f138(g[10],s106,c105,c138,s138);
    fulladder f139(g[11],s107,c106,c139,s139);
    fulladder f140(g[12],s108,c107,c140,s140);
    fulladder f141(g[13],s109,c108,c141,s141);
    fulladder f142(g[14],s110,c109,c142,s142);
    fulladder f143(g[15],s111,c110,c143,s143);
    fulladder f144(g[16],s112,c111,c144,s144);
    fulladder f145(g[17],s113,c112,c145,s145);
    fulladder f146(g[18],s114,c113,c146,s146);
    fulladder f147(g[19],s115,c114,c147,s147);
    fulladder f148(g[20],s116,c115,c148,s148);
    fulladder f149(g[21],s117,c116,c149,s149);
    fulladder f150(g[22],s118,c117,c150,s150);
    fulladder f151(g[23],s119,c118,c151,s151);
    fulladder f152(g[24],s120,c119,c152,s152);
    fulladder f153(g[25],s121,c120,c153,s153);
    fulladder f154(g[26],s122,c121,c154,s154);
    fulladder f155(g[27],s123,c122,c155,s155);
    fulladder f156(g[28],s124,c123,c156,s156);
    fulladder f157(g[29],s125,c124,c157,s157);
    fulladder f158(g[30],s126,c125,c158,s158);
    fulladder f159(g[31],s127,c126,c159,s159);
    
    //Stage 6
    fulladder f160(h[0],s128,0,c160,s160);
    fulladder f161(h[1],s129,c128,c161,s161);
    fulladder f162(h[2],s130,c129,c162,s162);
    fulladder f163(h[3],s131,c130,c163,s163);
    fulladder f164(h[4],s132,c131,c164,s164);
    fulladder f165(h[5],s133,c132,c165,s165);
    fulladder f166(h[6],s134,c133,c166,s166);
    fulladder f167(h[7],s135,c134,c167,s167);
    fulladder f168(h[8],s136,c135,c168,s168);
    fulladder f169(h[9],s137,c136,c169,s169);
    fulladder f170(h[10],s138,c137,c170,s170);
    fulladder f171(h[11],s139,c138,c171,s171);
    fulladder f172(h[12],s140,c139,c172,s172);
    fulladder f173(h[13],s141,c140,c173,s173);
    fulladder f174(h[14],s142,c141,c174,s174);
    fulladder f175(h[15],s143,c142,c175,s175);
    fulladder f176(h[16],s144,c143,c176,s176);
    fulladder f177(h[17],s145,c144,c177,s177);
    fulladder f178(h[18],s146,c145,c178,s178);
    fulladder f179(h[19],s147,c146,c179,s179);
    fulladder f180(h[20],s148,c147,c180,s180);
    fulladder f181(h[21],s149,c148,c181,s181);
    fulladder f182(h[22],s150,c149,c182,s182);
    fulladder f183(h[23],s151,c150,c183,s183);
    fulladder f184(h[24],s152,c151,c184,s184);
    fulladder f185(h[25],s153,c152,c185,s185);
    fulladder f186(h[26],s154,c153,c186,s186);
    fulladder f187(h[27],s155,c154,c187,s187);
    fulladder f188(h[28],s156,c155,c188,s188);
    fulladder f189(h[29],s157,c156,c189,s189);
    fulladder f190(h[30],s158,c157,c190,s190);
    fulladder f191(h[31],s159,c158,c191,s191);
    
    //Stage 7
    fulladder f192(c160,s161,0,c192,s192);
    fulladder f193(c161,s162,c192,c193,s193);
    fulladder f194(c162,s163,c193,c194,s194);
    fulladder f195(c163,s164,c194,c195,s195);
    fulladder f196(c164,s165,c195,c196,s196);
    fulladder f197(c165,s166,c196,c197,s197);
    fulladder f198(c166,s167,c197,c198,s198);
    fulladder f199(c167,s168,c198,c199,s199);
    fulladder f200(c168,s169,c199,c200,s200);
    fulladder f201(c169,s170,c200,c201,s201);
    fulladder f202(c170,s171,c201,c202,s202);
    fulladder f203(c171,s172,c202,c203,s203);
    fulladder f204(c172,s173,c203,c204,s204);
    fulladder f205(c173,s174,c204,c205,s205);
    fulladder f206(c174,s175,c205,c206,s206);
    fulladder f207(c175,s176,c206,c207,s207);
    fulladder f208(c176,s177,c207,c208,s208);
    fulladder f209(c177,s178,c208,c209,s209);
    fulladder f210(c178,s179,c209,c210,s210);
    fulladder f211(c179,s180,c210,c211,s211);
    fulladder f212(c180,s181,c211,c212,s212);
    fulladder f213(c181,s182,c212,c213,s213);
    fulladder f214(c182,s183,c213,c214,s214);
    fulladder f215(c183,s184,c214,c215,s215);
    fulladder f216(c184,s185,c215,c216,s216);
    fulladder f217(c185,s186,c216,c217,s217);
    fulladder f218(c186,s187,c217,c218,s218);
    fulladder f219(c187,s188,c218,c219,s219);
    fulladder f220(c188,s189,c219,c220,s220);
    fulladder f221(c189,s190,c220,c221,s221);
    fulladder f222(c190,s191,c221,c222,s222);
    fulladder f223(c191,c222,c31,c223,s223);
    fulladder f224(c63,c95,c223,c224,s224);
    fulladder f225(c127,c159,c224,c225,s225);
    
    
    
    
    assign sum[0] = s160;
    assign sum[1] = s192;
    assign sum[2] = s193;
    assign sum[3] = s194;
    assign sum[4] = s195;
    assign sum[5] = s196;
    assign sum[6] = s197;
    assign sum[7] = s198;
    assign sum[8] = s199;
    assign sum[9] = s200;
    assign sum[10] = s201;
    assign sum[11] = s202;
    assign sum[12] = s203;
    assign sum[13] = s204;
    assign sum[14] = s205;
    assign sum[15] = s206;
    assign sum[16] = s207;
    assign sum[17] = s208;
    assign sum[18] = s209;
    assign sum[19] = s210;
    assign sum[20] = s211;
    assign sum[21] = s212;
    assign sum[22] = s213;
    assign sum[23] = s214;
    assign sum[24] = s215;
    assign sum[25] = s216;
    assign sum[26] = s217;
    assign sum[27] = s218;
    assign sum[28] = s219;
    assign sum[29] = s220;
    assign sum[30] = s221;
    assign sum[31] = s222;
    assign sum[32] = s223;
    assign sum[33] = s224;
    assign sum[34] = s225;
    assign cout = c225;
    
    
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