// 8-bit signed (two's complement) Baugh-Wooley multiplier
// Splits each operand into its lower 7 bits and sign bit. The inner 7x7
// grid of a[i]&b[j] terms sums normally. The sign row (a7 & b[j]) and
// sign column (a[i] & b7) are inverted and placed at bits 7-13. The
// corner term a7&b7 sits at bit 14 uninverted. A fixed correction
// constant (0x8100) compensates for the inversions. See README.md.
module baugh_wooley_multiplier_8bit(
    input  signed [7:0]  a, b,
    output signed [15:0] prod
);
    wire [7:0] au = a;
    wire [7:0] bu = b;

    // Inner 7x7 partial product grid (a[6:0] x b[6:0]), rows 0-6
    wire [15:0] pp [0:6];
    genvar i;
    generate
        for (i = 0; i < 7; i = i + 1) begin : gen_inner
            assign pp[i] = bu[i] ? ({9'b0, au[6:0]} << i) : 16'd0;
        end
    endgenerate

    // Sign row (b's sign bit times a's lower bits), inverted, bits 7-13
    wire [6:0] row7;
    generate
        for (i = 0; i < 7; i = i + 1) begin : gen_row7
            assign row7[i] = ~(au[7] & bu[i]);
        end
    endgenerate

    // Sign column (a's sign bit times b's lower bits), inverted, bits 7-13
    wire [6:0] col7;
    generate
        for (i = 0; i < 7; i = i + 1) begin : gen_col7
            assign col7[i] = ~(au[i] & bu[7]);
        end
    endgenerate

    // Corner term a7 & b7, bit 14, not inverted
    wire corner = au[7] & bu[7];

    assign prod = pp[0] + pp[1] + pp[2] + pp[3] + pp[4] + pp[5] + pp[6]
                 + {2'b0, row7,    7'b0}
                 + {2'b0, col7,    7'b0}
                 + {1'b0, corner, 14'b0}
                 + 16'h8100;

endmodule
