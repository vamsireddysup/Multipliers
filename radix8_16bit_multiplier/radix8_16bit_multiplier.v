`timescale 1ns / 1ps

module radix8_16bit_multiplier(
input [15:0]m,q,
output [31:0]prod
);
    reg [3:0]br[5:0];//Booth recoding
    reg [17:0]pp[5:0];//partial products
    reg [31:0]spp[5:0];//sign extended partial products
    reg [31:0]prod1;//temp product
    integer i,j;
    wire [15:0]inv_m;//inverter of multiplicand with one bit extended
    assign inv_m=~m+1;
    
    always@(m or q or inv_m)
    begin
    br[0]={q[2],q[1],q[0],1'b0};
    br[1]={q[5],q[4],q[3],q[2]};
    br[2]={q[8],q[7],q[6],q[5]};
    br[3]={q[11],q[10],q[9],q[8]};
    br[4]={q[14],q[13],q[12],q[11]};
    br[5]={q[15],q[15],q[15],q[14]};
    //for(i=2;i<7;i=i+1)
    //br[i-1] ={q[2*i+1],q[2*i],q[2*i-1],q[2*i-2]};
    for(i=0;i<6;i=i+1)
    begin
    case(br[i])
    //+1
    4'b0001,4'b0010:pp[i]={m[15],m[15],m};
    //+2
    4'b0011,4'b0100:pp[i]={m[15],m,1'b0};
    //-2 
    4'b1011,4'b1100:pp[i]={inv_m[15],inv_m,1'b0};
    //-1
    4'b1101,4'b1110:pp[i]={inv_m[15],inv_m[15],inv_m};
    //+4
    4'b0111:pp[i]={m,2'b00};
    //-4
    4'b1000:pp[i]={inv_m,2'b00};
    //+3
    4'b0101,4'b0110:pp[i]={m,1'b0}+{m[15],m};
    //-3
    4'b1001,4'b1010:pp[i]=({inv_m,1'b0})+({inv_m[15],inv_m});
    //0
    default:pp[i]=0;
    endcase
    spp[i]=$signed(pp[i]);
    for(j=0;j<i;j=j+1)
    spp[i]={spp[i],3'b0};
    end
    prod1=spp[0];
    for(i=1;i<6;i=i+1)begin
    prod1=prod1+spp[i];
    end
    end
    assign prod = prod1;
endmodule
