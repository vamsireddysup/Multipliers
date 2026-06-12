`timescale 1ns / 1ps

module ma_x_fa(
input a,b,cin,
output cout,sum
    );
  /*
    wire p,q,r;
    assign p=a^b;
    assign sum=p^cin;
    assign q=a&b;
    assign r=p&cin;
    assign cout=q|r;
    */
    assign cout=(a&b)|(b&cin)|(cin&a);
    assign m1=(a&b)|(b&(~cin))|((~cin)&a);
    assign sum=((~cout)&m1)|(m1&cin)|(cin&(~cout));
endmodule
