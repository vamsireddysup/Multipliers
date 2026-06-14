// 8-bit Dadda multiplier
// Generates the 8x8 partial product matrix, then reduces column heights
// through four Dadda reduction stages using half adders (HA) and full
// adders (FA), targeting heights 8->6->4->3->2, followed by a final
// carry-propagate addition of the two remaining rows. See README.md for
// the column height analysis and stage-by-stage derivation.
module dadda_multiplier_8bit(
    input  [7:0] a, b,
    output [15:0] prod
);

    // Partial product matrix: pp[i][j] = a[j] & b[i], weight = i+j
    wire pp [7:0][7:0];
    genvar gi, gj;
    generate
        for (gi = 0; gi < 8; gi = gi + 1) begin : row
            for (gj = 0; gj < 8; gj = gj + 1) begin : col
                assign pp[gi][gj] = a[gj] & b[gi];
            end
        end
    endgenerate

    // ---- Stage 1: reduce heights to <= 6 ----
    // Column 6 (height 7 -> 6)
    wire s1_w6, c1_w6;
    halfadder ha1(pp[0][6], pp[1][5], c1_w6, s1_w6);

    // Column 7 (height 8+1=9 -> 5)
    wire s1_w7a, c1_w7a, s1_w7b, c1_w7b;
    fulladder fa1(pp[0][7], pp[1][6], pp[2][5], c1_w7a, s1_w7a);
    fulladder fa2(pp[3][4], pp[4][3], pp[5][2], c1_w7b, s1_w7b);

    // Column 8 (height 7+2=9 -> 5)
    wire s1_w8a, c1_w8a, s1_w8b, c1_w8b;
    fulladder fa3(pp[1][7], pp[2][6], pp[3][5], c1_w8a, s1_w8a);
    fulladder fa4(pp[4][4], pp[5][3], pp[6][2], c1_w8b, s1_w8b);

    // Column 9 (height 6+2=8 -> 6)
    wire s1_w9, c1_w9;
    fulladder fa5(pp[2][7], pp[3][6], pp[4][5], c1_w9, s1_w9);

    // ---- Stage 2: reduce heights to <= 4 ----
    // Column 4 (height 5 -> 3)
    wire s2_w4, c2_w4;
    fulladder fa6(pp[0][4], pp[1][3], pp[2][2], c2_w4, s2_w4);

    // Column 5 (height 6+1=7 -> 3)
    wire s2_w5a, c2_w5a, s2_w5b, c2_w5b;
    fulladder fa7(pp[0][5], pp[1][4], pp[2][3], c2_w5a, s2_w5a);
    fulladder fa8(pp[3][2], pp[4][1], pp[5][0], c2_w5b, s2_w5b);

    // Column 6 (height 6+2=8 -> 4)
    wire s2_w6a, c2_w6a, s2_w6b, c2_w6b;
    fulladder fa9(pp[2][4], pp[3][3], pp[4][2], c2_w6a, s2_w6a);
    fulladder fa10(pp[5][1], pp[6][0], s1_w6, c2_w6b, s2_w6b);

    // Column 7 (height 5+2=7 -> 3)
    wire s2_w7a, c2_w7a, s2_w7b, c2_w7b;
    fulladder fa11(pp[6][1], pp[7][0], c1_w6, c2_w7a, s2_w7a);
    fulladder fa12(s1_w7a, s1_w7b, c2_w6a, c2_w7b, s2_w7b);

    // Column 8 (height 5+2=7 -> 3)
    wire s2_w8a, c2_w8a, s2_w8b, c2_w8b;
    fulladder fa13(pp[7][1], c1_w7a, c1_w7b, c2_w8a, s2_w8a);
    fulladder fa14(s1_w8a, s1_w8b, c2_w7a, c2_w8b, s2_w8b);

    // Column 9 (height 6+2=8 -> 4)
    wire s2_w9a, c2_w9a, s2_w9b, c2_w9b;
    fulladder fa15(pp[5][4], pp[6][3], pp[7][2], c2_w9a, s2_w9a);
    fulladder fa16(c1_w8a, c1_w8b, s1_w9, c2_w9b, s2_w9b);

    // Column 10 (height 6+2=8 -> 4)
    wire s2_w10a, c2_w10a, s2_w10b, c2_w10b;
    fulladder fa17(pp[3][7], pp[4][6], pp[5][5], c2_w10a, s2_w10a);
    fulladder fa18(pp[6][4], pp[7][3], c1_w9, c2_w10b, s2_w10b);

    // Column 11 (height 4+2=6 -> 4)
    wire s2_w11, c2_w11;
    fulladder fa19(pp[4][7], pp[5][6], pp[6][5], c2_w11, s2_w11);

    // ---- Stage 3: reduce heights to <= 3 ----
    // Column 3 (height 4 -> 3)
    wire s3_w3, c3_w3;
    halfadder ha2(pp[0][3], pp[1][2], c3_w3, s3_w3);

    // Column 4 (height 3+1=4 -> 3)
    wire s3_w4, c3_w4;
    halfadder ha3(pp[3][1], pp[4][0], c3_w4, s3_w4);

    // Column 5 (height 3+1=4 -> 3)
    wire s3_w5, c3_w5;
    halfadder ha4(s2_w5a, s2_w5b, c3_w5, s3_w5);

    // Column 6 (height 4+1=5 -> 3)
    wire s3_w6, c3_w6;
    fulladder fa20(c2_w5a, c2_w5b, s2_w6a, c3_w6, s3_w6);

    // Column 7 (height 3+1=4 -> 3)
    wire s3_w7, c3_w7;
    halfadder ha5(s2_w7a, s2_w7b, c3_w7, s3_w7);

    // Column 8 (height 3+1=4 -> 3)
    wire s3_w8, c3_w8;
    halfadder ha6(s2_w8a, s2_w8b, c3_w8, s3_w8);

    // Column 9 (height 4+1=5 -> 3)
    wire s3_w9, c3_w9;
    fulladder fa21(c2_w8a, c2_w8b, s2_w9a, c3_w9, s3_w9);

    // Column 10 (height 4+1=5 -> 3)
    wire s3_w10, c3_w10;
    fulladder fa22(c2_w9a, c2_w9b, s2_w10a, c3_w10, s3_w10);

    // Column 11 (height 4+1=5 -> 3)
    wire s3_w11, c3_w11;
    fulladder fa23(pp[7][4], c2_w10a, c2_w10b, c3_w11, s3_w11);

    // Column 12 (height 3+1=4 -> 3)
    wire s3_w12, c3_w12;
    fulladder fa24(pp[5][7], pp[6][6], pp[7][5], c3_w12, s3_w12);

    // ---- Stage 4: reduce heights to <= 2 ----
    // Column 2 (height 3 -> 2)
    wire s4_w2, c4_w2;
    halfadder ha7(pp[0][2], pp[1][1], c4_w2, s4_w2);

    // Column 3 (height 3+1=4 -> 2)
    wire s4_w3, c4_w3;
    fulladder fa25(pp[2][1], pp[3][0], s3_w3, c4_w3, s4_w3);

    // Column 4 (height 3+1=4 -> 2)
    wire s4_w4, c4_w4;
    fulladder fa26(s2_w4, c3_w3, s3_w4, c4_w4, s4_w4);

    // Column 5 (height 3+1=4 -> 2)
    wire s4_w5, c4_w5;
    fulladder fa27(c2_w4, c3_w4, s3_w5, c4_w5, s4_w5);

    // Column 6 (height 3+1=4 -> 2)
    wire s4_w6, c4_w6;
    fulladder fa28(s2_w6b, c3_w5, s3_w6, c4_w6, s4_w6);

    // Column 7 (height 3+1=4 -> 2)
    wire s4_w7, c4_w7;
    fulladder fa29(c2_w6b, c3_w6, s3_w7, c4_w7, s4_w7);

    // Column 8 (height 3+1=4 -> 2)
    wire s4_w8, c4_w8;
    fulladder fa30(c2_w7b, c3_w7, s3_w8, c4_w8, s4_w8);

    // Column 9 (height 3+1=4 -> 2)
    wire s4_w9, c4_w9;
    fulladder fa31(s2_w9b, c3_w8, s3_w9, c4_w9, s4_w9);

    // Column 10 (height 3+1=4 -> 2)
    wire s4_w10, c4_w10;
    fulladder fa32(s2_w10b, c3_w9, s3_w10, c4_w10, s4_w10);

    // Column 11 (height 3+1=4 -> 2)
    wire s4_w11, c4_w11;
    fulladder fa33(s2_w11, c3_w10, s3_w11, c4_w11, s4_w11);

    // Column 12 (height 3+1=4 -> 2)
    wire s4_w12, c4_w12;
    fulladder fa34(c2_w11, c3_w11, s3_w12, c4_w12, s4_w12);

    // Column 13 (height 2+1=3 -> 2)
    wire s4_w13, c4_w13;
    fulladder fa35(pp[6][7], pp[7][6], c3_w12, c4_w13, s4_w13);

    // ---- Final stage: carry-propagate addition of the two remaining rows ----
    assign prod[0] = pp[0][0];

    wire f_c1, f_c2, f_c3, f_c4, f_c5, f_c6, f_c7, f_c8, f_c9, f_c10, f_c11, f_c12, f_c13, f_c14;

    halfadder haf1(pp[0][1], pp[1][0], f_c1, prod[1]);
    fulladder faf2(pp[2][0], s4_w2, f_c1, f_c2, prod[2]);
    fulladder faf3(c4_w2, s4_w3, f_c2, f_c3, prod[3]);
    fulladder faf4(c4_w3, s4_w4, f_c3, f_c4, prod[4]);
    fulladder faf5(c4_w4, s4_w5, f_c4, f_c5, prod[5]);
    fulladder faf6(c4_w5, s4_w6, f_c5, f_c6, prod[6]);
    fulladder faf7(c4_w6, s4_w7, f_c6, f_c7, prod[7]);
    fulladder faf8(c4_w7, s4_w8, f_c7, f_c8, prod[8]);
    fulladder faf9(c4_w8, s4_w9, f_c8, f_c9, prod[9]);
    fulladder faf10(c4_w9, s4_w10, f_c9, f_c10, prod[10]);
    fulladder faf11(c4_w10, s4_w11, f_c10, f_c11, prod[11]);
    fulladder faf12(c4_w11, s4_w12, f_c11, f_c12, prod[12]);
    fulladder faf13(c4_w12, s4_w13, f_c12, f_c13, prod[13]);
    fulladder faf14(pp[7][7], c4_w13, f_c13, f_c14, prod[14]);
    assign prod[15] = f_c14;

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
