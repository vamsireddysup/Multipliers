`timescale 1ns / 1ps
//Approximate Majority Logic Adder 1
//Approximation is done at C which is negated

module amla(
input a,b,c,
output cout,sum
    );
    assign cout=(a&b)|(b&c)|(c&a);
    assign sum=(a&b)|(b&(~c))|((~c)&a);
endmodule
