
module carry_propagate(
input [3:0]a,b,
input cin,
output cout,
output [3:0]s
    );
    wire p0,p1,p2,p3;
    wire g0,g1,g2,g3;
    wire c0,c1,c2,c3;
    
    //carry propagation
    assign p0 = a[0]^b[0];
    assign p1 = a[1]^b[1];
    assign p2 = a[2]^b[2];
    assign p3 = a[3]^b[3];
    //carry generations
    assign g0 = a[0]&b[0];
    assign g1 = a[1]&b[1];
    assign g2 = a[2]&b[2];
    assign g3 = a[3]&b[3];
    //carry declaration
    assign c0 = g0|(p0&cin);
    assign c1 = g1|(p1&c0);
    assign c2 = g2|(p2&c1);
    assign c3 = g3|(p3&c2);
    
    assign cout = c3;
    assign s[0] = p0^cin;
    assign s[1] = p1^c0;
    assign s[2] = p2^c1;
    assign s[3] = p3^c2;
    
endmodule
