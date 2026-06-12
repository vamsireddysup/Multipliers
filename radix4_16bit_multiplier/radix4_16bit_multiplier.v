`timescale 1ns / 1ps

module radix4_16bit_multiplier(
input [15:0]m,q,
output [31:0]prod
);
    reg [2:0]br[7:0];//Booth recoding
    reg [17:0]pp[7:0];//partial products
    reg [31:0]spp[7:0];//sign extended partial products
    reg [31:0]prod1;//temp product
    integer i,j;
    wire [16:0]inv_m;//inverter of multiplicand with one bit extended
    assign inv_m={~m[15],~m}+1;
    
    always@(m or q or inv_m)
    begin
    br[0]={q[1],q[0],1'b0};
    for(i=1;i<8;i=i+1)
    br[i] ={q[2*i+1],q[2*i],q[2*i-1]};
    for(i=0;i<8;i=i+1)
    begin
    case(br[i])
    3'b001,3'b010:pp[i]={m[15],m[15],m};
    3'b011:pp[i]={m[15],m,1'b0};
    3'b100:pp[i]={inv_m,1'b0};
    3'b101,3'b110:pp[i]={inv_m[16],inv_m};
    default:pp[i]=0;
    endcase
    spp[i]=$signed(pp[i]);
    for(j=0;j<i;j=j+1)
    spp[i]={spp[i],2'b00};
    end
    prod1=spp[0];
    for(i=1;i<8;i=i+1)begin
    prod1=prod1+spp[i];
    end
    end
    assign prod = prod1;
endmodule
