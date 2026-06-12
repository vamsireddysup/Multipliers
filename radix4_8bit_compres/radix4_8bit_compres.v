`timescale 1ns / 1ps

module radix4_8bit_compres(
input [7:0]m,q,
output [15:0]prod
    );
    
    wire [2:0]br[3:0];
    wire [9:0]pp[3:0];
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
    
    compres cm0(spp[0][0],0,0,0,0,co0,cr0,s0);
    compres cm1(spp[0][1],0,0,0,co0,co1,cr1,s1);
    compres cm2(spp[0][2],spp[1][0],0,0,co1,co2,cr2,s2);
    compres cm3(spp[0][3],spp[1][1],0,0,co2,co3,cr3,s3);
    compres cm4(spp[0][4],spp[1][2],spp[2][0],0,co3,co4,cr4,s4);
    compres cm5(spp[0][5],spp[1][3],spp[2][1],0,co4,co5,cr5,s5);
    compres cm6(spp[0][6],spp[1][4],spp[2][2],spp[3][0],co5,co6,cr6,s6);
    compres cm7(spp[0][7],spp[1][5],spp[2][3],spp[3][1],co6,co7,cr7,s7);
    compres cm8(spp[0][8],spp[1][6],spp[2][4],spp[3][2],co7,co8,cr8,s8);
    compres cm9(spp[0][9],spp[1][7],spp[2][5],spp[3][3],co8,co9,cr9,s9);
    compres cm10(spp[0][10],spp[1][8],spp[2][6],spp[3][4],co9,co10,cr10,s10);
    compres cm11(spp[0][11],spp[1][9],spp[2][7],spp[3][5],co10,co11,cr11,s11);
    compres cm12(spp[0][12],spp[1][10],spp[2][8],spp[3][6],co11,co12,cr12,s12);
    compres cm13(spp[0][13],spp[1][11],spp[2][9],spp[3][7],co12,co13,cr13,s13);
    compres cm14(spp[0][14],spp[1][12],spp[2][10],spp[3][8],co13,co14,cr14,s14);
    compres cm15(spp[0][15],spp[1][13],spp[2][11],spp[3][9],co14,co15,cr15,s15);
    //stage 2
    halfadder   h0(s1,cr0,co16,s16);
    fulladder   f0(s2,cr1,co16,co17,s17);
    fulladder   f1(s3,cr2,co17,co18,s18);
    fulladder   f2(s4,cr3,co18,co19,s19);
    fulladder   f3(s5,cr4,co19,co20,s20);
    fulladder   f4(s6,cr5,co20,co21,s21);
    fulladder   f5(s7,cr6,co21,co22,s22);
    fulladder   f6(s8,cr7,co22,co23,s23);
    fulladder   f7(s9,cr8,co23,co24,s24);
    fulladder   f8(s10,cr9,co24,co25,s25);
    fulladder   f9(s11,cr10,co25,co26,s26);
    fulladder   f10(s12,cr11,co26,co27,s27);
    fulladder   f11(s13,cr12,co27,co28,s28);
    fulladder   f12(s14,cr13,co28,co29,s29);
    fulladder   f13(s15,cr14,co29,co30,s30);
   
    assign prod[0] = s0;
    assign prod[1] = s16;
    assign prod[2] = s17;
    assign prod[3] = s18;
    assign prod[4] = s19;
    assign prod[5] = s20;
    assign prod[6] = s21;
    assign prod[7] = s22;
    assign prod[8] = s23;
    assign prod[9] = s24;
    assign prod[10] = s25;
    assign prod[11] = s26;
    assign prod[12] = s27;
    assign prod[13] = s28;
    assign prod[14] = s29;
    assign prod[15] = s30;
    
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
output reg [9:0]pp
);

wire [8:0]inv_m;
inverter invm1(.a(m),.b(inv_m));

always@*
begin
case(br)
    3'b001,3'b010:pp={m[7],m[7],m};
    3'b011:pp={m[7],m,1'b0};
    3'b100:pp={inv_m,1'b0};
    3'b101,3'b110:pp={inv_m[8],inv_m};
    default:pp=0;

endcase
end

endmodule


module sign_extend(
input [9:0]in,
output reg [15:0]out

);
always@*
begin
out[15]=in[9];
out[14:0]=in[8:0];
if(in[9]==1'b1) begin
out[15:9]=7'b1111111;
end

end
endmodule


module compres(
input a,b,c,d,
input cin,
output cout,
output carry, sum
);
wire int_sum;
fulladder fa1(.a(a), .b(b), .cin(c), .cout(cout), .sum(int_sum));
fulladder fa2(.a(int_sum), .b(d), .cin(cin), .cout(carry), .sum(sum));

endmodule
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
assign sum = a^b;
assign cout = a&b;
endmodule

