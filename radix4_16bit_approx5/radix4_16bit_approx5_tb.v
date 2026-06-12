`timescale 1ns / 1ps
module radix4_16bit_approx5_tb;
reg clk;
reg signed [15:0]m;
reg signed [15:0]q;
wire [31:0]prod;
reg signed [31:0] data[9999:0];

integer i;
integer input_a;
integer input_b;
integer file_ld;
initial begin
clk=0;
forever 
#5 clk=~clk;
end

initial begin
input_a = $fopen("input_a.txt","r");
input_b = $fopen("input_b.txt","r");
file_ld = $fopen("approx5_out.txt","w");
m=0;
q=0;
#10;
end
always@(posedge clk) begin


for(i=0;i<10000;i=i+1) begin

$fscanf(input_a,"%d",m);
$fscanf(input_b,"%d",q);
#10;
m<=$signed(m);
q<=$signed(q);
#10;
data[i] <= prod;
#10;
$fwrite(file_ld,"%d\n",data[i]);


#10
$display("Read input_a: %d",m);
$display("Read input_b: %d",q);
$display("Output: %d:",data[i]);
#10;

end
end
initial begin
#500000;
 $fclose(input_a);
 $fclose(input_b);
 #10;
 $fclose(file_ld);
 
$finish;

end
radix4_16bit_approx5 dut(.m(m),.q(q),.prod(prod));
endmodule
