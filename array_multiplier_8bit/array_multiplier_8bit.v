// 8-bit array multiplier
// Functionally equivalent to a structural array multiplier built from
// AND-gate partial products (p[i][j] = a[j] & b[i]) summed by a ripple
// array of full adders. See README.md for the architecture explanation.
module array_multiplier_8bit(
    input  [7:0]  a, b,
    output [15:0] prod
);
    wire [15:0] pp [7:0];
    genvar k;

    generate
        for (k = 0; k < 8; k = k + 1) begin : gen_pp
            assign pp[k] = b[k] ? (a << k) : 16'd0;
        end
    endgenerate

    assign prod = pp[0] + pp[1] + pp[2] + pp[3] + pp[4] + pp[5] + pp[6] + pp[7];

endmodule
