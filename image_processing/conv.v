`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2020 10:09:05 PM
// Design Name: 
// Module Name: conv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module conv(
    input        i_clk,
    input [143:0] i_pixel_data,
    input        i_pixel_data_valid,
    output reg [15:0] o_convolved_data,
    output reg   o_convolved_data_valid
);

integer i; 
reg [15:0] kernel [8:0];
wire [31:0] multData[8:0];
reg [31:0] sumDataInt;
reg [31:0] sumData;
reg multDataValid;
reg sumDataValid;


initial 
begin
    for(i=0; i<9; i=i+1) begin
        kernel[i] = 1;
    end
end    
genvar itr;
generate
    for(itr=0; itr<9; itr=itr+1) begin
        radix4_8bit_csa r4_1(kernel[itr],i_pixel_data[((16*itr)+15):16*itr],multData[itr]);
    end
endgenerate


always @(posedge i_clk) begin
    multDataValid <= i_pixel_data_valid;
end

always @(*) begin
    sumDataInt = 0;
    for(i=0; i<9; i=i+1) begin
        sumDataInt = sumDataInt + multData[i];
    end
end

always @(posedge i_clk) begin
    sumData <= sumDataInt;
    sumDataValid <= multDataValid;
    o_convolved_data <= sumData/9;
    o_convolved_data_valid <= sumDataValid;
end
    
endmodule
