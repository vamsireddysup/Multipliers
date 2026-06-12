`timescale 1ns / 1ps


module radix8_8bit_structmul(
input [7:0]m,q,
output [15:0]prod
    );
    wire [3:0]br[2:0];
    wire [10:0]pp[2:0];
    wire [15:0]spp[2:0];
    
    assign br[0] = {q[2],q[1],q[0],1'b0};
    assign br[1] = {q[5],q[4],q[3],q[2]};
    assign br[2] = {q[7],q[7],q[6],q[5]};
    
    partial_product pp0(.m(m), .br(br[0]), .pp(pp[0]));
    partial_product pp1(.m(m), .br(br[1]), .pp(pp[1]));
    partial_product pp2(.m(m), .br(br[2]), .pp(pp[2]));
    
    sign_extend se0(.in(pp[0]), .out(spp[0]));
    sign_extend se1(.in(pp[1]), .out(spp[1]));
    sign_extend se2(.in(pp[2]), .out(spp[2]));
    
    csa_3op csa_0(spp[0],spp[1]<<3,spp[2]<<6,cout,prod[15:0]);
    
endmodule


module inverter(
input [7:0] a,
output [8:0] b
);
    assign b = {~a[7],~a}+1;
endmodule

module partial_product(
input [7:0]m,
input [3:0]br,
output reg [10:0]pp
);

wire [8:0]inv_m;
inverter invm1(.a(m),.b(inv_m));

always@*
begin
case(br)
    //+1
    4'b0001,4'b0010:pp={m[7],m[7],m[7],m};
    //+2
    4'b0011,4'b0100:pp={m[7],m[7],m,1'b0};
    //-2 
    4'b1011,4'b1100:pp={inv_m[8],inv_m,1'b0};
    //-1
    4'b1101,4'b1110:pp={inv_m[8],inv_m[8],inv_m};
    //+4
    4'b0111:pp={m[7],m,2'b00};
    //-4
    4'b1000:pp={inv_m,2'b00};
    //+3
    4'b0101,4'b0110:pp={m[7],m,1'b0}+{m[7],m[7],m};
    //-3
    4'b1001,4'b1010:pp=({inv_m,1'b0})+({inv_m[8],inv_m});
    //0
    default:pp=0;

endcase
end

endmodule


module sign_extend(
input [10:0]in,
output reg [15:0]out

);
always@*
begin
out[15]=in[10];
out[14:0]=in[9:0];
if(in[10]==1'b1) begin
out[15:10]=6'b111111;
end

end
endmodule

module csa_3op(
input [15:0]a,b,c,
output cout,
output [15:0]sum
//output [17:0]sum
);

wire [31:0]co;
wire [31:0]s;


fulladder fa0(a[0],b[0],c[0],co[0],s[0]);
fulladder fa1(a[1],b[1],c[1],co[1],s[1]);
fulladder fa2(a[2],b[2],c[2],co[2],s[2]);
fulladder fa3(a[3],b[3],c[3],co[3],s[3]);
fulladder fa4(a[4],b[4],c[4],co[4],s[4]);
fulladder fa5(a[5],b[5],c[5],co[5],s[5]);
fulladder fa6(a[6],b[6],c[6],co[6],s[6]);
fulladder fa7(a[7],b[7],c[7],co[7],s[7]);
fulladder fa8(a[8],b[8],c[8],co[8],s[8]);
fulladder fa9(a[9],b[9],c[9],co[9],s[9]);
fulladder fa10(a[10],b[10],c[10],co[10],s[10]);
fulladder fa11(a[11],b[11],c[11],co[11],s[11]);
fulladder fa12(a[12],b[12],c[12],co[12],s[12]);
fulladder fa13(a[13],b[13],c[13],co[13],s[13]);
fulladder fa14(a[14],b[14],c[14],co[14],s[14]);
fulladder fa15(a[15],b[15],c[15],co[15],s[15]);

fulladder fa16(co[0],s[1],0,co[16],s[16]);
fulladder fa17(co[1],s[2],co[16],co[17],s[17]);
fulladder fa18(co[2],s[3],co[17],co[18],s[18]);
fulladder fa19(co[3],s[4],co[18],co[19],s[19]);
fulladder fa20(co[4],s[5],co[19],co[20],s[20]);
fulladder fa21(co[5],s[6],co[20],co[21],s[21]);
fulladder fa22(co[6],s[7],co[21],co[22],s[22]);
fulladder fa23(co[7],s[8],co[22],co[23],s[23]);
fulladder fa24(co[8],s[9],co[23],co[24],s[24]);
fulladder fa25(co[9],s[10],co[24],co[25],s[25]);
fulladder fa26(co[10],s[11],co[25],co[26],s[26]);
fulladder fa27(co[11],s[12],co[26],co[27],s[27]);
fulladder fa28(co[12],s[13],co[27],co[28],s[28]);
fulladder fa29(co[13],s[14],co[28],co[29],s[29]);
fulladder fa30(co[14],s[15],co[29],co[30],s[30]);
fulladder fa31(co[15],0,co[30],co[31],s[31]);


assign sum[0]=s[0];
assign sum[15:1]=s[30:16];
//assign sum[17] = co[31];
assign cout = co[31];
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