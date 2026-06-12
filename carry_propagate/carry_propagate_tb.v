`timescale 1ns / 1ps

module carry_propagate_tb;

reg [3:0] a;
reg [3:0] b;
reg cin;
wire cout;
wire [3:0] s;

carry_propagate uut(a, b, cin, cout, s);

initial begin
   // Test case 1
   a = 4'b0101;
   b = 4'b0011;
   cin = 1'b0;
   #10;
   // Test case 2
   a = 4'b1111;
   b = 4'b1111;
   cin = 1'b0;
   #10;
   // Test case 3
   a = 4'b1010;
   b = 4'b0101;
   cin = 1'b1;
   #10;


end

initial begin
   $monitor("a = %b, b = %b, cin = %b, cout = %b, s = %b", a, b, cin, cout, s);
end

endmodule
