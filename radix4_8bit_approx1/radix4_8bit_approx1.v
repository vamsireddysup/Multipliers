`timescale 1ns / 1ps

module radix4_8bit_approx1(
input [7:0]m,q,
output [15:0]prod
    );
    
    wire [2:0]br[3:0];
    wire [8:0]pp[3:0];
    wire [15:0]spp[3:0];
    //wire [8:0]inv_m;
    assign br[0]={q[1],q[0],1'b0};
    assign br[1]={q[3],q[2],q[1]};
    assign br[2]={q[5],q[4],q[3]};
    assign br[3]={q[7],q[6],q[5]};
    
    partial_product pp0(.m(m), .br(br[0]), .pp(pp[0]));
    partial_product pp1(.m(m), .br(br[1]), .pp(pp[1]));
    partial_product pp2(.m(m), .br(br[2]), .pp(pp[2]));
    partial_product pp3(.m(m), .br(br[3]), .pp(pp[3]));
    
    sign_extend se0(.in(pp[0]), .out(spp[0]));
    sign_extend se1(.in(pp[1]), .out(spp[1]));
    sign_extend se2(.in(pp[2]), .out(spp[2]));
    sign_extend se3(.in(pp[3]), .out(spp[3]));
    
    approx1_4x2com cm0(spp[0][0],0,0,0,0,c0,prod[0]);
    approx1_4x2com cm1(spp[0][1],0,0,0,c0,c1,prod[1]);
    approx1_4x2com cm2(spp[0][2],spp[1][0],0,0,c1,c2,prod[2]);
    approx1_4x2com cm3(spp[0][3],spp[1][1],0,0,c2,c3,prod[3]);
    approx1_4x2com cm4(spp[0][4],spp[1][2],spp[2][0],0,c3,c4,prod[4]);
    approx1_4x2com cm5(spp[0][5],spp[1][3],spp[2][1],0,c4,c5,prod[5]);
    approx1_4x2com cm6(spp[0][6],spp[1][4],spp[2][2],spp[3][0],c5,c6,prod[6]);
    approx1_4x2com cm7(spp[0][7],spp[1][5],spp[2][3],spp[3][1],c6,c7,prod[7]);
    approx1_4x2com cm8(spp[0][8],spp[1][6],spp[2][4],spp[3][2],c7,c8,prod[8]);
    approx1_4x2com cm9(spp[0][9],spp[1][7],spp[2][5],spp[3][3],c8,c9,prod[9]);
    approx1_4x2com cm10(spp[0][10],spp[1][8],spp[2][6],spp[3][4],c9,c10,prod[10]);
    approx1_4x2com cm11(spp[0][11],spp[1][9],spp[2][7],spp[3][5],c10,c11,prod[11]);
    approx1_4x2com cm12(spp[0][12],spp[1][10],spp[2][8],spp[3][6],c11,c12,prod[12]);
    approx1_4x2com cm13(spp[0][13],spp[1][11],spp[2][9],spp[3][7],c12,c13,prod[13]);
    approx1_4x2com cm14(spp[0][14],spp[1][12],spp[2][10],spp[3][8],c13,c14,prod[14]);
    approx1_4x2com cm15(spp[0][15],spp[1][13],spp[2][11],spp[3][9],c14,c15,prod[15]);

    
endmodule


module inverter(
input [7:0] a,
output [8:0] b
);
    assign b = {~a[7],~a}+1;
endmodule
module partial_product(
input [7:0]m,
input [2:0]br,
output reg [8:0]pp
);

wire [8:0]inv_m;
inverter invm1(.a(m),.b(inv_m));

always@*
begin
case(br)
    3'b001,3'b010:pp={m[7],m};
    3'b011:pp={m,1'b0};
    3'b100:pp={inv_m,1'b0};
    3'b101,3'b110:pp=inv_m;
    default:pp=0;

endcase
end

endmodule


module sign_extend(
input [8:0]in,
output reg [15:0]out

);
always@*
begin
out[15]=in[8];
out[14:0]=in[7:0];
if(in[8]==1'b1) begin
out[15:8]=8'b11111111;
end

end
endmodule


module approx1_4x2com(
input a,b,c,d,e,
output cout,
output sum
);
assign sum = (~(c&b))^a;
assign cout = e;


endmodule
