module radix8_8bit_csa(
input [7:0]m,q,
output [15:0]prod
);
    reg [3:0]br[2:0];//Booth recoding
    reg [10:0]pp[2:0];//partial products
    reg [15:0]spp[2:0];//sign extended partial products
    //reg [15:0]prod1;//temp product
    integer i,j;
    
    wire [16:0]prod1;
    wire cout;
    
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
    4'b0111:pp[i]={m[7],m,2'b00};
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
    //prod1=spp[0];
    //for(i=1;i<3;i=i+1)begin
    //prod1=prod1+spp[i];
    //end
    end
    //assign prod = prod1;
    csa_3op csa_0(spp[0],spp[1],spp[2],cout,prod1);
    assign prod=prod1[15:0];
endmodule







module csa_3op(
input [15:0]a,b,c,
output cout,
output [16:0]sum
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
assign sum[16:1]=s[31:16];
//assign sum[17] = co[31];
assign cout = co[31];
endmodule



module fulladder(
input a,b,cin,
output cout,
output sum
);

assign s1=a^b;
assign c1=a&b;
assign sum=s1^cin;
assign cout = c1|(s1&cin);


endmodule
