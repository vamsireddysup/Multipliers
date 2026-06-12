`timescale 1ns / 1ps
module radix4_8bit_acsa_tb;

reg signed [7:0]m;
reg signed [7:0]q;
reg [15:0]exact[0:99];
reg [15:0]error_distance[0:99];
wire [15:0]prod;
reg signed [7:0]m1[0:99];
reg signed [7:0]q1[0:99];
//integer file_id;
radix4_8bit_acsa uut(.m(m),.q(q),.prod(prod));



integer i;
initial begin 
repeat(99) begin
for(i=0;i<100;i=i+1)begin 
m1[i]=$random;
q1[i]=$random;

end
end
for (i=0;i<100;i=i+1) begin
      exact[i]=m1[i]*q1[i];
      
end
for (i=0;i<100;i=i+1)
begin 
      assign m=m1[i];
      assign q=q1[i];
error_distance[i] =  $signed(exact[i]) - $signed(prod[i]);
 $display("Error: m1 = %d, q1 = %d, exact = %d, error_distance = %d",m1[i], q1[i], exact[i],error_distance[i]);
end
end
//initial begin
//file_id = $fopen("C:\\Users\\Vamsi\\Xilinx Projects\\ACSA1\\text.txt","w");

//for(i=0;i<100;i=i+1) begin


    `
//$fwrite(file_id,"%d\n",m1[i]);
//$display("%d",m1[i]);
//end
//end
endmodule