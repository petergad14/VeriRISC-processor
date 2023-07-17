`default_nettype none
`timescale 1ns/1ps

module ALU #(
    parameter width = 8
) (
    input wire [width-1: 0] in_a, in_b,
    input wire [2:0] op_code,
    output reg [width-1 : 0] alu_out,
    output reg a_is_zero
);

always@(*) begin
        case(op_code)
            0: alu_out = in_a;
            1: alu_out = in_a;
            2: alu_out = in_a + in_b;
            3: alu_out = in_a & in_b;
            4: alu_out = in_a ^ in_b;
            5: alu_out = in_b;
            6: alu_out = in_a;
            7: alu_out = in_a;
            default: alu_out = 'z;
        endcase
        if(alu_out == 0)
            a_is_zero = 1;
        else
            a_is_zero = 0;
    end
endmodule


module ALU_tb();
localparam width = 8;
localparam PASS0=0, PASS1=1, ADD=2, AND=3, XOR=4, PASSB=5, PASS6=6, PASS7=7;
reg [width-1:0] a_tb, b_tb;
wire [width-1 : 0] out_tb;
reg [2:0] op_code_tb;
wire zero;
ALU a1(a_tb, b_tb, op_code_tb, out_tb, zero);
initial begin
    op_code_tb=PASS0; a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=PASS1; a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=ADD;   a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=AND;   a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=XOR;   a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=PASSB; a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=PASS6; a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=PASS7; a_tb=8'h42; b_tb=8'h86; #1;
    op_code_tb=PASS7; a_tb=8'h00; b_tb=8'h86; #1;
    $stop;
end
endmodule
