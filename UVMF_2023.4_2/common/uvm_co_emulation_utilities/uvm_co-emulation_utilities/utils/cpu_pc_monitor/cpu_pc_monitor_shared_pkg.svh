//---------------------------------------------------------------------------
// Package shared between the HVL and XRTL
//---------------------------------------------------------------------------
`ifndef CPU_PC_MONITOR_SHARED_PKG_SV
`define CPU_PC_MONITOR_SHARED_PKG_SV
`include "cpu_pc_monitor_defines.svh"

package cpu_pc_monitor_shared_pkg;
typedef struct packed {
  bit valid;    // valid bit
  bit [31:0] pc_trigger; } packed_pc_trigger_s;

   typedef bit[$bits(packed_pc_trigger_s)-1 : 0] packed_pc_trigger_t;

   typedef packed_pc_trigger_t [`CPU_PC_NUMBER_OF_TRIGGERS] packed_pc_trigger_buf_t;

typedef struct packed {
  bit [31:0] r1;
  bit [31:0] r2;
  bit [31:0] r3;
  bit [31:0] r4;
  bit [31:0] r5;
  bit [`CPU_PC_COUNTER_SIZE-1:0] clock_count;
  bit [31:0] pc; } packed_pc_monitor_s;

   typedef bit[$bits(packed_pc_monitor_s)-1 : 0] packed_pc_monitor_t;

endpackage : cpu_pc_monitor_shared_pkg
`endif // CPU_PC_MONITOR_SHARED_PKG_SV
