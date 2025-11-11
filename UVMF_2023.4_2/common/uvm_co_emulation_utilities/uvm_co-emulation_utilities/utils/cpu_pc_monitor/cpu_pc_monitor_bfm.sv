//---------------------------------------------------------------------------
// Track cpu PC and send PC and registers to HVL when pattern match occurs
//---------------------------------------------------------------------------
`include "cpu_pc_monitor_defines.svh"
interface cpu_pc_monitor_bfm #(int unsigned NUMBER_OF_TRIGGERS=1) (
input clock,
input reset_l,
//	Connect to appropriate signals for PC and GPR
input [31:0] r1_in,
input [31:0] r2_in,
input [31:0] r3_in,
input [31:0] r4_in,
input [31:0] r5_in,
input [31:0] pc_in);
// pragma attribute cpu_pc_monitor_bfm partition_interface_xif

//---------------------------------------------------------------------------
// Declarations
//---------------------------------------------------------------------------

import cpu_pc_monitor_shared_pkg::*;

cpu_pc_monitor_pkg::cpu_pc_monitor_proxy #(NUMBER_OF_TRIGGERS) proxy;

bit [`CPU_PC_COUNTER_SIZE-1:0] pc_clock_counter;
bit [`CPU_PC_COUNTER_SIZE-1:0] pc_clock_counter_r1;

bit [31:0] r1_r1;
bit [31:0] r2_r1;
bit [31:0] r3_r1;
bit [31:0] r4_r1;
bit [31:0] r5_r1;
bit [31:0] pc_r1;

bit [31:0] pc_triggers [NUMBER_OF_TRIGGERS];
bit [NUMBER_OF_TRIGGERS-1:0] triggers_valid;
bit [NUMBER_OF_TRIGGERS-1:0] triggers_mask;
bit [NUMBER_OF_TRIGGERS-1:0] new_valid;
bit [31:0] pc_reg;
int unsigned ti;
event new_triggers;
bit wr_new_triggers;

initial
  forever begin
    @new_triggers;
    @(posedge clock);
      wr_new_triggers = 1'b1;
    @(posedge clock);
      wr_new_triggers = 1'b0;
  end

//---------------------------------------------------------------------------
// Tasks to talk to the proxy
//---------------------------------------------------------------------------
// Set trigger values and enables
function void set_pc_triggers(packed_pc_trigger_buf_t triggers_to_find ); // pragma tbx xtf
  int unsigned ti;
  packed_pc_trigger_s new_trigger;

  for(ti=0;ti<`CPU_PC_NUMBER_OF_TRIGGERS;ti++) begin
    new_trigger = triggers_to_find[ti];
    pc_triggers[ti] = new_trigger.pc_trigger;
    new_valid[ti] = new_trigger.valid;
    //$display("pc_trigger[%0d] = %0h", ti, pc_triggers[ti]);
    -> new_triggers;
  end
endfunction

//---------------------------------------------------------------------------
// PC counter and other logic
//---------------------------------------------------------------------------

always @(posedge clock or negedge reset_l) begin
  if(!reset_l) begin
    pc_clock_counter <= 'b0;
  end else begin
    pc_clock_counter <= pc_clock_counter + 1;
  end
end

// get valid bits to local clock domain
always @(posedge clock) begin
  if(wr_new_triggers == 1'b1) begin
    triggers_valid <= new_valid;
  end else begin
    triggers_valid <= triggers_valid & triggers_mask;
  end
end

// Register signals
always @(posedge clock) begin
  r1_r1 <= r1_in;
  r2_r1 <= r2_in;
  r3_r1 <= r3_in;
  r4_r1 <= r4_in;
  r5_r1 <= r5_in;
  pc_r1 <= pc_in;
  pc_clock_counter_r1 <= pc_clock_counter;
end

//---------------------------------------------------------------------------
// Check incoming signals against pattern and send to proxy
//---------------------------------------------------------------------------
// Check incoming PC for trigger
always @(posedge clock) begin
  for(ti=0;ti<`CPU_PC_NUMBER_OF_TRIGGERS;ti++) begin
      //$display("pc_in = %0h",pc_in);
    if(triggers_mask[ti] && triggers_valid[ti] && (pc_r1 == pc_triggers[ti])) begin
      triggers_mask[ti] <= 1'b0;
      pack_and_send();
    end else begin
      triggers_mask[ti] <= 1'b1;
    end
  end
end

function void pack_and_send();
  packed_pc_monitor_s packed_regs;
  packed_pc_monitor_t regs_packet;

  packed_regs.pc = pc_r1;
  packed_regs.r1 = r1_r1;
  packed_regs.r2 = r2_r1;
  packed_regs.r3 = r3_r1;
  packed_regs.r4 = r4_r1;
  packed_regs.r5 = r5_r1;
  packed_regs.clock_count = pc_clock_counter_r1;

  // Note cast
  regs_packet = packed_regs;
  proxy.write(regs_packet);

endfunction

endinterface
