module carry_select_adder_8bit_uniform(
input [7:0]a,b,
input cin,
output cout,
output [7:0]sum
);

wire co,c0;
carry_select_adder cs1(a[3:0],b[3:0],cin,co,sum[3:0]);
carry_select_adder cs2(a[7:4],b[7:4],co,cout,sum[7:4]);
//carry_select_adder cs1([3:0]a,[3:0]b,1,co,[3:0]sum);
//carry_select_adder cs2([7:4]a,[7:4]b,co,c0,[7:4]sum);
endmodule


module carry_select_adder(
input [3:0]a,b,
input cin,
output cout,
output [3:0]sum
    );
wire c0,c1;
wire [3:0]s0,s1;
rca r1(a,b,0,c0,s0);
rca r2(a,b,1,c1,s1);
//mux_2x1 m1(s0,s1,cin,sum);
mux_2x1 m2(c0,c1,cin,cout);
assign sum = (cin == 1'b0) ? s0 : s1;
//if(cin==0)
//assign sum = s0;
//else
//assign sum = s1;

endmodule

module rca(a,b,cin,cout,s);
    input [3:0] a, b;
    input cin;
    output cout;
    output [3:0]s;
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

module mux_2x1(input a, b, sel, 
output out
);
    assign out = (sel == 1'b0) ? a : b;
endmodule
