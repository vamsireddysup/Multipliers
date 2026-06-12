`timescale 1ns / 1ps

module radix4_16bit_approx3(
input [15:0]m,q,
output [31:0]prod
);
    wire [31:0]s;
    wire cout;
    wire [2:0]br[7:0];
    wire [17:0]pp[7:0];
    wire [31:0]spp[7:0];
    //wire [8:0]inv_m;
    assign br[0]={q[1],q[0],1'b0};
    assign br[1]={q[3],q[2],q[1]};
    assign br[2]={q[5],q[4],q[3]};
    assign br[3]={q[7],q[6],q[5]};
    assign br[4]={q[9],q[8],q[7]};
    assign br[5]={q[11],q[10],q[9]};
    assign br[6]={q[13],q[12],q[11]};
    assign br[7]={q[15],q[14],q[13]};
    
    partial_product pp0(.m(m), .br(br[0]), .pp(pp[0]));
    partial_product pp1(.m(m), .br(br[1]), .pp(pp[1]));
    partial_product pp2(.m(m), .br(br[2]), .pp(pp[2]));
    partial_product pp3(.m(m), .br(br[3]), .pp(pp[3]));
    partial_product pp4(.m(m), .br(br[4]), .pp(pp[4]));
    partial_product pp5(.m(m), .br(br[5]), .pp(pp[5]));
    partial_product pp6(.m(m), .br(br[6]), .pp(pp[6]));
    partial_product pp7(.m(m), .br(br[7]), .pp(pp[7]));
    
    sign_extend se0(.in(pp[0]), .out(spp[0]));
    sign_extend se1(.in(pp[1]), .out(spp[1]));
    sign_extend se2(.in(pp[2]), .out(spp[2]));
    sign_extend se3(.in(pp[3]), .out(spp[3]));
    sign_extend se4(.in(pp[4]), .out(spp[4]));
    sign_extend se5(.in(pp[5]), .out(spp[5]));
    sign_extend se6(.in(pp[6]), .out(spp[6]));
    sign_extend se7(.in(pp[7]), .out(spp[7]));
    
    //AC 0
    //csa cs1(.a(spp[0][31:0]),.b(spp[1][31:0]<<2),.c(spp[2][31:0]<<4),.d(spp[3][31:0]<<6),.e(spp[4][31:0]<<8),.f(spp[5][31:0]<<10),.g(spp[6][31:0]<<12),.h(spp[7][31:0]<<14),.cout(cout),.sum(prod[31:0]));
    
    //AC 4
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    approx1_4x2com cm1(0,0,0,0,0,co1,cr1,s1);
    
    approx1_4x2com cm2(spp[0][1],0,0,0,co0,co2,cr2,s2);
    approx1_4x2com cm3(0,0,0,0,co1,co3,cr3,s3);
    
    approx1_4x2com cm4(spp[0][2],spp[1][0],0,0,co2,co4,cr4,s4);
    approx1_4x2com cm5(0,0,0,0,co3,co5,cr5,s5);
    
    approx1_4x2com cm6(spp[0][3],spp[1][1],0,0,co4,co6,cr6,s6);
    approx1_4x2com cm7(0,0,0,0,co5,co7,cr7,s7);
    csa cs1(.a(spp[0][31:4]),.b(spp[1][31:2]),.c(spp[2][31:0]),.d(spp[3][31:0]<<2),.e(spp[4][31:0]<<4),.f(spp[5][31:0]<<6),.g(spp[6][31:0]<<8),.h(spp[7][31:0]<<10),.cout(cout),.sum(s[27:0]));
    
    halfadder ha0(s0,s1,co8,s8);
    compres cop1(s2,cr0,s3,cr1,co8,co9,cr9,s9);
    compres cop2(s4,cr2,s5,cr3,co9,co10,cr10,s10);
    compres cop3(s6,cr4,s7,cr5,co10,co11,cr11,s11);
    compres cop4(s[0],co6,co6,co7,cr7,co12,cr12,s12);
    fulladder fa0(s[1],co12,cr12,co13,s13);
    halfadder ha1(s[2],co13,co14,s14);
    halfadder ha2(s[3],co14,co15,s15);
    halfadder ha3(s[4],co15,co16,s16);
    halfadder ha4(s[5],co16,co17,s17);
    halfadder ha5(s[6],co17,co18,s18);
    halfadder ha6(s[7],co18,co19,s19);
    halfadder ha7(s[8],co19,co20,s20);
    halfadder ha8(s[9],co20,co21,s21);
    halfadder ha9(s[10],co21,co22,s22);
    halfadder ha10(s[11],co22,co23,s23);
    halfadder ha11(s[12],co23,co24,s24);
    halfadder ha12(s[13],co24,co25,s25);
    halfadder ha13(s[14],co25,co26,s26);
    halfadder ha14(s[15],co26,co27,s27);
    halfadder ha15(s[16],co27,co28,s28);
    halfadder ha16(s[17],co28,co29,s29);
    halfadder ha17(s[18],co29,co30,s30);
    halfadder ha18(s[19],co30,co31,s31);
    halfadder ha19(s[20],co31,co32,s32);
    halfadder ha20(s[21],co32,co33,s33);
    halfadder ha21(s[22],co33,co34,s34);
    halfadder ha22(s[23],co34,co35,s35);
    halfadder ha23(s[24],co35,co36,s36);
    halfadder ha24(s[25],co36,co37,s37);
    halfadder ha25(s[26],co37,co38,s38);
    halfadder ha26(s[27],co38,co39,s39);
    
    halfadder ha27(s10,cr9,co40,s40);
    fulladder fa1(s11,cr10,co40,co41,s41);
    //fulladder fa2(s12,co11,cr11,co42,s42);
    compres cop5(s12,co11,cr11,co41,0,co42,cr42,s42);
    fulladder fa3(s13,co42,cr42,co43,s43);
    halfadder ha30(s14,co43,co44,s44);
    halfadder ha31(s15,co44,co45,s45);
    halfadder ha32(s16,co45,co46,s46);
    halfadder ha33(s17,co46,co47,s47);
    halfadder ha34(s18,co47,co48,s48);
    halfadder ha35(s19,co48,co49,s49);
    halfadder ha36(s20,co49,co50,s50);
    halfadder ha37(s21,co50,co51,s51);
    halfadder ha38(s22,co51,co52,s52);
    halfadder ha39(s23,co52,co53,s53);
    halfadder ha40(s24,co53,co54,s54);
    halfadder ha41(s25,co54,co55,s55);
    halfadder ha42(s26,co55,co56,s56);
    halfadder ha43(s27,co56,co57,s57);
    halfadder ha44(s28,co57,co58,s58);
    halfadder ha45(s29,co58,co59,s59);
    halfadder ha46(s30,co59,co60,s60);
    halfadder ha47(s31,co60,co61,s61);
    halfadder ha48(s32,co61,co62,s62);
    halfadder ha49(s33,co62,co63,s63);
    halfadder ha50(s34,co63,co64,s64);
    halfadder ha51(s35,co64,co65,s65);
    halfadder ha52(s36,co65,co66,s66);
    halfadder ha53(s37,co66,co67,s67);
    halfadder ha54(s38,co67,co68,s68);
    halfadder ha55(s39,co68,co69,s69);
   
    assign prod[0] = s8;
    assign prod[1] = s9;
    assign prod[2] = s40;
    assign prod[3] = s41;
    assign prod[4] = s42;
    assign prod[5] = s43;
    assign prod[6] = s44;
    assign prod[7] = s45;
    assign prod[8] = s46;
    assign prod[9] = s47;
    assign prod[10] = s48;
    assign prod[11] = s49;
    assign prod[12] = s50;
    assign prod[13] = s51;
    assign prod[14] = s52;
    assign prod[15] = s53;
    assign prod[16] = s54;
    assign prod[17] = s55;
    assign prod[18] = s56;
    assign prod[19] = s57;
    assign prod[20] = s58;
    assign prod[21] = s59;
    assign prod[22] = s60;
    assign prod[23] = s61;
    assign prod[24] = s62;
    assign prod[25] = s63;
    assign prod[26] = s64;
    assign prod[27] = s65;
    assign prod[28] = s66;
    assign prod[29] = s67;
    assign prod[30] = s68;
    assign prod[31] = s69;*/
    
    //AC 8
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    approx1_4x2com cm1(0,0,0,0,0,co1,cr1,s1);
    
    approx1_4x2com cm2(spp[0][1],0,0,0,co0,co2,cr2,s2);
    approx1_4x2com cm3(0,0,0,0,co1,co3,cr3,s3);
    
    approx1_4x2com cm4(spp[0][2],spp[1][0],0,0,co2,co4,cr4,s4);
    approx1_4x2com cm5(0,0,0,0,co3,co5,cr5,s5);
    
    approx1_4x2com cm6(spp[0][3],spp[1][1],0,0,co4,co6,cr6,s6);
    approx1_4x2com cm7(0,0,0,0,co5,co7,cr7,s7);
    
    approx1_4x2com cm8(spp[0][4],spp[1][2],spp[2][0],0,co6,co8,cr8,s8);
    approx1_4x2com cm9(0,0,0,0,co7,co9,cr9,s9);
    
    approx1_4x2com cm10(spp[0][5],spp[1][3],spp[2][1],0,co8,co10,cr10,s10);
    approx1_4x2com cm11(0,0,0,0,co9,co11,cr11,s11);
    
    approx1_4x2com cm12(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co10,co12,cr12,s12);
    approx1_4x2com cm13(0,0,0,0,co11,co13,cr13,s13);
    
    approx1_4x2com cm14(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co12,co14,cr14,s14);
    approx1_4x2com cm15(0,0,0,0,co13,co15,cr15,s15);
    csa cs1(.a(spp[0][31:8]),.b(spp[1][31:6]),.c(spp[2][31:4]),.d(spp[3][31:2]),.e(spp[4][31:0]),.f(spp[5][31:0]<<2),.g(spp[6][31:0]<<4),.h(spp[7][31:0]<<6),.cout(cout),.sum(s[23:0]));
    
    halfadder ha0(s0,s1,co16,s16);
    compres cop1(s2,cr0,s3,cr1,co16,co17,cr17,s17);
    compres cop2(s4,cr2,s5,cr3,co17,co18,cr18,s18);
    compres cop3(s6,cr4,s7,cr5,co18,co19,cr19,s19);
    compres cop4(s8,cr6,s9,cr7,co19,co20,cr20,s20);
    compres cop5(s10,cr8,s11,cr9,co20,co21,cr21,s21);
    compres cop6(s12,cr10,s13,cr11,co21,co22,cr22,s22);
    compres cop7(s14,cr12,s15,cr13,co22,co23,cr23,s23);
    compres cop8(s[0],co14,cr14,co15,cr15,co24,cr24,s24);
    fulladder fa0(s[1],co24,cr24,co25,s25);
    halfadder ha1(s[2],co25,co26,s26);
    halfadder ha2(s[3],co26,co27,s27);
    halfadder ha3(s[4],co27,co28,s28);
    halfadder ha4(s[5],co28,co29,s29);
    halfadder ha5(s[6],co29,co30,s30);
    halfadder ha6(s[7],co30,co31,s31);
    halfadder ha7(s[8],co31,co32,s32);
    halfadder ha8(s[9],co32,co33,s33);
    halfadder ha9(s[10],co33,co34,s34);
    halfadder ha10(s[11],co34,co35,s35);
    halfadder ha11(s[12],co35,co36,s36);
    halfadder ha12(s[13],co36,co37,s37);
    halfadder ha13(s[14],co37,co38,s38);
    halfadder ha14(s[15],co38,co39,s39);
    halfadder ha15(s[16],co39,co40,s40);
    halfadder ha16(s[17],co40,co41,s41);
    halfadder ha17(s[18],co41,co42,s42);
    halfadder ha18(s[19],co42,co43,s43);
    halfadder ha19(s[20],co43,co44,s44);
    halfadder ha20(s[21],co44,co45,s45);
    halfadder ha21(s[22],co45,co46,s46);
    halfadder ha22(s[23],co46,co47,s47);
    
    halfadder ha23(s18,cr17,co48,s48);
    fulladder fa1(s19,cr18,co48,co49,s49);
    fulladder fa2(s20,cr19,co49,co50,s50);
    fulladder fa3(s21,cr20,co50,co51,s51);
    fulladder fa4(s22,cr21,co51,co52,s52);
    fulladder fa5(s23,cr22,co52,co53,s53);
    //halfadder ha24(s24,co53,co54,s54);
    compres cop9(s24,co23,cr23,co53,0,co54,cr54,s54);
    fulladder fa6(s25,co54,cr54,co55,s55);
    halfadder ha26(s26,co55,co56,s56);
    halfadder ha27(s27,co56,co57,s57);
    halfadder ha28(s28,co57,co58,s58);
    halfadder ha29(s29,co58,co59,s59);
    halfadder ha30(s30,co59,co60,s60);
    halfadder ha31(s31,co60,co61,s61);
    halfadder ha32(s32,co61,co62,s62);
    halfadder ha33(s33,co62,co63,s63);
    halfadder ha34(s34,co63,co64,s64);
    halfadder ha35(s35,co64,co65,s65);
    halfadder ha36(s36,co65,co66,s66);
    halfadder ha37(s37,co66,co67,s67);
    halfadder ha38(s38,co67,co68,s68);
    halfadder ha39(s39,co68,co69,s69);
    halfadder ha40(s40,co69,co70,s70);
    halfadder ha41(s41,co70,co71,s71);
    halfadder ha42(s42,co71,co72,s72);
    halfadder ha43(s43,co72,co73,s73);
    halfadder ha44(s44,co73,co74,s74);
    halfadder ha45(s45,co74,co75,s75);
    halfadder ha46(s46,co75,co76,s76);
    halfadder ha47(s47,co76,co77,s77);   
    
    assign prod[0] = s16;
    assign prod[1] = s17;
    assign prod[2] = s48;
    assign prod[3] = s49;
    assign prod[4] = s50;
    assign prod[5] = s51;
    assign prod[6] = s52;
    assign prod[7] = s53;
    assign prod[8] = s54;
    assign prod[9] = s55;
    assign prod[10] = s56;
    assign prod[11] = s57;
    assign prod[12] = s58;
    assign prod[13] = s59;
    assign prod[14] = s60;
    assign prod[15] = s61;
    assign prod[16] = s62;
    assign prod[17] = s63;
    assign prod[18] = s64;
    assign prod[19] = s65;
    assign prod[20] = s66;
    assign prod[21] = s67;
    assign prod[22] = s68;
    assign prod[23] = s69;
    assign prod[24] = s70;
    assign prod[25] = s71;
    assign prod[26] = s72;
    assign prod[27] = s73;
    assign prod[28] = s74;
    assign prod[29] = s75;
    assign prod[30] = s76;
    assign prod[31] = s77;*/
    
    //AC 12
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    approx1_4x2com cm1(0,0,0,0,0,co1,cr1,s1);
    
    approx1_4x2com cm2(spp[0][1],0,0,0,co0,co2,cr2,s2);
    approx1_4x2com cm3(0,0,0,0,co1,co3,cr3,s3);
    
    approx1_4x2com cm4(spp[0][2],spp[1][0],0,0,co2,co4,cr4,s4);
    approx1_4x2com cm5(0,0,0,0,co3,co5,cr5,s5);
    
    approx1_4x2com cm6(spp[0][3],spp[1][1],0,0,co4,co6,cr6,s6);
    approx1_4x2com cm7(0,0,0,0,co5,co7,cr7,s7);
    
    approx1_4x2com cm8(spp[0][4],spp[1][2],spp[2][0],0,co6,co8,cr8,s8);
    approx1_4x2com cm9(0,0,0,0,co7,co9,cr9,s9);
    
    approx1_4x2com cm10(spp[0][5],spp[1][3],spp[2][1],0,co8,co10,cr10,s10);
    approx1_4x2com cm11(0,0,0,0,co9,co11,cr11,s11);
    
    approx1_4x2com cm12(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co10,co12,cr12,s12);
    approx1_4x2com cm13(0,0,0,0,co11,co13,cr13,s13);
    
    approx1_4x2com cm14(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co12,co14,cr14,s14);
    approx1_4x2com cm15(0,0,0,0,co13,co15,cr15,s15);
    
    approx1_4x2com cm16(spp[0][8],spp[1][6],spp[2][4],spp[3][2],co14,co16,cr16,s16);
    approx1_4x2com cm17(spp[4][0],0,0,0,co15,co17,cr17,s17);
    
    approx1_4x2com cm18(spp[0][9],spp[1][7],spp[2][5],spp[3][3],co16,co18,cr18,s18);
    approx1_4x2com cm19(spp[4][1],0,0,0,co17,co19,cr19,s19);
    
    approx1_4x2com cm20(spp[0][10],spp[1][8],spp[2][6],spp[3][4],co18,co20,cr20,s20);
    approx1_4x2com cm21(spp[4][2],spp[5][0],0,0,co19,co21,cr21,s21);
    
    approx1_4x2com cm22(spp[0][11],spp[1][9],spp[2][7],spp[3][5],co20,co22,cr22,s22);
    approx1_4x2com cm23(spp[4][3],spp[5][1],0,0,co21,co23,cr23,s23);
    csa cs1(.a(spp[0][31:12]),.b(spp[1][31:10]),.c(spp[2][31:8]),.d(spp[3][31:6]),.e(spp[4][31:4]),.f(spp[5][31:2]),.g(spp[6][31:0]),.h(spp[7][31:0]<<2),.cout(cout),.sum(s[19:0]));
    
    halfadder ha0(s0,s1,co24,s24);
    compres cop1(s2,cr0,s3,cr1,co24,co25,cr25,s25);
    compres cop2(s4,cr2,s5,cr3,co25,co26,cr26,s26);
    compres cop3(s6,cr4,s7,cr5,co26,co27,cr27,s27);
    compres cop4(s8,cr6,s9,cr7,co27,co28,cr28,s28);
    compres cop5(s10,cr8,s11,cr9,co28,co29,cr29,s29);
    compres cop6(s12,cr10,s13,cr11,co29,co30,cr30,s30);
    compres cop7(s14,cr12,s15,cr13,co30,co31,cr31,s31);
    compres cop8(s16,cr14,s17,cr15,co31,co32,cr32,s32);
    compres cop9(s18,cr16,s19,cr17,co32,co33,cr33,s33);
    compres cop10(s20,cr18,s21,cr19,co33,co34,cr34,s34);
    compres cop11(s22,cr20,s23,cr21,co34,co35,cr35,s35);
    compres cop12(s[0],co22,cr22,co23,cr23,co36,cr36,s36);
    fulladder fa0(s[1],co36,cr36,co37,s37);
    halfadder ha1(s[2],co37,co38,s38);
    halfadder ha2(s[3],co38,co39,s39);
    halfadder ha3(s[4],co39,co40,s40);
    halfadder ha4(s[5],co40,co41,s41);
    halfadder ha5(s[6],co41,co42,s42);
    halfadder ha6(s[7],co42,co43,s43);
    halfadder ha7(s[8],co43,co44,s44);
    halfadder ha8(s[9],co44,co45,s45);
    halfadder ha9(s[10],co45,co46,s46);
    halfadder ha10(s[11],co46,co47,s47);
    halfadder ha11(s[12],co47,co48,s48);
    halfadder ha12(s[13],co48,co49,s49);
    halfadder ha13(s[14],co49,co50,s50);
    halfadder ha14(s[15],co50,co51,s51);
    halfadder ha15(s[16],co51,co52,s52);
    halfadder ha16(s[17],co52,co53,s53);
    halfadder ha17(s[18],co53,co54,s54);
    halfadder ha18(s[19],co54,co55,s55);
    
    halfadder ha19(s26,cr25,co56,s56);
    fulladder fa1(s27,cr26,co56,co57,s57);
    fulladder fa2(s28,cr27,co57,co58,s58);
    fulladder fa3(s29,cr28,co58,co59,s59);
    fulladder fa4(s30,cr29,co59,co60,s60);
    fulladder fa5(s31,cr30,co60,co61,s61);
    fulladder fa6(s32,cr31,co61,co62,s62);
    fulladder fa7(s33,cr32,co62,co63,s63);
    fulladder fa8(s34,cr33,co63,co64,s64);
    fulladder fa9(s35,cr34,co64,co65,s65);
    compres cop13(s36,co35,cr35,co65,0,co66,cr66,s66);
    fulladder fa10(s37,co66,cr66,co67,s67);
    halfadder ha20(s38,co67,co68,s68);
    halfadder ha21(s39,co68,co69,s69);
    halfadder ha22(s40,co69,co70,s70);
    halfadder ha23(s41,co70,co71,s71);
    halfadder ha24(s42,co71,co72,s72);
    halfadder ha25(s43,co72,co73,s73);
    halfadder ha26(s44,co73,co74,s74);
    halfadder ha27(s45,co74,co75,s75);
    halfadder ha28(s46,co75,co76,s76);
    halfadder ha29(s47,co76,co77,s77);
    halfadder ha30(s48,co77,co78,s78);
    halfadder ha31(s49,co78,co79,s79);
    halfadder ha32(s50,co79,co80,s80);
    halfadder ha33(s51,co80,co81,s81);
    halfadder ha34(s52,co81,co82,s82);
    halfadder ha35(s53,co82,co83,s83);
    halfadder ha36(s54,co83,co84,s84);
    halfadder ha37(s55,co84,co85,s85);
    
    assign prod[0] = s24;
    assign prod[1] = s25;
    assign prod[2] = s56;
    assign prod[3] = s57;
    assign prod[4] = s58;
    assign prod[5] = s59;
    assign prod[6] = s60;
    assign prod[7] = s61;
    assign prod[8] = s62;
    assign prod[9] = s63;
    assign prod[10] = s64;
    assign prod[11] = s65;
    assign prod[12] = s66;
    assign prod[13] = s67;
    assign prod[14] = s68;
    assign prod[15] = s69;
    assign prod[16] = s70;
    assign prod[17] = s71;
    assign prod[18] = s72;
    assign prod[19] = s73;
    assign prod[20] = s74;
    assign prod[21] = s75;
    assign prod[22] = s76;
    assign prod[23] = s77;
    assign prod[24] = s78;
    assign prod[25] = s79;
    assign prod[26] = s80;
    assign prod[27] = s81;
    assign prod[28] = s82;
    assign prod[29] = s83;
    assign prod[30] = s84;
    assign prod[31] = s85;*/
    
    //AC 16
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    approx1_4x2com cm1(0,0,0,0,0,co1,cr1,s1);
    
    approx1_4x2com cm2(spp[0][1],0,0,0,co0,co2,cr2,s2);
    approx1_4x2com cm3(0,0,0,0,co1,co3,cr3,s3);
    
    approx1_4x2com cm4(spp[0][2],spp[1][0],0,0,co2,co4,cr4,s4);
    approx1_4x2com cm5(0,0,0,0,co3,co5,cr5,s5);
    
    approx1_4x2com cm6(spp[0][3],spp[1][1],0,0,co4,co6,cr6,s6);
    approx1_4x2com cm7(0,0,0,0,co5,co7,cr7,s7);
    
    approx1_4x2com cm8(spp[0][4],spp[1][2],spp[2][0],0,co6,co8,cr8,s8);
    approx1_4x2com cm9(0,0,0,0,co7,co9,cr9,s9);
    
    approx1_4x2com cm10(spp[0][5],spp[1][3],spp[2][1],0,co8,co10,cr10,s10);
    approx1_4x2com cm11(0,0,0,0,co9,co11,cr11,s11);
    
    approx1_4x2com cm12(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co10,co12,cr12,s12);
    approx1_4x2com cm13(0,0,0,0,co11,co13,cr13,s13);
    
    approx1_4x2com cm14(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co12,co14,cr14,s14);
    approx1_4x2com cm15(0,0,0,0,co13,co15,cr15,s15);
    
    approx1_4x2com cm16(spp[0][8],spp[1][6],spp[2][4],spp[3][2],co14,co16,cr16,s16);
    approx1_4x2com cm17(spp[4][0],0,0,0,co15,co17,cr17,s17);
    
    approx1_4x2com cm18(spp[0][9],spp[1][7],spp[2][5],spp[3][3],co16,co18,cr18,s18);
    approx1_4x2com cm19(spp[4][1],0,0,0,co17,co19,cr19,s19);
    
    approx1_4x2com cm20(spp[0][10],spp[1][8],spp[2][6],spp[3][4],co18,co20,cr20,s20);
    approx1_4x2com cm21(spp[4][2],spp[5][0],0,0,co19,co21,cr21,s21);
    
    approx1_4x2com cm22(spp[0][11],spp[1][9],spp[2][7],spp[3][5],co20,co22,cr22,s22);
    approx1_4x2com cm23(spp[4][3],spp[5][1],0,0,co21,co23,cr23,s23);
    
    approx1_4x2com cm24(spp[0][12],spp[1][10],spp[2][8],spp[3][6],co22,co24,cr24,s24);
    approx1_4x2com cm25(spp[4][4],spp[5][2],spp[6][0],0,co23,co25,cr25,s25);
    
    approx1_4x2com cm26(spp[0][13],spp[1][11],spp[2][9],spp[3][7],co24,co26,cr26,s26);
    approx1_4x2com cm27(spp[4][5],spp[5][3],spp[6][1],0,co25,co27,cr27,s27);
    
    approx1_4x2com cm28(spp[0][14],spp[1][12],spp[2][10],spp[3][8],co26,co28,cr28,s28);
    approx1_4x2com cm29(spp[4][6],spp[5][4],spp[6][2],spp[7][0],co27,co29,cr29,s29);
    
    approx1_4x2com cm30(spp[0][15],spp[1][13],spp[2][11],spp[3][9],co28,co30,cr30,s30);
    approx1_4x2com cm31(spp[4][7],spp[5][5],spp[6][3],spp[7][1],co29,co31,cr31,s31);
    csa cs1(.a(spp[0][31:16]),.b(spp[1][31:14]),.c(spp[2][31:12]),.d(spp[3][31:10]),.e(spp[4][31:8]),.f(spp[5][31:6]),.g(spp[6][31:4]),.h(spp[7][31:2]),.cout(cout),.sum(s[15:0]));
    
    halfadder ha0(s0,s1,co32,s32);
    compres cop1(s2,cr0,s3,cr1,co32,co33,cr33,s33);
    compres cop2(s4,cr2,s5,cr3,co33,co34,cr34,s34);
    compres cop3(s6,cr4,s7,cr5,co34,co35,cr35,s35);
    compres cop4(s8,cr6,s9,cr7,co35,co36,cr36,s36);
    compres cop5(s10,cr8,s11,cr9,co36,co37,cr37,s37);
    compres cop6(s12,cr10,s13,cr11,co37,co38,cr38,s38);
    compres cop7(s14,cr12,s15,cr13,co38,co39,cr39,s39);
    compres cop8(s16,cr14,s17,cr15,co39,co40,cr40,s40);
    compres cop9(s18,cr16,s19,cr17,co40,co41,cr41,s41);
    compres cop10(s20,cr18,s21,cr19,co41,co42,cr42,s42);
    compres cop11(s22,cr20,s23,cr21,co42,co43,cr43,s43);
    compres cop12(s24,cr22,s25,cr23,co43,co44,cr44,s44);
    compres cop13(s26,cr24,s27,cr25,co44,co45,cr45,s45);
    compres cop14(s28,cr26,s29,cr27,co45,co46,cr46,s46);
    compres cop15(s30,cr28,s31,cr29,co46,co47,cr47,s47);
    compres cop17(s[0],co30,cr30,co31,cr31,co48,cr48,s48);
    fulladder fa0(s[1],co48,cr48,co49,s49);
    halfadder ha1(s[2],co49,co50,s50);
    halfadder ha2(s[3],co50,co51,s51);
    halfadder ha3(s[4],co51,co52,s52);
    halfadder ha4(s[5],co52,co53,s53);
    halfadder ha5(s[6],co53,co54,s54);
    halfadder ha6(s[7],co54,co55,s55);
    halfadder ha7(s[8],co55,co56,s56);
    halfadder ha8(s[9],co56,co57,s57);
    halfadder ha9(s[10],co57,co58,s58);
    halfadder ha10(s[11],co58,co59,s59);
    halfadder ha11(s[12],co59,co60,s60);
    halfadder ha12(s[13],co60,co61,s61);
    halfadder ha13(s[14],co61,co62,s62);
    halfadder ha14(s[15],co62,co63,s63);
    
    halfadder ha15(s34,cr33,co65,s65);
    fulladder  fa1(s35,cr34,co65,co66,s66);
    fulladder  fa2(s36,cr35,co66,co67,s67);
    fulladder  fa3(s37,cr36,co67,co68,s68);
    fulladder  fa4(s38,cr37,co68,co69,s69);
    fulladder  fa5(s39,cr38,co69,co70,s70);
    fulladder  fa6(s40,cr39,co70,co71,s71);
    fulladder  fa7(s41,cr40,co71,co72,s72);
    fulladder  fa8(s42,cr41,co72,co73,s73);
    fulladder  fa9(s43,cr42,co73,co74,s74);
    fulladder  fa10(s44,cr43,co74,co75,s75);
    fulladder  fa11(s45,cr44,co75,co76,s76);
    fulladder  fa12(s46,cr45,co76,co77,s77);
    fulladder  fa13(s47,cr46,co77,co78,s78);
    compres cop18(s48,co47,cr47,co78,0,co79,cr79,s79);
    fulladder  fa15(s49,co79,cr79,co80,s80);
    halfadder ha16(s50,co80,co81,s81);
    halfadder ha17(s51,co81,co82,s82);
    halfadder ha18(s52,co82,co83,s83);
    halfadder ha19(s53,co83,co84,s84);
    halfadder ha20(s54,co84,co85,s85);
    halfadder ha21(s55,co85,co86,s86);
    halfadder ha22(s56,co86,co87,s87);
    halfadder ha23(s57,co87,co88,s88);
    halfadder ha24(s58,co88,co89,s89);
    halfadder ha25(s59,co89,co90,s90);
    halfadder ha26(s60,co90,co91,s91);
    halfadder ha27(s61,co91,co92,s92);
    halfadder ha28(s62,co92,co93,s93);
    halfadder ha29(s63,co93,co94,s94);
    
    assign prod[0] = s32;
    assign prod[1] = s33;
    assign prod[2] = s65;
    assign prod[3] = s66;
    assign prod[4] = s67;
    assign prod[5] = s68;
    assign prod[6] = s69;
    assign prod[7] = s70;
    assign prod[8] = s71;
    assign prod[9] = s72;
    assign prod[10] = s73;
    assign prod[11] = s74;
    assign prod[12] = s75;
    assign prod[13] = s76;
    assign prod[14] = s77;
    assign prod[15] = s78;
    assign prod[16] = s79;
    assign prod[17] = s80;
    assign prod[18] = s81;
    assign prod[19] = s82;
    assign prod[20] = s83;
    assign prod[21] = s84;
    assign prod[22] = s85;
    assign prod[23] = s86;
    assign prod[24] = s87;
    assign prod[25] = s88;
    assign prod[26] = s89;
    assign prod[27] = s90;
    assign prod[28] = s91;
    assign prod[29] = s92;
    assign prod[30] = s93;
    assign prod[31] = s94;*/
    
    
    //AC 20
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    approx1_4x2com cm1(0,0,0,0,0,co1,cr1,s1);
    
    approx1_4x2com cm2(spp[0][1],0,0,0,co0,co2,cr2,s2);
    approx1_4x2com cm3(0,0,0,0,co1,co3,cr3,s3);
    
    approx1_4x2com cm4(spp[0][2],spp[1][0],0,0,co2,co4,cr4,s4);
    approx1_4x2com cm5(0,0,0,0,co3,co5,cr5,s5);
    
    approx1_4x2com cm6(spp[0][3],spp[1][1],0,0,co4,co6,cr6,s6);
    approx1_4x2com cm7(0,0,0,0,co5,co7,cr7,s7);
    
    approx1_4x2com cm8(spp[0][4],spp[1][2],spp[2][0],0,co6,co8,cr8,s8);
    approx1_4x2com cm9(0,0,0,0,co7,co9,cr9,s9);
    
    approx1_4x2com cm10(spp[0][5],spp[1][3],spp[2][1],0,co8,co10,cr10,s10);
    approx1_4x2com cm11(0,0,0,0,co9,co11,cr11,s11);
    
    approx1_4x2com cm12(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co10,co12,cr12,s12);
    approx1_4x2com cm13(0,0,0,0,co11,co13,cr13,s13);
    
    approx1_4x2com cm14(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co12,co14,cr14,s14);
    approx1_4x2com cm15(0,0,0,0,co13,co15,cr15,s15);
    
    approx1_4x2com cm16(spp[0][8],spp[1][6],spp[2][4],spp[3][2],co14,co16,cr16,s16);
    approx1_4x2com cm17(spp[4][0],0,0,0,co15,co17,cr17,s17);
    
    approx1_4x2com cm18(spp[0][9],spp[1][7],spp[2][5],spp[3][3],co16,co18,cr18,s18);
    approx1_4x2com cm19(spp[4][1],0,0,0,co17,co19,cr19,s19);
    
    approx1_4x2com cm20(spp[0][10],spp[1][8],spp[2][6],spp[3][4],co18,co20,cr20,s20);
    approx1_4x2com cm21(spp[4][2],spp[5][0],0,0,co19,co21,cr21,s21);
    
    approx1_4x2com cm22(spp[0][11],spp[1][9],spp[2][7],spp[3][5],co20,co22,cr22,s22);
    approx1_4x2com cm23(spp[4][3],spp[5][1],0,0,co21,co23,cr23,s23);
    
    approx1_4x2com cm24(spp[0][12],spp[1][10],spp[2][8],spp[3][6],co22,co24,cr24,s24);
    approx1_4x2com cm25(spp[4][4],spp[5][2],spp[6][0],0,co23,co25,cr25,s25);
    
    approx1_4x2com cm26(spp[0][13],spp[1][11],spp[2][9],spp[3][7],co24,co26,cr26,s26);
    approx1_4x2com cm27(spp[4][5],spp[5][3],spp[6][1],0,co25,co27,cr27,s27);
    
    approx1_4x2com cm28(spp[0][14],spp[1][12],spp[2][10],spp[3][8],co26,co28,cr28,s28);
    approx1_4x2com cm29(spp[4][6],spp[5][4],spp[6][2],spp[7][0],co27,co29,cr29,s29);
    
    approx1_4x2com cm30(spp[0][15],spp[1][13],spp[2][11],spp[3][9],co28,co30,cr30,s30);
    approx1_4x2com cm31(spp[4][7],spp[5][5],spp[6][3],spp[7][1],co29,co31,cr31,s31);
    
    approx1_4x2com cm32(spp[0][16],spp[1][14],spp[2][12],spp[3][10],co30,co32,cr32,s32);
    approx1_4x2com cm33(spp[4][8],spp[5][6],spp[6][4],spp[7][2],co31,co33,cr33,s33);
    
    approx1_4x2com cm34(spp[0][17],spp[1][15],spp[2][13],spp[3][11],co32,co34,cr34,s34);
    approx1_4x2com cm35(spp[4][9],spp[5][7],spp[6][5],spp[7][3],co33,co35,cr35,s35);
    
    approx1_4x2com cm36(spp[0][18],spp[1][16],spp[2][14],spp[3][12],co34,co36,cr36,s36);
    approx1_4x2com cm37(spp[4][10],spp[5][8],spp[6][6],spp[7][4],co35,co37,cr37,s37);
    
    approx1_4x2com cm38(spp[0][19],spp[1][17],spp[2][15],spp[3][13],co36,co38,cr38,s38);
    approx1_4x2com cm39(spp[4][11],spp[5][9],spp[6][7],spp[7][5],co37,co39,cr39,s39);
    csa cs1(.a(spp[0][31:20]),.b(spp[1][31:18]),.c(spp[2][31:16]),.d(spp[3][31:14]),.e(spp[4][31:12]),.f(spp[5][31:10]),.g(spp[6][31:8]),.h(spp[7][31:6]),.cout(cout),.sum(s[11:0]));
    
    halfadder ha0(s0,s1,co40,s40);
    compres cop1(s2,cr0,s3,cr1,co40,co41,cr41,s41);
    compres cop2(s4,cr2,s5,cr3,co41,co42,cr42,s42);
    compres cop3(s6,cr4,s7,cr5,co42,co43,cr43,s43);
    compres cop4(s8,cr6,s9,cr7,co43,co44,cr44,s44);
    compres cop5(s10,cr8,s11,cr9,co44,co45,cr45,s45);
    compres cop6(s12,cr10,s13,cr11,co45,co46,cr46,s46);
    compres cop7(s14,cr12,s15,cr13,co46,co47,cr47,s47);
    compres cop8(s16,cr14,s17,cr15,co47,co48,cr48,s48);
    compres cop9(s18,cr16,s19,cr17,co48,co49,cr49,s49);
    compres cop10(s20,cr18,s21,cr19,co49,co50,cr50,s50);
    compres cop11(s22,cr20,s23,cr21,co50,co51,cr51,s51);
    compres cop12(s24,cr22,s25,cr23,co51,co52,cr52,s52);
    compres cop13(s26,cr24,s27,cr25,co52,co53,cr53,s53);
    compres cop14(s28,cr26,s29,cr27,co53,co54,cr54,s54);
    compres cop15(s30,cr28,s31,cr29,co54,co55,cr55,s55);
    compres cop16(s32,cr30,s33,cr31,co55,co56,cr56,s56);
    compres cop17(s34,cr32,s35,cr33,co56,co57,cr57,s57);
    compres cop18(s36,cr34,s37,cr35,co57,co58,cr58,s58);
    compres cop19(s38,cr36,s39,cr37,co58,co59,cr59,s59);
    compres cop20(s[0],co38,cr38,co39,cr39,co60,cr60,s60);
    fulladder fa0(s[1],co60,cr60,co61,s61);
    halfadder ha1(s[2],co61,co62,s62);
    halfadder ha2(s[3],co62,co63,s63);
    halfadder ha3(s[4],co63,co64,s64);
    halfadder ha4(s[5],co64,co65,s65);
    halfadder ha5(s[6],co65,co66,s66);
    halfadder ha6(s[7],co66,co67,s67);
    halfadder ha7(s[8],co67,co68,s68);
    halfadder ha8(s[9],co68,co69,s69);
    halfadder ha9(s[10],co69,co70,s70);
    halfadder ha10(s[11],co70,co71,s71);
    
    halfadder ha11(s42,cr41,co72,s72);
    fulladder fa1(s43,cr42,co72,co73,s73);
    fulladder fa2(s44,cr43,co73,co74,s74);
    fulladder fa3(s45,cr44,co74,co75,s75);
    fulladder fa4(s46,cr45,co75,co76,s76);
    fulladder fa5(s47,cr46,co76,co77,s77);
    fulladder fa6(s48,cr47,co77,co78,s78);
    fulladder fa7(s49,cr48,co78,co79,s79);
    fulladder fa8(s50,cr49,co79,co80,s80);
    fulladder fa9(s51,cr50,co80,co81,s81);
    fulladder fa10(s52,cr51,co81,co82,s82);
    fulladder fa11(s53,cr52,co82,co83,s83);
    fulladder fa12(s54,cr53,co83,co84,s84);
    fulladder fa13(s55,cr54,co84,co85,s85);
    fulladder fa14(s56,cr55,co85,co86,s86);
    fulladder fa15(s57,cr56,co86,co87,s87);
    fulladder fa16(s58,cr57,co87,co88,s88);
    fulladder fa17(s59,cr58,co88,co89,s89);
    compres cop21(s60,co59,cr59,co89,0,co90,cr90,s90);
    fulladder fa18(s61,co90,cr90,co91,s91);
    halfadder ha12(s62,co91,co92,s92);
    halfadder ha13(s63,co92,co93,s93);
    halfadder ha14(s64,co93,co94,s94);
    halfadder ha15(s65,co94,co95,s95);
    halfadder ha16(s66,co95,co96,s96);
    halfadder ha17(s67,co96,co97,s97);
    halfadder ha18(s68,co97,co98,s98);
    halfadder ha19(s69,co98,co99,s99);
    halfadder ha20(s70,co99,co100,s100);
    halfadder ha21(s71,co100,co101,s101);
    
    assign prod[0] = s40;
    assign prod[1] = s41;
    assign prod[2] = s72;
    assign prod[3] = s73;
    assign prod[4] = s74;
    assign prod[5] = s75;
    assign prod[6] = s76;
    assign prod[7] = s77;
    assign prod[8] = s78;
    assign prod[9] = s79;
    assign prod[10] = s80;
    assign prod[11] = s81;
    assign prod[12] = s82;
    assign prod[13] = s83;
    assign prod[14] = s84;
    assign prod[15] = s85;
    assign prod[16] = s86;
    assign prod[17] = s87;
    assign prod[18] = s88;
    assign prod[19] = s89;
    assign prod[20] = s90;
    assign prod[21] = s91;
    assign prod[22] = s92;
    assign prod[23] = s93;
    assign prod[24] = s94;
    assign prod[25] = s95;
    assign prod[26] = s96;
    assign prod[27] = s97;
    assign prod[28] = s98;
    assign prod[29] = s99;
    assign prod[30] = s100;
    assign prod[31] = s101;*/
    
    //AC 24
    /*approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    approx1_4x2com cm1(0,0,0,0,0,co1,cr1,s1);
    
    approx1_4x2com cm2(spp[0][1],0,0,0,co0,co2,cr2,s2);
    approx1_4x2com cm3(0,0,0,0,co1,co3,cr3,s3);
    
    approx1_4x2com cm4(spp[0][2],spp[1][0],0,0,co2,co4,cr4,s4);
    approx1_4x2com cm5(0,0,0,0,co3,co5,cr5,s5);
    
    approx1_4x2com cm6(spp[0][3],spp[1][1],0,0,co4,co6,cr6,s6);
    approx1_4x2com cm7(0,0,0,0,co5,co7,cr7,s7);
    
    approx1_4x2com cm8(spp[0][4],spp[1][2],spp[2][0],0,co6,co8,cr8,s8);
    approx1_4x2com cm9(0,0,0,0,co7,co9,cr9,s9);
    
    approx1_4x2com cm10(spp[0][5],spp[1][3],spp[2][1],0,co8,co10,cr10,s10);
    approx1_4x2com cm11(0,0,0,0,co9,co11,cr11,s11);
    
    approx1_4x2com cm12(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co10,co12,cr12,s12);
    approx1_4x2com cm13(0,0,0,0,co11,co13,cr13,s13);
    
    approx1_4x2com cm14(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co12,co14,cr14,s14);
    approx1_4x2com cm15(0,0,0,0,co13,co15,cr15,s15);
    
    approx1_4x2com cm16(spp[0][8],spp[1][6],spp[2][4],spp[3][2],co14,co16,cr16,s16);
    approx1_4x2com cm17(spp[4][0],0,0,0,co15,co17,cr17,s17);
    
    approx1_4x2com cm18(spp[0][9],spp[1][7],spp[2][5],spp[3][3],co16,co18,cr18,s18);
    approx1_4x2com cm19(spp[4][1],0,0,0,co17,co19,cr19,s19);
    
    approx1_4x2com cm20(spp[0][10],spp[1][8],spp[2][6],spp[3][4],co18,co20,cr20,s20);
    approx1_4x2com cm21(spp[4][2],spp[5][0],0,0,co19,co21,cr21,s21);
    
    approx1_4x2com cm22(spp[0][11],spp[1][9],spp[2][7],spp[3][5],co20,co22,cr22,s22);
    approx1_4x2com cm23(spp[4][3],spp[5][1],0,0,co21,co23,cr23,s23);
    
    approx1_4x2com cm24(spp[0][12],spp[1][10],spp[2][8],spp[3][6],co22,co24,cr24,s24);
    approx1_4x2com cm25(spp[4][4],spp[5][2],spp[6][0],0,co23,co25,cr25,s25);
    
    approx1_4x2com cm26(spp[0][13],spp[1][11],spp[2][9],spp[3][7],co24,co26,cr26,s26);
    approx1_4x2com cm27(spp[4][5],spp[5][3],spp[6][1],0,co25,co27,cr27,s27);
    
    approx1_4x2com cm28(spp[0][14],spp[1][12],spp[2][10],spp[3][8],co26,co28,cr28,s28);
    approx1_4x2com cm29(spp[4][6],spp[5][4],spp[6][2],spp[7][0],co27,co29,cr29,s29);
    
    approx1_4x2com cm30(spp[0][15],spp[1][13],spp[2][11],spp[3][9],co28,co30,cr30,s30);
    approx1_4x2com cm31(spp[4][7],spp[5][5],spp[6][3],spp[7][1],co29,co31,cr31,s31);
    
    approx1_4x2com cm32(spp[0][16],spp[1][14],spp[2][12],spp[3][10],co30,co32,cr32,s32);
    approx1_4x2com cm33(spp[4][8],spp[5][6],spp[6][4],spp[7][2],co31,co33,cr33,s33);
    
    approx1_4x2com cm34(spp[0][17],spp[1][15],spp[2][13],spp[3][11],co32,co34,cr34,s34);
    approx1_4x2com cm35(spp[4][9],spp[5][7],spp[6][5],spp[7][3],co33,co35,cr35,s35);
    
    approx1_4x2com cm36(spp[0][18],spp[1][16],spp[2][14],spp[3][12],co34,co36,cr36,s36);
    approx1_4x2com cm37(spp[4][10],spp[5][8],spp[6][6],spp[7][4],co35,co37,cr37,s37);
    
    approx1_4x2com cm38(spp[0][19],spp[1][17],spp[2][15],spp[3][13],co36,co38,cr38,s38);
    approx1_4x2com cm39(spp[4][11],spp[5][9],spp[6][7],spp[7][5],co37,co39,cr39,s39);
    
    approx1_4x2com cm40(spp[0][20],spp[1][18],spp[2][16],spp[3][14],co38,co40,cr40,s40);
    approx1_4x2com cm41(spp[4][12],spp[5][10],spp[6][8],spp[7][6],co39,co41,cr41,s41);
    
    approx1_4x2com cm42(spp[0][21],spp[1][19],spp[2][17],spp[3][15],co40,co42,cr42,s42);
    approx1_4x2com cm43(spp[4][13],spp[5][11],spp[6][9],spp[7][7],co41,co43,cr43,s43);
    
    approx1_4x2com cm44(spp[0][22],spp[1][20],spp[2][18],spp[3][16],co42,co44,cr44,s44);
    approx1_4x2com cm45(spp[4][14],spp[5][12],spp[6][10],spp[7][8],co43,co45,cr45,s45);
    
    approx1_4x2com cm46(spp[0][23],spp[1][21],spp[2][19],spp[3][17],co44,co46,cr46,s46);
    approx1_4x2com cm47(spp[4][15],spp[5][13],spp[6][11],spp[7][9],co45,co47,cr47,s47);
    csa cs1(.a(spp[0][31:24]),.b(spp[1][31:22]),.c(spp[2][31:20]),.d(spp[3][31:18]),.e(spp[4][31:16]),.f(spp[5][31:14]),.g(spp[6][31:12]),.h(spp[7][31:10]),.cout(cout),.sum(s[7:0]));
    
    
    halfadder ha0(s0,s1,co48,s48);
    compres cop1(s2,cr0,s3,cr1,co48,co49,cr49,s49);
    compres cop2(s4,cr2,s5,cr3,co49,co50,cr50,s50);
    compres cop3(s6,cr4,s7,cr5,co50,co51,cr51,s51);
    compres cop4(s8,cr6,s9,cr7,co51,co52,cr52,s52);
    compres cop5(s10,cr8,s11,cr9,co52,co53,cr53,s53);
    compres cop6(s12,cr10,s13,cr11,co53,co54,cr54,s54);
    compres cop7(s14,cr12,s15,cr13,co54,co55,cr55,s55);
    compres cop8(s16,cr14,s17,cr15,co55,co56,cr56,s56);
    compres cop9(s18,cr16,s19,cr17,co56,co57,cr57,s57);
    compres cop10(s20,cr18,s21,cr19,co57,co58,cr58,s58);
    compres cop11(s22,cr20,s23,cr21,co58,co59,cr59,s59);
    compres cop12(s24,cr22,s25,cr23,co59,co60,cr60,s60);
    compres cop13(s26,cr24,s27,cr25,co60,co61,cr61,s61);
    compres cop14(s28,cr26,s29,cr27,co61,co62,cr62,s62);
    compres cop15(s30,cr28,s31,cr29,co62,co63,cr63,s63);
    compres cop16(s32,cr30,s33,cr31,co63,co64,cr64,s64);
    compres cop17(s34,cr32,s35,cr33,co64,co65,cr65,s65);
    compres cop18(s36,cr34,s37,cr35,co65,co66,cr66,s66);
    compres cop19(s38,cr36,s39,cr37,co66,co67,cr67,s67);
    compres cop20(s40,cr38,s41,cr39,co67,co68,cr68,s68);
    compres cop21(s42,cr40,s43,cr41,co68,co69,cr69,s69);
    compres cop22(s44,cr42,s45,cr43,co69,co70,cr70,s70);
    compres cop23(s46,cr44,s47,cr45,co70,co71,cr71,s71);
    compres cop24(s[0],co46,cr46,co47,cr47,co72,cr72,s72);
    fulladder fa0(s[1],co72,cr72,co73,s73);
    halfadder ha1(s[2],co73,co74,s74);
    halfadder ha2(s[3],co74,co75,s75);
    halfadder ha3(s[4],co75,co76,s76);
    halfadder ha4(s[5],co76,co77,s77);
    halfadder ha5(s[6],co77,co78,s78);
    halfadder ha6(s[7],co78,co79,s79);
    
    halfadder ha7(s50,cr49,co80,s80);
    fulladder fa1(s51,cr50,co80,co81,s81);
    fulladder fa2(s52,cr51,co81,co82,s82);
    fulladder fa3(s53,cr52,co82,co83,s83);
    fulladder fa4(s54,cr53,co83,co84,s84);
    fulladder fa5(s55,cr54,co84,co85,s85);
    fulladder fa6(s56,cr55,co85,co86,s86);
    fulladder fa7(s57,cr56,co86,co87,s87);
    fulladder fa8(s58,cr57,co87,co88,s88);
    fulladder fa9(s59,cr58,co88,co89,s89);
    fulladder fa10(s60,cr59,co89,co90,s90);
    fulladder fa11(s61,cr60,co90,co91,s91);
    fulladder fa12(s62,cr61,co91,co92,s92);
    fulladder fa13(s63,cr62,co92,co93,s93);
    fulladder fa14(s64,cr63,co93,co94,s94);
    fulladder fa15(s65,cr64,co94,co95,s95);
    fulladder fa16(s66,cr65,co95,co96,s96);
    fulladder fa17(s67,cr66,co96,co97,s97);
    fulladder fa18(s68,cr67,co97,co98,s98);
    fulladder fa19(s69,cr68,co98,co99,s99);
    fulladder fa20(s70,cr69,co99,co100,s100);
    fulladder fa21(s71,cr70,co100,co101,s101);
    compres cop25(s72,co71,cr71,co101,0,co102,cr102,s102);
    fulladder fa22(s73,co102,cr102,co103,s103);
    halfadder ha8(s74,co103,co104,s104);
    halfadder ha9(s75,co104,co105,s105);
    halfadder ha10(s76,co105,co106,s106);
    halfadder ha11(s77,co106,co107,s107);
    halfadder ha12(s78,co107,co108,s108);
    halfadder ha13(s79,co108,co109,s109);
    
    assign prod[0] = s48;
    assign prod[1] = s49;
    assign prod[2] = s80;
    assign prod[3] = s81;
    assign prod[4] = s82;
    assign prod[5] = s83;
    assign prod[6] = s84;
    assign prod[7] = s85;
    assign prod[8] = s86;
    assign prod[9] = s87;
    assign prod[10] = s88;
    assign prod[11] = s89;
    assign prod[12] = s90;
    assign prod[13] = s91;
    assign prod[14] = s92;
    assign prod[15] = s93;
    assign prod[16] = s94;
    assign prod[17] = s95;
    assign prod[18] = s96;
    assign prod[19] = s97;
    assign prod[20] = s98;
    assign prod[21] = s99;
    assign prod[22] = s100;
    assign prod[23] = s101;
    assign prod[24] = s102;
    assign prod[25] = s103;
    assign prod[26] = s104;
    assign prod[27] = s105;
    assign prod[28] = s106;
    assign prod[29] = s107;
    assign prod[30] = s108;
    assign prod[31] = s109;*/
    
    
    //AC 28
    approx1_4x2com cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    approx1_4x2com cm1(0,0,0,0,0,co1,cr1,s1);
    
    approx1_4x2com cm2(spp[0][1],0,0,0,co0,co2,cr2,s2);
    approx1_4x2com cm3(0,0,0,0,co1,co3,cr3,s3);
    
    approx1_4x2com cm4(spp[0][2],spp[1][0],0,0,co2,co4,cr4,s4);
    approx1_4x2com cm5(0,0,0,0,co3,co5,cr5,s5);
    
    approx1_4x2com cm6(spp[0][3],spp[1][1],0,0,co4,co6,cr6,s6);
    approx1_4x2com cm7(0,0,0,0,co5,co7,cr7,s7);
    
    approx1_4x2com cm8(spp[0][4],spp[1][2],spp[2][0],0,co6,co8,cr8,s8);
    approx1_4x2com cm9(0,0,0,0,co7,co9,cr9,s9);
    
    approx1_4x2com cm10(spp[0][5],spp[1][3],spp[2][1],0,co8,co10,cr10,s10);
    approx1_4x2com cm11(0,0,0,0,co9,co11,cr11,s11);
    
    approx1_4x2com cm12(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co10,co12,cr12,s12);
    approx1_4x2com cm13(0,0,0,0,co11,co13,cr13,s13);
    
    approx1_4x2com cm14(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co12,co14,cr14,s14);
    approx1_4x2com cm15(0,0,0,0,co13,co15,cr15,s15);
    
    approx1_4x2com cm16(spp[0][8],spp[1][6],spp[2][4],spp[3][2],co14,co16,cr16,s16);
    approx1_4x2com cm17(spp[4][0],0,0,0,co15,co17,cr17,s17);
    
    approx1_4x2com cm18(spp[0][9],spp[1][7],spp[2][5],spp[3][3],co16,co18,cr18,s18);
    approx1_4x2com cm19(spp[4][1],0,0,0,co17,co19,cr19,s19);
    
    approx1_4x2com cm20(spp[0][10],spp[1][8],spp[2][6],spp[3][4],co18,co20,cr20,s20);
    approx1_4x2com cm21(spp[4][2],spp[5][0],0,0,co19,co21,cr21,s21);
    
    approx1_4x2com cm22(spp[0][11],spp[1][9],spp[2][7],spp[3][5],co20,co22,cr22,s22);
    approx1_4x2com cm23(spp[4][3],spp[5][1],0,0,co21,co23,cr23,s23);
    
    approx1_4x2com cm24(spp[0][12],spp[1][10],spp[2][8],spp[3][6],co22,co24,cr24,s24);
    approx1_4x2com cm25(spp[4][4],spp[5][2],spp[6][0],0,co23,co25,cr25,s25);
    
    approx1_4x2com cm26(spp[0][13],spp[1][11],spp[2][9],spp[3][7],co24,co26,cr26,s26);
    approx1_4x2com cm27(spp[4][5],spp[5][3],spp[6][1],0,co25,co27,cr27,s27);
    
    approx1_4x2com cm28(spp[0][14],spp[1][12],spp[2][10],spp[3][8],co26,co28,cr28,s28);
    approx1_4x2com cm29(spp[4][6],spp[5][4],spp[6][2],spp[7][0],co27,co29,cr29,s29);
    
    approx1_4x2com cm30(spp[0][15],spp[1][13],spp[2][11],spp[3][9],co28,co30,cr30,s30);
    approx1_4x2com cm31(spp[4][7],spp[5][5],spp[6][3],spp[7][1],co29,co31,cr31,s31);
    
    approx1_4x2com cm32(spp[0][16],spp[1][14],spp[2][12],spp[3][10],co30,co32,cr32,s32);
    approx1_4x2com cm33(spp[4][8],spp[5][6],spp[6][4],spp[7][2],co31,co33,cr33,s33);
    
    approx1_4x2com cm34(spp[0][17],spp[1][15],spp[2][13],spp[3][11],co32,co34,cr34,s34);
    approx1_4x2com cm35(spp[4][9],spp[5][7],spp[6][5],spp[7][3],co33,co35,cr35,s35);
    
    approx1_4x2com cm36(spp[0][18],spp[1][16],spp[2][14],spp[3][12],co34,co36,cr36,s36);
    approx1_4x2com cm37(spp[4][10],spp[5][8],spp[6][6],spp[7][4],co35,co37,cr37,s37);
    
    approx1_4x2com cm38(spp[0][19],spp[1][17],spp[2][15],spp[3][13],co36,co38,cr38,s38);
    approx1_4x2com cm39(spp[4][11],spp[5][9],spp[6][7],spp[7][5],co37,co39,cr39,s39);
    
    approx1_4x2com cm40(spp[0][20],spp[1][18],spp[2][16],spp[3][14],co38,co40,cr40,s40);
    approx1_4x2com cm41(spp[4][12],spp[5][10],spp[6][8],spp[7][6],co39,co41,cr41,s41);
    
    approx1_4x2com cm42(spp[0][21],spp[1][19],spp[2][17],spp[3][15],co40,co42,cr42,s42);
    approx1_4x2com cm43(spp[4][13],spp[5][11],spp[6][9],spp[7][7],co41,co43,cr43,s43);
    
    approx1_4x2com cm44(spp[0][22],spp[1][20],spp[2][18],spp[3][16],co42,co44,cr44,s44);
    approx1_4x2com cm45(spp[4][14],spp[5][12],spp[6][10],spp[7][8],co43,co45,cr45,s45);
    
    approx1_4x2com cm46(spp[0][23],spp[1][21],spp[2][19],spp[3][17],co44,co46,cr46,s46);
    approx1_4x2com cm47(spp[4][15],spp[5][13],spp[6][11],spp[7][9],co45,co47,cr47,s47);
    
    approx1_4x2com cm48(spp[0][24],spp[1][22],spp[2][20],spp[3][18],co46,co48,cr48,s48);
    approx1_4x2com cm49(spp[4][16],spp[5][14],spp[6][12],spp[7][10],co47,co49,cr49,s49);
    
    approx1_4x2com cm50(spp[0][25],spp[1][23],spp[2][21],spp[3][19],co48,co50,cr50,s50);
    approx1_4x2com cm51(spp[4][17],spp[5][15],spp[6][13],spp[7][11],co49,co51,cr51,s51);
    
    approx1_4x2com cm52(spp[0][26],spp[1][24],spp[2][22],spp[3][20],co50,co52,cr52,s52);
    approx1_4x2com cm53(spp[4][18],spp[5][16],spp[6][14],spp[7][12],co51,co53,cr53,s53);
    
    approx1_4x2com cm54(spp[0][27],spp[1][25],spp[2][23],spp[3][21],co52,co54,cr54,s54);
    approx1_4x2com cm55(spp[4][19],spp[5][17],spp[6][15],spp[7][13],co53,co55,cr55,s55);
    csa cs1(.a(spp[0][31:28]),.b(spp[1][31:26]),.c(spp[2][31:24]),.d(spp[3][31:22]),.e(spp[4][31:20]),.f(spp[5][31:18]),.g(spp[6][31:16]),.h(spp[7][31:14]),.cout(cout),.sum(s[3:0]));
    
    halfadder ha0(s0,s1,co56,s56);
    compres cop1(s2,cr0,s3,cr1,co56,co57,cr57,s57);
    compres cop2(s4,cr2,s5,cr3,co57,co58,cr58,s58);
    compres cop3(s6,cr4,s7,cr5,co58,co59,cr59,s59);
    compres cop4(s8,cr6,s9,cr7,co59,co60,cr60,s60);
    compres cop5(s10,cr8,s11,cr9,co60,co61,cr61,s61);
    compres cop6(s12,cr10,s13,cr11,co61,co62,cr62,s62);
    compres cop7(s14,cr12,s15,cr13,co62,co63,cr63,s63);
    compres cop8(s16,cr14,s17,cr15,co63,co64,cr64,s64);
    compres cop9(s18,cr16,s19,cr17,co64,co65,cr65,s65);
    compres cop10(s20,cr18,s21,cr19,co65,co66,cr66,s66);
    compres cop11(s22,cr20,s23,cr21,co66,co67,cr67,s67);
    compres cop12(s24,cr22,s25,cr23,co67,co68,cr68,s68);
    compres cop13(s26,cr24,s27,cr25,co68,co69,cr69,s69);
    compres cop14(s28,cr26,s29,cr27,co69,co70,cr70,s70);
    compres cop15(s30,cr28,s31,cr29,co70,co71,cr71,s71);
    compres cop16(s32,cr30,s33,cr31,co71,co72,cr72,s72);
    compres cop17(s34,cr32,s35,cr33,co72,co73,cr73,s73);
    compres cop18(s36,cr34,s37,cr35,co73,co74,cr74,s74);
    compres cop19(s38,cr36,s39,cr37,co74,co75,cr75,s75);
    compres cop20(s40,cr38,s41,cr39,co75,co76,cr76,s76);
    compres cop21(s42,cr40,s43,cr41,co76,co77,cr77,s77);
    compres cop22(s44,cr42,s45,cr43,co77,co78,cr78,s78);
    compres cop23(s46,cr44,s47,cr45,co78,co79,cr79,s79);
    compres cop24(s48,cr46,s49,cr47,co79,co80,cr80,s80);
    compres cop25(s50,cr48,s51,cr49,co80,co81,cr81,s81);
    compres cop26(s52,cr50,s53,cr51,co81,co82,cr82,s82);
    compres cop27(s54,cr52,s55,cr53,co82,co83,cr83,s83);
    compres cop28(s[0],co54,cr54,co55,cr55,co84,cr84,s84);
    fulladder fa0(s[1],co84,cr84,co85,s85);
    halfadder ha1(s[2],co85,co86,s86);
    halfadder ha2(s[3],co86,co87,s87);
    
    halfadder ha3(s58,cr57,co88,s88);
    fulladder fa1(s59,cr58,co88,co89,s89);
    fulladder fa2(s60,cr59,co89,co90,s90);
    fulladder fa3(s61,cr60,co90,co91,s91);
    fulladder fa4(s62,cr61,co91,co92,s92);
    fulladder fa5(s63,cr62,co92,co93,s93);
    fulladder fa6(s64,cr63,co93,co94,s94);
    fulladder fa7(s65,cr64,co94,co95,s95);
    fulladder fa8(s66,cr65,co95,co96,s96);
    fulladder fa9(s67,cr66,co96,co97,s97);
    fulladder fa10(s68,cr67,co97,co98,s98);
    fulladder fa11(s69,cr68,co98,co99,s99);
    fulladder fa12(s70,cr69,co99,co100,s100);
    fulladder fa13(s71,cr70,co100,co101,s101);
    fulladder fa14(s72,cr71,co101,co102,s102);
    fulladder fa15(s73,cr72,co102,co103,s103);
    fulladder fa16(s74,cr73,co103,co104,s104);
    fulladder fa17(s75,cr74,co104,co105,s105);
    fulladder fa18(s76,cr75,co105,co106,s106);
    fulladder fa19(s77,cr76,co106,co107,s107);
    fulladder fa20(s78,cr77,co107,co108,s108);
    fulladder fa21(s79,cr78,co108,co109,s109);
    fulladder fa22(s80,cr79,co109,co110,s110);
    fulladder fa23(s81,cr80,co110,co111,s111);
    fulladder fa24(s82,cr81,co111,co112,s112);
    fulladder fa25(s83,cr82,co112,co113,s113);
    compres cop29(s84,co83,cr83,co113,0,co114,cr114,s114);
    fulladder fa26(s85,co114,cr114,co115,s115);
    halfadder ha4(s86,co115,co116,s116);
    halfadder ha5(s87,co116,co117,s117);
    
    assign prod[0] = s56;
    assign prod[1] = s57;
    assign prod[2] = s88;
    assign prod[3] = s89;
    assign prod[4] = s90;
    assign prod[5] = s91;
    assign prod[6] = s92;
    assign prod[7] = s93;
    assign prod[8] = s94;
    assign prod[9] = s95;
    assign prod[10] = s96;
    assign prod[11] = s97;
    assign prod[12] = s98;
    assign prod[13] = s99;
    assign prod[14] = 100;
    assign prod[15] = s101;
    assign prod[16] = s102;
    assign prod[17] = s103;
    assign prod[18] = s104;
    assign prod[19] = s105;
    assign prod[20] = s106;
    assign prod[21] = s107;
    assign prod[22] = s108;
    assign prod[23] = s109;
    assign prod[24] = s110;
    assign prod[25] = s111;
    assign prod[26] = s112;
    assign prod[27] = s113;
    assign prod[28] = s114;
    assign prod[29] = s115;
    assign prod[30] = s116;
    assign prod[31] = s117;
    
    
                                 
endmodule


module inverter(
input [15:0] a,
output [16:0] b
);
    assign b = {~a[15],~a}+1;
endmodule


module partial_product(
input [15:0]m,
input [2:0]br,
output reg [17:0]pp
);

wire [16:0]inv_m;
inverter invm1(.a(m),.b(inv_m));

always@*
begin
case(br)
    3'b001,3'b010:pp={m[15],m[15],m};
    3'b011:pp={m[15],m,1'b0};
    3'b100:pp={inv_m,1'b0};
    3'b101,3'b110:pp={inv_m[16],inv_m};
    default:pp=0;

endcase
end

endmodule

module sign_extend(
input [17:0]in,
output reg [31:0]out

);
always@*
begin
out[31]=in[17];
out[30:0]=in[16:0];
if(in[17]==1'b1) begin
out[31:17]=15'b111111111111111;
end

end
endmodule


module approx1_4x2com(
input a,b,c,d,e,
output cout,carry,
output sum
);
assign sum = ((~(a&b))^(~(c&d)))^e;

assign cout = d;

assign carry=a;

endmodule

module csa(
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
//    assign sum[32] = s223;
//    assign sum[33] = s224;
//    assign sum[34] = s225;
    assign cout = c225;
    
    
endmodule

module compres(
input a,b,c,d,
input cin,
output cout,
output carry, sum
);
wire int_sum;
fulladder fa1(.a(a), .b(b), .cin(c), .cout(cout), .sum(int_sum));
fulladder fa2(.a(int_sum), .b(d), .cin(cin), .cout(carry), .sum(sum));

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
output cout,
output sum
);
assign cout=a&b;
assign sum=a^b;
endmodule