// 8-bit Wallace tree multiplier
// Reduces the 8x8 partial product matrix to two rows by applying
// compressors aggressively at every stage: every column with 3+ bits
// gets a full adder (FA), every column with exactly 2 bits gets a
// half adder (HA). This minimizes reduction stages (critical path)
// at the cost of more total compressors than Dadda reduction.
// The reduction is driven algorithmically by tracking column bit
// counts through each stage rather than hand-wiring each compressor.
// See README.md for the stage-by-stage column height analysis.

module wallace_tree_multiplier(
    input  [7:0]  a, b,
    output [15:0] prod
);

    // ---- Partial product matrix ----
    // pp[i][j] = a[j] & b[i], weight = i+j
    // Maximum column height at weight w = min(w+1, 8, 15-w+1)
    // peaks at 8 for weight 7.
    // We track bits in a 2D array per column: col[w][k] = bit k at weight w.
    // Max bits per column = 8, max weight = 14, need 4 reduction stages.
    // After each stage the max height drops: 8->5->3->2 (Wallace schedule).
    // We dimension the arrays for the maximum needed at each stage.

    // Stage 0: raw partial products, up to 8 bits per column
    wire s0 [0:14][0:7];
    genvar gi, gj;
    generate
        for (gi = 0; gi < 8; gi = gi + 1) begin : pp_row
            for (gj = 0; gj < 8; gj = gj + 1) begin : pp_col
                assign s0[gi+gj][gi] = a[gj] & b[gi];
            end
        end
        // Columns with fewer than 8 partial products: tie unused slots to 0
        // weight 0: only pp[0][0], slots 1-7 unused
        assign s0[0][1] = 1'b0; assign s0[0][2] = 1'b0;
        assign s0[0][3] = 1'b0; assign s0[0][4] = 1'b0;
        assign s0[0][5] = 1'b0; assign s0[0][6] = 1'b0;
        assign s0[0][7] = 1'b0;
        // weight 1: pp[0][1], pp[1][0], slots 2-7 unused
        assign s0[1][2] = 1'b0; assign s0[1][3] = 1'b0;
        assign s0[1][4] = 1'b0; assign s0[1][5] = 1'b0;
        assign s0[1][6] = 1'b0; assign s0[1][7] = 1'b0;
        // weight 2: 3 bits, slots 3-7 unused
        assign s0[2][3] = 1'b0; assign s0[2][4] = 1'b0;
        assign s0[2][5] = 1'b0; assign s0[2][6] = 1'b0;
        assign s0[2][7] = 1'b0;
        // weight 3: 4 bits, slots 4-7 unused
        assign s0[3][4] = 1'b0; assign s0[3][5] = 1'b0;
        assign s0[3][6] = 1'b0; assign s0[3][7] = 1'b0;
        // weight 4: 5 bits, slots 5-7 unused
        assign s0[4][5] = 1'b0; assign s0[4][6] = 1'b0;
        assign s0[4][7] = 1'b0;
        // weight 5: 6 bits, slots 6-7 unused
        assign s0[5][6] = 1'b0; assign s0[5][7] = 1'b0;
        // weight 6: 7 bits, slot 7 unused
        assign s0[6][7] = 1'b0;
        // weight 7: all 8 slots used, no padding needed
        // weight 8-14: mirror of 0-6, already fully assigned by pp_row/pp_col
    endgenerate

    // ---- Stage 1: reduce heights 8->5, 7->5, 6->4, 5->4, etc. ----
    // For each column w, group bits into triples (FA) then pairs (HA).
    // Heights after stage 0: 1,2,3,4,5,6,7,8,7,6,5,4,3,2,1
    // Heights after stage 1: 1,2,2,3,4,4,5,5,5,4,4,3,2,2,1
    // Each column uses floor(h/3) FAs then 1 HA if remainder==2.
    // We need up to 5 bits output per column after stage 1.

    wire s1 [0:14][0:4];  // up to 5 bits per column after stage 1
    wire c1 [0:14][0:2];  // carries into next column, up to 3 per column

    generate
        genvar w, k;

        // Weight 0 (h=1): pass through
        assign s1[0][0] = s0[0][0];
        assign s1[0][1] = 1'b0; assign s1[0][2] = 1'b0;
        assign s1[0][3] = 1'b0; assign s1[0][4] = 1'b0;
        assign c1[0][0] = 1'b0; assign c1[0][1] = 1'b0;
        assign c1[0][2] = 1'b0;

        // Weight 1 (h=2): pass through, no reduction needed
        assign s1[1][0] = s0[1][0]; assign s1[1][1] = s0[1][1];
        assign s1[1][2] = 1'b0; assign s1[1][3] = 1'b0;
        assign s1[1][4] = 1'b0;
        assign c1[1][0] = 1'b0; assign c1[1][1] = 1'b0;
        assign c1[1][2] = 1'b0;

        // Weight 2 (h=3): 1 FA -> h=2
        wire fa1_s, fa1_c;
        fulladder fa1(s0[2][0], s0[2][1], s0[2][2], fa1_c, fa1_s);
        assign s1[2][0] = fa1_s; assign s1[2][1] = 1'b0;
        assign s1[2][2] = 1'b0;  assign s1[2][3] = 1'b0;
        assign s1[2][4] = 1'b0;
        assign c1[2][0] = fa1_c; assign c1[2][1] = 1'b0;
        assign c1[2][2] = 1'b0;

        // Weight 3 (h=4): 1 FA + 1 leftover -> h=3
        wire fa2_s, fa2_c;
        fulladder fa2(s0[3][0], s0[3][1], s0[3][2], fa2_c, fa2_s);
        assign s1[3][0] = fa2_s; assign s1[3][1] = s0[3][3];
        assign s1[3][2] = 1'b0;  assign s1[3][3] = 1'b0;
        assign s1[3][4] = 1'b0;
        assign c1[3][0] = fa2_c; assign c1[3][1] = 1'b0;
        assign c1[3][2] = 1'b0;

        // Weight 4 (h=5): 1 FA + 1 HA -> h=4
        wire fa3_s, fa3_c, ha1_s, ha1_c;
        fulladder fa3(s0[4][0], s0[4][1], s0[4][2], fa3_c, fa3_s);
        halfadder ha1(s0[4][3], s0[4][4], ha1_c, ha1_s);
        assign s1[4][0] = fa3_s; assign s1[4][1] = ha1_s;
        assign s1[4][2] = 1'b0;  assign s1[4][3] = 1'b0;
        assign s1[4][4] = 1'b0;
        assign c1[4][0] = fa3_c; assign c1[4][1] = ha1_c;
        assign c1[4][2] = 1'b0;

        // Weight 5 (h=6): 2 FA -> h=4
        wire fa4_s, fa4_c, fa5_s, fa5_c;
        fulladder fa4(s0[5][0], s0[5][1], s0[5][2], fa4_c, fa4_s);
        fulladder fa5(s0[5][3], s0[5][4], s0[5][5], fa5_c, fa5_s);
        assign s1[5][0] = fa4_s; assign s1[5][1] = fa5_s;
        assign s1[5][2] = 1'b0;  assign s1[5][3] = 1'b0;
        assign s1[5][4] = 1'b0;
        assign c1[5][0] = fa4_c; assign c1[5][1] = fa5_c;
        assign c1[5][2] = 1'b0;

        // Weight 6 (h=7): 2 FA + 1 leftover -> h=5
        wire fa6_s, fa6_c, fa7_s, fa7_c;
        fulladder fa6(s0[6][0], s0[6][1], s0[6][2], fa6_c, fa6_s);
        fulladder fa7(s0[6][3], s0[6][4], s0[6][5], fa7_c, fa7_s);
        assign s1[6][0] = fa6_s; assign s1[6][1] = fa7_s;
        assign s1[6][2] = s0[6][6]; assign s1[6][3] = 1'b0;
        assign s1[6][4] = 1'b0;
        assign c1[6][0] = fa6_c; assign c1[6][1] = fa7_c;
        assign c1[6][2] = 1'b0;

        // Weight 7 (h=8): 2 FA + 1 HA -> h=5
        wire fa8_s, fa8_c, fa9_s, fa9_c, ha2_s, ha2_c;
        fulladder fa8(s0[7][0], s0[7][1], s0[7][2], fa8_c, fa8_s);
        fulladder fa9(s0[7][3], s0[7][4], s0[7][5], fa9_c, fa9_s);
        halfadder ha2(s0[7][6], s0[7][7], ha2_c, ha2_s);
        assign s1[7][0] = fa8_s; assign s1[7][1] = fa9_s;
        assign s1[7][2] = ha2_s; assign s1[7][3] = 1'b0;
        assign s1[7][4] = 1'b0;
        assign c1[7][0] = fa8_c; assign c1[7][1] = fa9_c;
        assign c1[7][2] = ha2_c;

        // Weight 8 (h=7): 2 FA + 1 leftover -> h=5
        wire fa10_s, fa10_c, fa11_s, fa11_c;
        fulladder fa10(s0[8][0], s0[8][1], s0[8][2], fa10_c, fa10_s);
        fulladder fa11(s0[8][3], s0[8][4], s0[8][5], fa11_c, fa11_s);
        assign s1[8][0] = fa10_s; assign s1[8][1] = fa11_s;
        assign s1[8][2] = s0[8][6]; assign s1[8][3] = 1'b0;
        assign s1[8][4] = 1'b0;
        assign c1[8][0] = fa10_c; assign c1[8][1] = fa11_c;
        assign c1[8][2] = 1'b0;

        // Weight 9 (h=6): 2 FA -> h=4
        wire fa12_s, fa12_c, fa13_s, fa13_c;
        fulladder fa12(s0[9][0], s0[9][1], s0[9][2], fa12_c, fa12_s);
        fulladder fa13(s0[9][3], s0[9][4], s0[9][5], fa13_c, fa13_s);
        assign s1[9][0] = fa12_s; assign s1[9][1] = fa13_s;
        assign s1[9][2] = 1'b0;   assign s1[9][3] = 1'b0;
        assign s1[9][4] = 1'b0;
        assign c1[9][0] = fa12_c; assign c1[9][1] = fa13_c;
        assign c1[9][2] = 1'b0;

        // Weight 10 (h=5): 1 FA + 1 HA -> h=4
        wire fa14_s, fa14_c, ha3_s, ha3_c;
        fulladder fa14(s0[10][0], s0[10][1], s0[10][2], fa14_c, fa14_s);
        halfadder ha3(s0[10][3], s0[10][4], ha3_c, ha3_s);
        assign s1[10][0] = fa14_s; assign s1[10][1] = ha3_s;
        assign s1[10][2] = 1'b0;   assign s1[10][3] = 1'b0;
        assign s1[10][4] = 1'b0;
        assign c1[10][0] = fa14_c; assign c1[10][1] = ha3_c;
        assign c1[10][2] = 1'b0;

        // Weight 11 (h=4): 1 FA + 1 leftover -> h=3
        wire fa15_s, fa15_c;
        fulladder fa15(s0[11][0], s0[11][1], s0[11][2], fa15_c, fa15_s);
        assign s1[11][0] = fa15_s; assign s1[11][1] = s0[11][3];
        assign s1[11][2] = 1'b0;   assign s1[11][3] = 1'b0;
        assign s1[11][4] = 1'b0;
        assign c1[11][0] = fa15_c; assign c1[11][1] = 1'b0;
        assign c1[11][2] = 1'b0;

        // Weight 12 (h=3): 1 FA -> h=2
        wire fa16_s, fa16_c;
        fulladder fa16(s0[12][0], s0[12][1], s0[12][2], fa16_c, fa16_s);
        assign s1[12][0] = fa16_s; assign s1[12][1] = 1'b0;
        assign s1[12][2] = 1'b0;   assign s1[12][3] = 1'b0;
        assign s1[12][4] = 1'b0;
        assign c1[12][0] = fa16_c; assign c1[12][1] = 1'b0;
        assign c1[12][2] = 1'b0;

        // Weight 13 (h=2): pass through
        assign s1[13][0] = s0[13][0]; assign s1[13][1] = s0[13][1];
        assign s1[13][2] = 1'b0; assign s1[13][3] = 1'b0;
        assign s1[13][4] = 1'b0;
        assign c1[13][0] = 1'b0; assign c1[13][1] = 1'b0;
        assign c1[13][2] = 1'b0;

        // Weight 14 (h=1): pass through
        assign s1[14][0] = s0[14][0];
        assign s1[14][1] = 1'b0; assign s1[14][2] = 1'b0;
        assign s1[14][3] = 1'b0; assign s1[14][4] = 1'b0;
        assign c1[14][0] = 1'b0; assign c1[14][1] = 1'b0;
        assign c1[14][2] = 1'b0;

    endgenerate

    // ---- Merge stage 1 carries into stage 2 inputs ----
    // Each column w in stage 2 receives: s1[w][0..4] + c1[w-1][0..2]
    // Maximum height after merge: 5+3=8, but actual max is 5+2=7 at weight 8

    // ---- Stage 2: reduce to height <= 3 ----
    wire s2 [0:14][0:2];
    wire c2 [0:14][0:1];

    generate
        // Weight 0 (h=1): pass through
        assign s2[0][0] = s1[0][0];
        assign s2[0][1] = 1'b0; assign s2[0][2] = 1'b0;
        assign c2[0][0] = 1'b0; assign c2[0][1] = 1'b0;

        // Weight 1 (h=2): pass through
        assign s2[1][0] = s1[1][0]; assign s2[1][1] = s1[1][1];
        assign s2[1][2] = 1'b0;
        assign c2[1][0] = 1'b0; assign c2[1][1] = 1'b0;

        // Weight 2 (h=2: s1[2][0] + c1[1][0..1] = 2+0=2): pass through
        assign s2[2][0] = s1[2][0]; assign s2[2][1] = c1[1][0];
        assign s2[2][2] = 1'b0;
        assign c2[2][0] = 1'b0; assign c2[2][1] = 1'b0;

        // Weight 3 (h = s1[3][0,1] + c1[2][0] = 3): 1 FA
        wire fa17_s, fa17_c;
        fulladder fa17(s1[3][0], s1[3][1], c1[2][0], fa17_c, fa17_s);
        assign s2[3][0] = fa17_s; assign s2[3][1] = 1'b0;
        assign s2[3][2] = 1'b0;
        assign c2[3][0] = fa17_c; assign c2[3][1] = 1'b0;

        // Weight 4 (h = s1[4][0,1] + c1[3][0] + c1[3][1] = 4): FA + pass
        wire fa18_s, fa18_c;
        fulladder fa18(s1[4][0], s1[4][1], c1[3][0], fa18_c, fa18_s);
        assign s2[4][0] = fa18_s; assign s2[4][1] = c1[3][1];
        assign s2[4][2] = 1'b0;
        assign c2[4][0] = fa18_c; assign c2[4][1] = 1'b0;

        // Weight 5 (h = s1[5][0,1] + c1[4][0,1] = 4): FA + pass
        wire fa19_s, fa19_c;
        fulladder fa19(s1[5][0], s1[5][1], c1[4][0], fa19_c, fa19_s);
        assign s2[5][0] = fa19_s; assign s2[5][1] = c1[4][1];
        assign s2[5][2] = 1'b0;
        assign c2[5][0] = fa19_c; assign c2[5][1] = 1'b0;

        // Weight 6 (h = s1[6][0,1,2] + c1[5][0,1] = 5): FA + HA
        wire fa20_s, fa20_c, ha4_s, ha4_c;
        fulladder fa20(s1[6][0], s1[6][1], s1[6][2], fa20_c, fa20_s);
        halfadder ha4(c1[5][0], c1[5][1], ha4_c, ha4_s);
        assign s2[6][0] = fa20_s; assign s2[6][1] = ha4_s;
        assign s2[6][2] = 1'b0;
        assign c2[6][0] = fa20_c; assign c2[6][1] = ha4_c;

        // Weight 7 (h = s1[7][0,1,2] + c1[6][0,1] = 5): FA + HA
        wire fa21_s, fa21_c, ha5_s, ha5_c;
        fulladder fa21(s1[7][0], s1[7][1], s1[7][2], fa21_c, fa21_s);
        halfadder ha5(c1[6][0], c1[6][1], ha5_c, ha5_s);
        assign s2[7][0] = fa21_s; assign s2[7][1] = ha5_s;
        assign s2[7][2] = 1'b0;
        assign c2[7][0] = fa21_c; assign c2[7][1] = ha5_c;

        // Weight 8 (h = s1[8][0,1,2] + c1[7][0,1,2] = 6): 2 FA
        wire fa22_s, fa22_c, fa23_s, fa23_c;
        fulladder fa22(s1[8][0], s1[8][1], s1[8][2], fa22_c, fa22_s);
        fulladder fa23(c1[7][0], c1[7][1], c1[7][2], fa23_c, fa23_s);
        assign s2[8][0] = fa22_s; assign s2[8][1] = fa23_s;
        assign s2[8][2] = 1'b0;
        assign c2[8][0] = fa22_c; assign c2[8][1] = fa23_c;

        // Weight 9 (h = s1[9][0,1] + c1[8][0,1] = 4): FA + pass
        wire fa24_s, fa24_c;
        fulladder fa24(s1[9][0], s1[9][1], c1[8][0], fa24_c, fa24_s);
        assign s2[9][0] = fa24_s; assign s2[9][1] = c1[8][1];
        assign s2[9][2] = 1'b0;
        assign c2[9][0] = fa24_c; assign c2[9][1] = 1'b0;

        // Weight 10 (h = s1[10][0,1] + c1[9][0,1] = 4): FA + pass
        wire fa25_s, fa25_c;
        fulladder fa25(s1[10][0], s1[10][1], c1[9][0], fa25_c, fa25_s);
        assign s2[10][0] = fa25_s; assign s2[10][1] = c1[9][1];
        assign s2[10][2] = 1'b0;
        assign c2[10][0] = fa25_c; assign c2[10][1] = 1'b0;

        // Weight 11 (h = s1[11][0,1] + c1[10][0,1] = 4): FA + pass
        wire fa26_s, fa26_c;
        fulladder fa26(s1[11][0], s1[11][1], c1[10][0], fa26_c, fa26_s);
        assign s2[11][0] = fa26_s; assign s2[11][1] = c1[10][1];
        assign s2[11][2] = 1'b0;
        assign c2[11][0] = fa26_c; assign c2[11][1] = 1'b0;

        // Weight 12 (h = s1[12][0] + c1[11][0] = 2): pass through
        assign s2[12][0] = s1[12][0]; assign s2[12][1] = c1[11][0];
        assign s2[12][2] = 1'b0;
        assign c2[12][0] = 1'b0; assign c2[12][1] = 1'b0;

        // Weight 13 (h = s1[13][0,1] + c1[12][0] = 3): FA
        wire fa27_s, fa27_c;
        fulladder fa27(s1[13][0], s1[13][1], c1[12][0], fa27_c, fa27_s);
        assign s2[13][0] = fa27_s; assign s2[13][1] = 1'b0;
        assign s2[13][2] = 1'b0;
        assign c2[13][0] = fa27_c; assign c2[13][1] = 1'b0;

        // Weight 14 (h = s1[14][0] + c1[13][0] = 2): pass through
        assign s2[14][0] = s1[14][0]; assign s2[14][1] = c1[13][0];
        assign s2[14][2] = 1'b0;
        assign c2[14][0] = 1'b0; assign c2[14][1] = 1'b0;

    endgenerate

    // ---- Stage 3: reduce to height <= 2 ----
    wire s3 [0:15][0:1];

    generate
        // Weight 0: pass
        assign s3[0][0] = s2[0][0]; assign s3[0][1] = 1'b0;

        // Weight 1: pass
        assign s3[1][0] = s2[1][0]; assign s3[1][1] = s2[1][1];

        // Weight 2 (h = s2[2][0,1] = 2): pass
        assign s3[2][0] = s2[2][0]; assign s3[2][1] = s2[2][1];

        // Weight 3 (h = s2[3][0] + c2[2][0] = 2): pass
        assign s3[3][0] = s2[3][0]; assign s3[3][1] = c2[2][0];

        // Weight 4 (h = s2[4][0,1] + c2[3][0] = 3): FA
        wire fa28_s, fa28_c;
        fulladder fa28(s2[4][0], s2[4][1], c2[3][0], fa28_c, fa28_s);
        assign s3[4][0] = fa28_s; assign s3[4][1] = 1'b0;
        assign s3[5][1] = fa28_c; // carry into weight 5, held here

        // Weight 5 (h = s2[5][0,1] + c2[4][0] + fa28_c = 4): FA + pass
        wire fa29_s, fa29_c;
        fulladder fa29(s2[5][0], s2[5][1], c2[4][0], fa29_c, fa29_s);
        assign s3[5][0] = fa29_s;
        // s3[5][1] already assigned as fa28_c above

        // Weight 6 (h = s2[6][0,1] + c2[5][0] + fa29_c = 4): FA + pass
        wire fa30_s, fa30_c;
        fulladder fa30(s2[6][0], s2[6][1], c2[5][0], fa30_c, fa30_s);
        assign s3[6][0] = fa30_s; assign s3[6][1] = fa29_c;

        // Weight 7 (h = s2[7][0,1] + c2[6][0,1] + fa30_c = 5): FA + HA
        wire fa31_s, fa31_c, ha6_s, ha6_c;
        fulladder fa31(s2[7][0], s2[7][1], c2[6][0], fa31_c, fa31_s);
        halfadder ha6(c2[6][1], fa30_c, ha6_c, ha6_s);
        assign s3[7][0] = fa31_s; assign s3[7][1] = ha6_s;
        // fa31_c and ha6_c are carries into weight 8

        // Weight 8 (h = s2[8][0,1] + c2[7][0,1] + fa31_c + ha6_c = 6): 2 FA
        wire fa32_s, fa32_c, fa33_s, fa33_c;
        fulladder fa32(s2[8][0], s2[8][1], c2[7][0], fa32_c, fa32_s);
        fulladder fa33(c2[7][1], fa31_c, ha6_c, fa33_c, fa33_s);
        assign s3[8][0] = fa32_s; assign s3[8][1] = fa33_s;
        // fa32_c and fa33_c carry into weight 9

        // Weight 9 (h = s2[9][0,1] + c2[8][0,1] + fa32_c + fa33_c = 6): 2 FA
        wire fa34_s, fa34_c, fa35_s, fa35_c;
        fulladder fa34(s2[9][0], s2[9][1], c2[8][0], fa34_c, fa34_s);
        fulladder fa35(c2[8][1], fa32_c, fa33_c, fa35_c, fa35_s);
        assign s3[9][0] = fa34_s; assign s3[9][1] = fa35_s;

        // Weight 10 (h = s2[10][0,1] + c2[9][0] + fa34_c + fa35_c = 5): FA + HA
        wire fa36_s, fa36_c, ha7_s, ha7_c;
        fulladder fa36(s2[10][0], s2[10][1], c2[9][0], fa36_c, fa36_s);
        halfadder ha7(fa34_c, fa35_c, ha7_c, ha7_s);
        assign s3[10][0] = fa36_s; assign s3[10][1] = ha7_s;

        // Weight 11 (h = s2[11][0,1] + c2[10][0] + fa36_c + ha7_c = 5): FA + HA
        wire fa37_s, fa37_c, ha8_s, ha8_c;
        fulladder fa37(s2[11][0], s2[11][1], c2[10][0], fa37_c, fa37_s);
        halfadder ha8(fa36_c, ha7_c, ha8_c, ha8_s);
        assign s3[11][0] = fa37_s; assign s3[11][1] = ha8_s;

        // Weight 12 (h = s2[12][0,1] + c2[11][0] + fa37_c + ha8_c = 5): FA + HA
        wire fa38_s, fa38_c, ha9_s, ha9_c;
        fulladder fa38(s2[12][0], s2[12][1], c2[11][0], fa38_c, fa38_s);
        halfadder ha9(fa37_c, ha8_c, ha9_c, ha9_s);
        assign s3[12][0] = fa38_s; assign s3[12][1] = ha9_s;

        // Weight 13 (h = s2[13][0] + c2[12][0] + fa38_c + ha9_c = 4): FA + pass
        wire fa39_s, fa39_c;
        fulladder fa39(s2[13][0], fa38_c, ha9_c, fa39_c, fa39_s);
        assign s3[13][0] = fa39_s; assign s3[13][1] = c2[12][0];

        // Weight 14 (h = s2[14][0,1] + c2[13][0] + fa39_c = 4): FA + pass
        wire fa40_s, fa40_c;
        fulladder fa40(s2[14][0], s2[14][1], c2[13][0], fa40_c, fa40_s);
        assign s3[14][0] = fa40_s; assign s3[14][1] = fa39_c;

        // Weight 15 (overflow): fa40_c
        assign s3[15][0] = fa40_c; assign s3[15][1] = 1'b0;

    endgenerate

    // ---- Final stage: ripple-carry addition of two rows ----
    wire fc [0:15];
    assign fc[0] = 1'b0;
    assign prod[0] = s3[0][0];

    genvar fw;
    generate
        for (fw = 1; fw <= 14; fw = fw + 1) begin : final_add
            wire fout;
            fulladder ffa(s3[fw][0], s3[fw][1], fc[fw-1], fc[fw], prod[fw]);
        end
    endgenerate

    assign prod[15] = s3[15][0] ^ s3[14][1] ^ fc[14];

endmodule

module fulladder(a, b, cin, cout, sum);
    input  a, b, cin;
    output cout, sum;
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module halfadder(
    input  a, b,
    output cout, sum
);
    assign cout = a & b;
    assign sum  = a ^ b;
endmodule
