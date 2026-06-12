

module imageControl(
input                    i_clk,
input                    i_rst,
input [15:0]             i_pixel_data,
input                    i_pixel_data_valid,
output reg [143:0]       o_pixel_data,
output                   o_pixel_data_valid,
output reg               o_intr
);

reg [9:0] pixelCounter;
reg [1:0] currentWrLineBuffer;
reg [3:0] lineBuffDataValid;
reg [3:0] lineBuffRdData;
reg [1:0] currentRdLineBuffer;
wire [47:0] lb0data;
wire [47:0] lb1data;
wire [47:0] lb2data;
wire [47:0] lb3data;
reg [9:0] rdCounter;
reg rd_line_buffer;
reg [11:0] totalPixelCounter;
reg rdState;

localparam IDLE = 'b0,
           RD_BUFFER = 'b1;

assign o_pixel_data_valid = rd_line_buffer;

always @(posedge i_clk)
begin
    if(i_rst)
        totalPixelCounter <= 0;
    else
    begin
        if(i_pixel_data_valid & !rd_line_buffer)
            totalPixelCounter <= totalPixelCounter + 1;
        else if(!i_pixel_data_valid & rd_line_buffer)
            totalPixelCounter <= totalPixelCounter - 1;
    end
end

always @(posedge i_clk)
begin
    if(i_rst)
    begin
        rdState <= IDLE;
        rd_line_buffer <= 1'b0;
        o_intr <= 1'b0;
    end
    else
    begin
        case(rdState)
            IDLE:begin
                o_intr <= 1'b0;
                if(totalPixelCounter >= 1536)
                begin
                    rd_line_buffer <= 1'b1;
                    rdState <= RD_BUFFER;
                end
            end
            RD_BUFFER:begin
                if(rdCounter == 511)
                begin
                    rdState <= IDLE;
                    rd_line_buffer <= 1'b0;
                    o_intr <= 1'b1;
                end
            end
        endcase
    end
end
    
always @(posedge i_clk)
begin
    if(i_rst)
        pixelCounter <= 0;
    else 
    begin
        if(i_pixel_data_valid)
            pixelCounter <= pixelCounter + 1;
    end
end


always @(posedge i_clk)
begin
    if(i_rst)
        currentWrLineBuffer <= 0;
    else
    begin
        if(pixelCounter == 511 & i_pixel_data_valid)
            currentWrLineBuffer <= currentWrLineBuffer+1;
    end
end


always @(*)
begin
    lineBuffDataValid = 4'h0;
    lineBuffDataValid[currentWrLineBuffer] = i_pixel_data_valid;
end

always @(posedge i_clk)
begin
    if(i_rst)
        rdCounter <= 0;
    else 
    begin
        if(rd_line_buffer)
            rdCounter <= rdCounter + 1;
    end
end

always @(posedge i_clk)
begin
    if(i_rst)
    begin
        currentRdLineBuffer <= 0;
    end
    else
    begin
        if(rdCounter == 511 & rd_line_buffer)
            currentRdLineBuffer <= currentRdLineBuffer + 1;
    end
end


always @(*)
begin
case(currentRdLineBuffer)
0:begin
o_pixel_data = {lb2data, lb3data, lb0data, lb1data};
lineBuffRdData = {lb2data[47:32], lb3data[15:0], lb3data[31:16], lb3data[47:32], lb0data[15:0], lb0data[31:16], lb0data[47:32], lb1data[15:0], lb1data[31:16]};
end
1:begin
o_pixel_data = {lb3data, lb0data, lb1data, lb2data};
lineBuffRdData = {lb3data[47:32], lb0data[15:0], lb0data[31:16], lb0data[47:32], lb1data[15:0], lb1data[31:16], lb1data[47:32], lb2data[15:0], lb2data[31:16]};
end
2:begin
o_pixel_data = {lb0data, lb1data, lb2data, lb3data};
lineBuffRdData = {lb0data[47:32], lb1data[15:0], lb1data[31:16], lb1data[47:32], lb2data[15:0], lb2data[31:16], lb2data[47:32], lb3data[15:0], lb3data[31:16]};
end
3:begin
o_pixel_data = {lb1data, lb2data, lb3data, lb0data};
lineBuffRdData = {lb1data[47:32], lb2data[15:0], lb2data[31:16], lb2data[47:32], lb3data[15:0], lb3data[31:16], lb3data[47:32], lb0data[15:0], lb0data[31:16]};
end
endcase
end

assign lb0data = (lineBuffDataValid[0] == 1) ? i_pixel_data : lineBuffRdData[47:0];
assign lb1data = (lineBuffDataValid[1] == 1) ? i_pixel_data : lineBuffRdData[95:48];
assign lb2data = (lineBuffDataValid[2] == 1) ? i_pixel_data : lineBuffRdData[143:96];
assign lb3data = (lineBuffDataValid[3] == 1) ? i_pixel_data : lineBuffRdData[191:144];

