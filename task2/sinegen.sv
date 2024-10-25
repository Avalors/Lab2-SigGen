module sinegen #(
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
)(
    input logic     clk,
    input logic     rst,
    input logic     en,
    input logic[A_WIDTH-1:0]    phase,
    input logic [A_WIDTH-1:0]   incr,
    output logic [D_WIDTH-1:0]  dout1,  dout2
);

logic [A_WIDTH-1:0] address;

counter #(A_WIDTH) addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (address)
);

rom #(A_WIDTH,D_WIDTH) sineRom (
    .clk (clk),
    .addr1 (address),
    .addr2 (address + phase),
    .dout1 (dout1),
    .dout2 (dout2)
);
endmodule