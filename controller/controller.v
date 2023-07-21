`default_nettype none
module controller (
    input wire zero, clk, rst,
    input wire [2:0] opcode, phase,
    output wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e
);
    reg [8:0] cont_out;
    reg HALT, ALUOP, JMP, STO, SKZ;
    assign {sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e} = cont_out;
    always@(*)begin
      HALT = (opcode == 0);
      SKZ = (opcode == 1);
      ALUOP = (opcode == 2 || opcode == 3 || opcode == 4 || opcode == 5);
      STO = (opcode == 6);
      JMP = (opcode == 7);
    end
    always@(*)begin
      if(rst)begin
        cont_out = 9'b1000_00000; //INST_ADDR
      end
      else begin
          case(phase)
            0: cont_out = 9'b1000_00000; //INST_ADDR
            1: cont_out = 9'b1100_00000; //INST_FETCH
            2: cont_out = 9'b1110_00000; //INST_LOAD
            3: cont_out = 9'b1110_00000; //IDLE
            4: cont_out = {3'b000, HALT, 5'b10000}; //OP_ADDR
            5: cont_out = {1'b0, ALUOP, 7'b000_0000}; //OP_FETCH
            6: cont_out = {1'b0, ALUOP, 2'b00, SKZ&zero, 1'b0, JMP, 1'b0, STO}; //ALU_OP
            7: cont_out = {1'b0, ALUOP, 3'b000, ALUOP, JMP, STO, STO}; //STORE
          endcase
      end
    end
endmodule
