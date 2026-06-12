
module brent_kung_adder_8bit(
input [7:0]a,b,
input cin,
output cout,
//output [7:0]sum
output [8:0]sum
    );
    
    wire [18:0]p,g;
    wire [7:0]c;
    assign p[0] = a[0]^b[0];
    assign g[0] = a[0]&b[0];
    assign p[1] = a[1]^b[1];
    assign g[1] = a[1]&b[1];
    assign p[2] = a[2]^b[2];
    assign g[2] = a[2]&b[2];
    assign p[3] = a[3]^b[3];
    assign g[3] = a[3]&b[3];
    assign p[4] = a[4]^b[4];
    assign g[4] = a[4]&b[4];
    assign p[5] = a[5]^b[5];
    assign g[5] = a[5]&b[5];
    assign p[6] = a[6]^b[6];
    assign g[6] = a[6]&b[6];
    assign p[7] = a[7]^b[7];
    assign g[7] = a[7]&b[7];
    assign p[8] = p[1]&p[0];
    assign g[8] = (p[1]&g[0])|g[1];
    assign p[9] = p[3]&p[2];
    assign g[9] = (p[3]&g[2])|g[3];
    assign p[10] = p[5]&p[4];
    assign g[10] = (p[5]&g[4])|g[5];
    assign p[11] = p[7]&p[6];
    assign g[11] = (p[7]&g[6])|g[7];
    assign p[12] = p[9]&p[8];
    assign g[12] = (p[9]&g[8])|g[9];
    assign p[13] = p[11]&p[10];
    assign g[13] = (p[11]&g[10])|g[11];
    assign p[14] = p[13]&p[12];
    assign g[14] = (p[13]&g[12])|g[13];
    assign p[15] = p[10]&p[12];
    assign g[15] = (p[10]&g[12])|g[10];
    assign p[16] = p[2]&p[8];
    assign g[16] = (p[2]&g[8])|g[2];
    assign p[17] = p[4]&p[12];
    assign g[17] = (p[4]&g[12])|g[4];
    assign p[18] = p[6]&p[15];
    assign g[18] = (p[6]&g[15])|g[6];
    
    assign c[0] = g[0];
    assign sum[0] = p[0]^cin;
    
    assign c[1] = g[8];
    assign sum[1] = p[1]^c[0];
    
    assign c[2] = g[16];
    assign sum[2] = p[2]^c[1];
    
    assign c[3] = g[12];
    assign sum[3] = p[3]^c[2];
    
    assign c[4] = g[17];
    assign sum[4] = p[4]^c[3];
    
    assign c[5] = g[15];
    assign sum[5] = p[5]^c[4];
    
    assign c[6] = g[18];
    assign sum[6] = p[6]^c[5];
    
    assign c[7] = g[14];
    assign sum[7] = p[7]^c[6];
    
    assign cout = c[7];
    assign sum[8] = c[7];
    
    
    
    
endmodule
