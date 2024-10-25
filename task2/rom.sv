module rom #(
    parameter   ADDRESS_WIDTH = 8,
                DATA_WIDTH = 8
)(
    //ports (interface signals for rom module)
    input logic     clk,
    input logic[ADDRESS_WIDTH-1:0]  addr1, addr2,
    output logic[DATA_WIDTH-1:0]    dout1, dout2
);

//internal ROM array 
logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];


//initializes rom by loading with values stored in sinerom.mem
initial begin
    $display("Loading rom.");
    $readmemh("sinerom.mem", rom_array);
end;


always_ff @(posedge clk) begin
    //synchronous output
    dout1 <= rom_array[addr1]; //non-blocking assignment
    dout2 <= rom_array[addr2];
    end
    
endmodule
