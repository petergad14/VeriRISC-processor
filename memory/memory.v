`default_nettype none
module memory #(
    parameter addr_width = 5, parameter data_width = 8
) (
    input wire clk, wr, rd,
    input wire [addr_width-1 : 0] addr,
    inout wire [data_width-1 : 0] data
);
    reg [data_width-1 : 0] mem_arr [0:2**addr_width-1];
    reg [data_width-1 : 0] data_temp;
    
    always @(posedge clk)begin
      if ( wr ) mem_arr[addr] = data;
    end
    assign data = rd ? mem_arr[addr] : 'bz;
endmodule
