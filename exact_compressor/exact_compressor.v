module exact_compressor(
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