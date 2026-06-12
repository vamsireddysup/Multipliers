
module carry_skip_adder_8bit(
input [7:0]a,b,
input cin,
output cout,
output [7:0]sum
    );
wire c1,c2,c3,c4,c5,c6,c7,c8,s;
wire p0,p1,p2,p3,p4,p5,p6,p7; 
fulladder f1(a[0],b[0],cin,c1,sum[0]);
fulladder f2(a[1],b[1],c1,c2,sum[1]);
fulladder f3(a[2],b[2],c2,c3,sum[2]);
fulladder f4(a[3],b[3],c3,c4,sum[3]);
fulladder f5(a[4],b[5],c4,c5,sum[4]);
fulladder f6(a[5],b[5],c5,c6,sum[5]);
fulladder f7(a[6],b[6],c6,c7,sum[6]);
fulladder f8(a[7],b[7],c7,c8,sum[7]);

assign p0=a[0]^b[0];
assign p1=a[1]^b[1];
assign p2=a[2]^b[2];
assign p3=a[3]^b[3];
assign p4=a[4]^b[4];
assign p5=a[5]^b[5];
assign p6=a[6]^b[6];
assign p7=a[7]^b[7];

assign s=(p0&p1)&(p2&p3)&(p4&p5)&(p6&p7);
mux_2x1 m1(cin,c8,s,cout);
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
assign y = (s) ? a:b;
endmodule
