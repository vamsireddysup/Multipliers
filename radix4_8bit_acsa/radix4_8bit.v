`timescale 1ns / 1ps


module radix4_8bit(
input [7:0]m,q,
output [15:0]prod
    );
    
    reg [2:0]br[3:0];//Booth recoding
    reg [8:0]pp[3:0];//partial products
    reg [15:0]spp[3:0];//sign extended partial products
    
   mboothe m1(q[1],q[0],0,pp[0]);
    
    
endmodule
    
    
    module mboothe(
    input [2:0]b,
    input [1:0]a,
    output pp
    );
    
    assign p=b[0]^b[1];
    assign q=b[2]^a[1];
    assign r=p&q;
    assign pp=r^a[0];
    
    endmodule
