module rca(a,b,cin,cout,s);
    input [3:0] a, b;
    input cin;
    output cout;
    output [3:0] s;
    wire c0, c1, c2;

    fulladder f1(a[0], b[0], cin, c0, s[0]);
    fulladder f2(a[1], b[1], c0, c1, s[1]);
    fulladder f3(a[2], b[2], c1, c2, s[2]);
    fulladder f4(a[3], b[3], c2, cout, s[3]);
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
