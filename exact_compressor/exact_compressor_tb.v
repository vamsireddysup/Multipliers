`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2023 09:43:09
// Design Name: 
// Module Name: exact_compressor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module exact_compressor_tb;
reg a,b,c,d,cin;
wire cout,carry,sum;
reg clk;
exact_compressor  dut(.a(a), .b(b), .c(c), .d(d), .cin(cin), .cout(cout), .carry(carry), .sum (sum));

initial begin 
a=0;
b=0;
c=0;
d=0;
cin=0;
clk =0;
#5
forever #5 clk=~clk;
end
always@(posedge clk)
begin
a=0;
b=0;
c=0;
d=0;
cin=0;
#5
a=0;
b=0;
c=0;
d=0;
cin=1;
#5
a=0;
b=0;
c=0;
d=1;
cin=0;
#5
a=0;
b=0;
c=0;
d=1;
cin=1;
#5
a=0;
b=0;
c=1;
d=0;
cin=0;
#5
a=0;
b=0;
c=1;
d=0;
cin=1;
#5
a=0;
b=0;
c=1;
d=1;
cin=0;
#5
a=0;
b=0;
c=1;
d=1;
cin=1;
#5
a=0;
b=1;
c=0;
d=0;
cin=0;
#5
a=0;
b=1;
c=0;
d=0;
cin=0;
#5
a=0;
b=1;
c=0;
d=0;
cin=1;
#5
a=0;
b=1;
c=0;
d=1;
cin=0;
#5
a=0;
b=1;
c=0;
d=1;
cin=1;
#5
a=0;
b=1;
c=1;
d=0;
cin=0;
#5
a=0;
b=1;
c=1;
d=0;
cin=1;
#5
a=0;
b=1;
c=1;
d=1;
cin=0;
#5
a=0;
b=1;
c=1;
d=1;
cin=1;
#5
a=1;
b=0;
c=0;
d=0;
cin=0;
#5
a=1;
b=0;
c=0;
d=0;
cin=1;
#5
a=1;
b=0;
c=0;
d=1;
cin=0;
#5
a=1;
b=0;
c=0;
d=1;
cin=1;
#5
a=1;
b=0;
c=1;
d=0;
cin=0;
#5
a=1;
b=0;
c=1;
d=0;
cin=1;
#5
a=1;
b=0;
c=1;
d=1;
cin=0;
#5
a=1;
b=0;
c=1;
d=1;
cin=1;
#5
a=1;
b=1;
c=0;
d=0;
cin=0;
#5
a=1;
b=1;
c=0;
d=0;
cin=0;
#5
a=1;
b=1;
c=0;
d=0;
cin=1;
#5
a=1;
b=1;
c=0;
d=1;
cin=0;
#5
a=1;
b=1;
c=0;
d=1;
cin=1;
#5
a=1;
b=1;
c=1;
d=0;
cin=0;
#5
a=1;
b=1;
c=1;
d=0;
cin=1;
#5
a=1;
b=1;
c=1;
d=1;
cin=0;
#5
a=1;
b=1;
c=1;
d=1;
cin=1;
#5


#1000
$finish;

end
endmodule
