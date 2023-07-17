`default_nettype none

module register #(
    parameter width = 8
) (
    input wire [width-1 : 0] data_in,
    input wire load, clk, rst,
    output reg [width-1 : 0] data_out
);

    always@(posedge clk)begin
        if(rst)begin
          data_out <= 0;
        end
        else begin
            if(load)
                data_out <= data_in;
        end
    
    end
    
endmodule