lineBuffer lB0(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_data(i_pixel_data),
    .i_data_valid(lineBuffDataValid[0]),
    .o_data(lb0data),
    .i_rd_data(lineBuffRdData[0])
 ); 
 
 lineBuffer lB1(
     .i_clk(i_clk),
     .i_rst(i_rst),
     .i_data(i_pixel_data),
     .i_data_valid(lineBuffDataValid[1]),
     .o_data(lb1data),
     .i_rd_data(lineBuffRdData[1])
  ); 
  
  lineBuffer lB2(
      .i_clk(i_clk),
      .i_rst(i_rst),
      .i_data(i_pixel_data),
      .i_data_valid(lineBuffDataValid[2]),
      .o_data(lb2data),
      .i_rd_data(lineBuffRdData[2])
   ); 
   
   lineBuffer lB3(
       .i_clk(i_clk),
       .i_rst(i_rst),
       .i_data(i_pixel_data),
       .i_data_valid(lineBuffDataValid[3]),
       .o_data(lb3data),
       .i_rd_data(lineBuffRdData[3])
    );   
    
    
endmodule

module imageProcessTop(
input   axi_clk,
input   axi_reset_n,
//slave interface
input   i_data_valid,
input [15:0] i_data,
output  o_data_ready,
//master interface
output  o_data_valid,
output [15:0] o_data,

input   i_data_ready,
//interrupt
output  o_intr

    );

wire [143:0] pixel_data;

wire pixel_data_valid;
wire axis_prog_full;
wire [15:0] convolved_data;

wire convolved_data_valid;

assign o_data_ready = !axis_prog_full;
    
imageControl IC(
    .i_clk(axi_clk),
    .i_rst(!axi_reset_n),
    .i_pixel_data(i_data),
    .i_pixel_data_valid(i_data_valid),
    .o_pixel_data(pixel_data),
    .o_pixel_data_valid(pixel_data_valid),
    .o_intr(o_intr)
  );    
  
 conv conv(
     .i_clk(axi_clk),
     .i_pixel_data(pixel_data),
     .i_pixel_data_valid(pixel_data_valid),
     .o_convolved_data(convolved_data),
     .o_convolved_data_valid(convolved_data_valid)
 ); 
 
outputBuffer OB (
   .wr_rst_busy(),        // output wire wr_rst_busy
   .rd_rst_busy(),        // output wire rd_rst_busy
   .s_aclk(axi_clk),                  // input wire s_aclk
   .s_aresetn(axi_reset_n),            // input wire s_aresetn
   .s_axis_tvalid(convolved_data_valid),    // input wire s_axis_tvalid
   .s_axis_tready(),    // output wire s_axis_tready
   .s_axis_tdata(convolved_data),      // input wire [15 : 0] s_axis_tdata
   .m_axis_tvalid(o_data_valid),    // output wire m_axis_tvalid
   .m_axis_tready(i_data_ready),    // input wire m_axis_tready
   .m_axis_tdata(o_data),      // output wire [15 : 0] m_axis_tdata
   .axis_prog_full(axis_prog_full)  // output wire axis_prog_full
 );
   
endmodule



module conv(
    input        i_clk,
    input [143:0] i_pixel_data,
    input        i_pixel_data_valid,
    output reg [15:0] o_convolved_data,
    output reg   o_convolved_data_valid
);

integer i; 
reg [15:0] kernel [8:0];
reg [31:0] multData[8:0];
reg [31:0] sumDataInt;
reg [31:0] sumData;
reg multDataValid;
reg sumDataValid;

initial
begin
    for(i=0;i<9;i=i+1)
    begin
        kernel[i] = 16'h0001;
    end
end    
    
always @(posedge i_clk)
begin
    for(i=0;i<9;i=i+1)
    begin
        multData[i] <= kernel[i]*i_pixel_data[i*16+:16];
    end
    multDataValid <= i_pixel_data_valid;
end

always @(*)
begin
    sumDataInt = 32'h0;
    for(i=0;i<9;i=i+1)
    begin
        sumDataInt = sumDataInt + multData[i];
    end
end

always @(posedge i_clk)
begin
    sumData <= sumDataInt;
    sumDataValid <= multDataValid;
end
    
always @(posedge i_clk)
begin
    o_convolved_data <= sumData/9;
    o_convolved_data_valid <= sumDataValid;
end

endmodule


module lineBuffer(
input   i_clk,
input   i_rst,
input [15:0] i_data,
input   i_data_valid,
output [47:0] o_data,
input i_rd_data
);

reg [15:0] line [511:0]; //line buffer
reg [9:0] wrPntr;
reg [9:0] rdPntr;


always @(posedge i_clk)
begin
    if(i_data_valid)
        line[wrPntr] <= i_data;
end

always @(posedge i_clk)
begin
    if(i_rst)
        wrPntr <= 'd0;
    else if(i_data_valid)
        wrPntr <= wrPntr + 'd1;
end

assign o_data = {line[rdPntr], line[rdPntr+1], line[rdPntr+2]};
    
always @(posedge i_clk)
begin
    if(i_rst)
        rdPntr <= 10'd0;
    else if(i_rd_data)
        rdPntr <= rdPntr + 10'd1;
end



endmodule