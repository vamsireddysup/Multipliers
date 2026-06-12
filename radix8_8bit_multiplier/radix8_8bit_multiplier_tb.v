`timescale 1ns / 1ps

module radix8_8bit_multiplier_tb;

reg [7:0]m;
reg [7:0]q;
wire [15:0]prod;
//reg clk;
radix8_8bit_multiplier uut(m,q,prod);
initial begin
//TC 1
    m=8'b10110110;
    q=8'b01101011;
    end
    

initial begin
   $monitor("m = %b, q = %b, prod = %b", m, q, prod );
end

endmodule
