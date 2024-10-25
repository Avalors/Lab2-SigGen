module rom #(
    parameter   ADDRESS_WIDTH = 8,
                DATA_WIDTH = 8
)(
    //ports (interface signals for rom module)
    input logic     clk,
    input logic[ADDRESS_WIDTH-1:0]  addr,
    output logic[DATA_WIDTH-1:0]    dout
);

//internal ROM array 
logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];


//initializes rom by loading with values stored in sinerom.mem
initial begin
    $display("Loading rom.");
    $readmemh("sinerom.mem", rom_array);
end;


always_ff @(posedge clk)
    //synchronous output
    dout <= rom_array[addr]; //non-blocking assignment

endmodule
