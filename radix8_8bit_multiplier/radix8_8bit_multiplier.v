module radix8_8bit_multiplier(
input [7:0]m,q,
output [15:0]prod
);
    reg [3:0]br[2:0];//Booth recoding
    reg [10:0]pp[2:0];//partial products
    reg [15:0]spp[2:0];//sign extended partial products
    reg [15:0]prod1;//temp product
    integer i,j;
    wire [8:0]inv_m;//inverter of multiplicand with one bit extended
    assign inv_m={~m[7],~m}+1;
    
    always@(m or q or inv_m)
    begin
    br[0]={q[2],q[1],q[0],1'b0};
    br[1]={q[5],q[4],q[3],q[2]};
    br[2]={q[7],q[7],q[6],q[5]};
    //for(i=2;i<4;i=i+1)
    //br[i-1] ={q[2*i+1],q[2*i],q[2*i-1],q[2*i-2]};
    for(i=0;i<3;i=i+1)
    begin
    case(br[i])
    //+1
    4'b0001,4'b0010:pp[i]={m[7],m[7],m[7],m};
    //+2
    4'b0011,4'b0100:pp[i]={m[7],m[7],m,1'b0};
    //-2 
    4'b1011,4'b1100:pp[i]={inv_m[8],inv_m,1'b0};
    //-1
    4'b1101,4'b1110:pp[i]={inv_m[8],inv_m[8],inv_m};
    //+4
    4'b0111:pp[i]={m,2'b00};
    //-4
    4'b1000:pp[i]={inv_m,2'b00};
    //+3
    4'b0101,4'b0110:pp[i]={m[7],m,1'b0}+{m[7],m[7],m};
    //-3
    4'b1001,4'b1010:pp[i]=({inv_m,1'b0})+({inv_m[8],inv_m});
    //0
    default:pp[i]=0;
    endcase
    spp[i]=$signed(pp[i]);
    for(j=0;j<i;j=j+1)
    spp[i]={spp[i],3'b0};
    end
    prod1=spp[0];
    for(i=1;i<3;i=i+1)begin
    prod1=prod1+spp[i];
    end
    end
    assign prod = prod1;
endmodule
