module array_multiplier #(parameter N = 8) (
input  logic [N-1:0] a,
input  logic [N-1:0] b,
output logic [2*N-1:0] prod
);
// Partial products generation
logic [2*N-1:0] pp [N-1:0];
genvar i;
generate
 for (i=0; i<N; i=i+1) begin : gen_pp
  // Duplicate and shift
  assign pp[i] = {{(N){1'b0}}, a & {N{b[i]}}} << i;
 end
endgenerate
// sum of all partial products
always_comb begin
 prod = '0;
 for (int k=0; k<N; k=k+1)
  prod += pp[k];
end
endmodule

