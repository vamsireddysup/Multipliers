module kogge_stone_adder_8bit(
input [7:0]a,b,
input cin,
output cout,
output [8:0]sum
//output [7:0]sum
    );
    
    wire [24:0]p,g;
    wire [7:0]c;
    
    assign p[7:0] = a^b;
    assign g[7:0] = a&b;
    
    assign p[8] = p[1]&p[0];
    assign g[8] = (p[1]&g[0])|g[1];
    
    assign p[9] = p[2]&p[1];
    assign g[9] = (p[2]&g[1])|g[2];
    
    assign p[10] = p[3]&p[2];
    assign g[10] = (p[3]&g[2])|g[3];
    
    assign p[11] = p[4]&p[3];
    assign g[11] = (p[4]&g[3])|g[4];
    
    assign p[12] = p[5]&p[4];
    assign g[12] = (p[5]&g[4])|g[5];
    
    assign p[13] = p[6]&p[5];
    assign g[13] = (p[6]&g[5])|g[6];
    
    assign p[14] = p[7]&p[6];
    assign g[14] = (p[7]&g[6])|g[7];
    
    assign p[15] = p[9]&p[0];
    assign g[15] = (p[9]&g[0])|g[9];
    
    assign p[16] = p[10]&p[8];
    assign g[16] = (p[10]&g[8])|g[10];
    
    assign p[17] = p[11]&p[9];
    assign g[17] = (p[11]&g[9])|g[11];
    
    assign p[18] = p[12]&p[10];
    assign g[18] = (p[12]&g[10])|g[12];
    
    assign p[19] = p[13]&p[11];
    assign g[19] = (p[13]&g[11])|g[13];
    
    assign p[20] = p[14]&p[12];
    assign g[20] = (p[14]&g[12])|g[14];
    
    assign p[21] = p[17]&p[0];
    assign g[21] = (p[17]&g[0])|g[17];
    
    assign p[22] = p[18]&p[8];
    assign g[22] = (p[18]&g[8])|g[18];
    
    assign p[23] = p[19]&p[15];
    assign g[23] = (p[19]&g[15])|g[19];
    
    assign p[24] = p[20]&p[16];
    assign g[24] = (p[20]&g[16])|g[20];
    
    assign c[0] = g[0];
    assign sum[0] = p[0]^cin;
    
    assign c[1] = g[8];
    assign sum[1] = p[1]^c[0];
    
    assign c[2] = g[15];
    assign sum[2] = p[2]^c[1];
    
    assign c[3] = g[16];
    assign sum[3] = p[3]^c[2];
    
    assign c[4] = g[21];
    assign sum[4] = p[4]^c[3];
    
    assign c[5] = g[22];
    assign sum[5] = p[5]^c[4];
    
    assign c[6] = g[23];
    assign sum[6] = p[6]^c[5];
    
    assign c[7] = g[24];
    assign sum[7] = p[7]^c[6];
    
    assign sum[8] = c[7];
    
    assign cout = c[7];
endmodule
