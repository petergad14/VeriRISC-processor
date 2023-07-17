`default_nettype none
`include "ALU.v"
`include "controller.v"
`include "Counter.v"
`include "memory.v"
`include "mux_lab.v"
`include "register.v"
`include "tristate.v"


module Top (
  input wire clk, rst,
  output wire halt
);
  localparam AWIDTH = 5, DWIDTH = 8;
  wire [2:0] phase, opcode;
  wire [DWIDTH-1:0] ac_out, alu_out, data;
  wire [AWIDTH-1 : 0] ir_addr, pc_addr, addr;
  wire ld_pc, inc_pc, zero, ld_ir, ld_ac, data_e, wr, rd, sel;


  counter#(.width ( 3 )) counter_clk
   ( 
    .clk      ( clk ),
    .rst      ( rst ),
    .load     ( 1'b0 ),
    .enab     ( !halt ),
    .cnt_in   ( 3'b0 ),
    .cnt_out  ( phase ) 
   );


  counter#(.width ( AWIDTH )) counter_pc
   ( 
    .clk      ( clk ),
    .rst      ( rst ),
    .load     ( ld_pc ),
    .enab     ( inc_pc ),
    .cnt_in   ( ir_addr ),
    .cnt_out  ( pc_addr ) 
   );


  ALU#(.width ( DWIDTH )) alu_inst
   (
    .op_code   ( opcode ),
    .in_a      ( ac_out ),
    .in_b      ( data ),
    .a_is_zero ( zero ),
    .alu_out   ( alu_out ) 
   );

  register#(.width ( DWIDTH )) register_ir
   ( 
    .clk      ( clk ),
    .rst      ( rst ),
    .load     ( ld_ir ),
    .data_in  ( data  ),
    .data_out ( {opcode, ir_addr}) 
   );


  register#(.width ( DWIDTH )) register_ac
   ( 
    .clk      ( clk ),
    .rst      ( rst ),
    .load     ( ld_ac ),
    .data_in  ( alu_out  ),
    .data_out ( ac_out ) 
   ); 

  multiplexor#(.WIDTH ( AWIDTH ) )
  address_mux
  (
    .sel     ( sel ),
    .in0     ( ir_addr ),
    .in1     ( pc_addr ),
    .mux_out ( addr ) 
  ); 

  tri_state #(.width( DWIDTH))
    driver_inst
   (
    .data_en  ( data_e  ),
    .data_in  ( alu_out ),
    .data_out ( data  ) 
   ) ;


  memory#(.addr_width ( AWIDTH ),.data_width ( DWIDTH )) memory_inst
   (
    .clk    ( clk ),
    .wr     ( wr ),
    .rd     ( rd ),
    .addr   ( addr ),
    .data   ( data ) 
   ) ; 



  controller controller_inst
  (
    .opcode ( opcode ),
    .phase  ( phase ),
    .zero   ( zero ),
    .sel    ( sel ),
    .rd     ( rd ),
    .ld_ir  ( ld_ir ), 
    .inc_pc ( inc_pc ),
    .halt   ( halt ),
    .ld_pc  ( ld_pc ),
    .data_e ( data_e ),
    .ld_ac  ( ld_ac ),
    .wr     ( wr ),
    .clk    ( clk ),
    .rst    ( rst ) 
  );

   
endmodule
