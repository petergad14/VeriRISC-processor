`default_nettype none

module tri_state #(
    parameter width = 8
    )
    (
    input wire [width - 1:0] data_in,
    input wire data_en,
    output reg [width - 1:0] data_out
    );
    always@(*) begin
    if(data_en)
        data_out = data_in;
    else
        data_out = 8'bzzzz_zzzz;
    end
    
endmodule
