`timescale 1ns / 1ps

`timescale 1ns / 1ps

module radix8_32bit_multiplier(
input [31:0]m,q,
output [63:0]prod
);
    reg [3:0]br[10:0];//Booth recoding
    reg [33:0]pp[10:0];//partial products
    reg [63:0]spp[10:0];//sign extended partial products
    reg [63:0]prod1;//temp product
    integer i,j;
    wire [31:0]inv_m;//inverter of multiplicand with one bit extended
    assign inv_m=~m+1;
    
    always@(m or q or inv_m)
    begin
    br[0]={q[2],q[1],q[0],1'b0};
    br[10]={q[31],q[31],q[30],q[29]};
    for(i=1;i<10;i=i+1)
    br[i] ={q[3*i+2],q[3*i+1],q[3*i],q[3*i-1]};
    for(i=0;i<11;i=i+1)
    begin
    case(br[i])
    //+1
    4'b0001,4'b0010:pp[i]={m[31],m[31],m};
    //+2
    4'b0011,4'b0100:pp[i]={m[31],m,1'b0};
    //-2 
    4'b1011,4'b1100:pp[i]={inv_m[31],inv_m,1'b0};
    //-1
    4'b1101,4'b1110:pp[i]={inv_m[31],inv_m[31],inv_m};
    //+4
    4'b0111:pp[i]={m,2'b00};
    //-4
    4'b1000:pp[i]={inv_m,2'b00};
    //+3
    4'b0101,4'b0110:pp[i]={m,1'b0}+{m[31],m};
    //-3
    4'b1001,4'b1010:pp[i]=({inv_m,1'b0})+({inv_m[31],inv_m});
    //0
    default:pp[i]=0;
    endcase
    spp[i]=$signed(pp[i]);
    for(j=0;j<i;j=j+1)
    spp[i]={spp[i],3'b0};
    end
    prod1=spp[0];
    for(i=1;i<11;i=i+1)begin
    prod1=prod1+spp[i];
    end
    end
    assign prod = prod1;
endmodule

