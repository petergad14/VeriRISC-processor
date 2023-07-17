module mux5#(
    parameter width = 5
    )
    (
    input wire [width-1 : 0] in0, in1,
    input wire sel,
    output reg [width-1 : 0] mux_out
    );
    always@(*) begin
        if(sel)
            mux_out = in1;
        else
            mux_out = in0;
    end
endmodule
