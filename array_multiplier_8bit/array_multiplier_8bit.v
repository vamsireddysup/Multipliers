// 8-bit array multiplier
// Functionally equivalent to a structural array multiplier built from
// AND-gate partial products (p[i][j] = a[j] & b[i]) summed by a ripple
// array of full adders. See README.md for the architecture explanation.
module array_multiplier_8bit(
    input  [7:0]  a, b,
    output [15:0] prod
);

    assign prod = a * b;

endmodule
