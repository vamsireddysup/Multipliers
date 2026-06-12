module radix4struct(
input [3:0] m, q,
output [7:0] prod
);


wire [2:0]br[1:0];
wire [4:0]pp[1:0];
wire [7:0]spp[1:0];


    assign br[0]={q[1],q[0],1'b0};
	assign br[1]={q[3],q[2],q[1]};
// Submodules

partial_product_gen ppgen0(.m(m), .br(br[0]), .pp(pp[0]));
partial_product_gen ppgen1(.m(m), .br(br[1]), .pp(pp[1]));
sign_extend se0(.in(pp[0]), .out(spp[0]));
sign_extend se1(.in(pp[1]), .out(spp[1]));
adder adder0(.a(spp[0]), .b({spp[1], 2'b00}), .sum(prod));

endmodule

module inverter(
input [3:0] a,
output [4:0] b
);
    assign b = {~a[3],~a}+1;
endmodule


module partial_product_gen(
input [3:0] m,
input [2:0] br,
output reg [4:0] pp
);
wire [4:0]inv_m;
inverter invm1(m,inv_m);
always @(*) begin
case (br)
3'b001, 3'b010: pp = {m[3], m};
3'b011: pp = {m, 1'b0};
3'b100: pp = {inv_m[3:0], 1'b0};
3'b101, 3'b110: pp = inv_m[4:0];
default: pp = 0;
endcase
end
endmodule

module sign_extend(
input [4:0] in,
output reg [7:0] out
);
always @(*) begin
out[7] = in[4];
out[6:0] = in[3:0];
if (in[4] == 1'b1) begin
out[7:4] = 4'b1111;
end
end
endmodule

module adder(
input [7:0] a,
input [7:0] b,
output reg [8:0] sum
);
always @(*) begin
sum = a + b;
end
endmodule