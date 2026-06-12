module radix4_8bit_multiplier(
input [7:0]m,q,
output [15:0]prod
);
    reg [2:0]br[3:0];//Booth recoding
    reg [9:0]pp[3:0];//partial products
    reg [15:0]spp[3:0];//sign extended partial products
    reg [15:0]prod1;//temp product
    integer i,j;
    wire [8:0]inv_m;//inverter of multiplicand with one bit extended
    assign inv_m={~m[7],~m}+1;
    
    always@(m or q or inv_m)
    begin
    br[0]={q[1],q[0],1'b0};
    for(i=1;i<4;i=i+1)
    br[i] ={q[2*i+1],q[2*i],q[2*i-1]};
    for(i=0;i<4;i=i+1)
    begin
    case(br[i])
    3'b001,3'b010:pp[i]={m[7],m[7],m};
    3'b011:pp[i]={m[7],m,1'b0};
    3'b100:pp[i]={inv_m,1'b0};
    3'b101,3'b110:pp[i]={inv_m[8],inv_m};
    default:pp[i]=0;
    endcase
    spp[i]=$signed(pp[i]);
    for(j=0;j<i;j=j+1)
    spp[i]={spp[i],2'b00};
    end
    prod1=spp[0];
    for(i=1;i<4;i=i+1)begin
    prod1=prod1+spp[i];
    end
    end
    assign prod = prod1;
endmodule