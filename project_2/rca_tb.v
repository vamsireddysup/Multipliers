`timescale 1ns / 1ps

module rca_tb();

reg [3:0] a;
reg [3:0] b;
reg cin;
wire cout;
wire [3:0] s;

rca uut (a,b,cin,cout,s);

initial begin
   // Initialize input values
   a = 4'b0101;
   b = 4'b0011;
   cin = 1'b0;

   // Wait for some time to observe the output
   #50;
   $finish;
end

endmodule
