
module shift_and_add_multiplier_8bit(
input [7:0]x,y,
output [15:0]prod
    );
    reg [8:0]a=9'b000000000;
    reg [8:0]temp_a;
    reg [7:0]x11,y11;
    reg [7:0]x1,y1;
    
always@(x,y)
begin
assign x11=x;
assign y11=y;
  case(y[0])
  1'b1:
           begin
            
            assign temp_a = a+x11;
            assign a=temp_a;
            assign y1=y11>>1;
            assign y11=y1;
            assign y11[7]=a[0];
            assign temp_a=a>>1;
            assign a=temp_a;
            
            assign y[0]=y11[0];
            end
    1'b0:
            begin
            assign temp_a=a;
            assign a=temp_a;
            assign y1=y11>>1;
            assign y11=y1;
            assign y11[7]=a[0];
            assign temp_a=a>>1;
            assign a=temp_a;
	    assign y[0]=y11[0];
            end
            
endcase 
end
    assign prod[7:0]=y11[7:0];
    assign prod[15:8]=a[7:0];
endmodule


/*
module fulladder(a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;

    wire x, y, z;

    assign x = a ^ b;
    assign y = a & b;
    assign sum = x ^ cin;
    assign z = x & cin;
    assign cout = z | y;
endmodule

module halfadder(
input a,b,
output cout,sum
);
assign cout = a&b;
assign sum = a^b;
endmodule
*/