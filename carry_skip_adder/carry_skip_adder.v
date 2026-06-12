module carry_skip_adder(
input [3:0]a,b,
input cin,
output cout,
output [3:0]sum
    );
    wire c1,c2,c3,c4,p0,p1,p2,p3,s;
fulladder f1(a[0],b[0],cin,c1,sum[0]);
fulladder f2(a[1],b[1],c1,c2,sum[1]);
fulladder f3(a[2],b[2],c2,c3,sum[2]);
fulladder f4(a[3],b[3],c3,c4,sum[3]);

assign p0=a[0]^b[0];
assign p1=a[1]^b[1];
assign p2=a[2]^b[2];
assign p3=a[3]^b[3];
assign s=(p0&p1)&(p2&p3);
mux_2x1 m1(cin,c4,s,cout);
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

module mux_2x1(
input a,b,s,
output y
);
assign y = (s) ? b:a;
endmodule
