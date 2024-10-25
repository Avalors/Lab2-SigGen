module sigdelay #(
    parameter A_WIDTH = 9, D_WIDTH = 8  
)(
    input logic clk,
    input logic rst,
    input logic wr,
    input logic rd,
    input logic [D_WIDTH-1:0] mic_signal,
    input logic [A_WIDTH-1:0] offset,
    output logic [D_WIDTH-1:0] delayed_signal
);

logic [A_WIDTH-1:0] address;
logic [A_WIDTH-1:0] rd_addr;

assign rd_addr = (address >= offset) ? address - offset : (address + (2 ** A_WIDTH)) - offset; 
//performs wrap around logic 


counter #(A_WIDTH) addrCounter(
    .clk (clk),
    .rst (rst),
    .count (address)
);

ram2ports #(A_WIDTH,D_WIDTH) ram(
    .clk (clk),
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr(address),
    .rd_addr(rd_addr),
    .din (mic_signal),
    .dout (delayed_signal)
);



endmodule
