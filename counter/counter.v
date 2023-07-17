`default_nettype none

module counter #(
    parameter width = 3
) (
    input wire clk, rst, load, enab,
    input wire [width-1 : 0] cnt_in,
    output reg [width-1 : 0] cnt_out
);
always @(posedge clk) begin
    if(rst)
        cnt_out = 0;
    else begin
      if(load)
        cnt_out = cnt_in;
      else begin
        if(enab)
            cnt_out = cnt_out + 1;
      end
    end
end
    
endmodule
