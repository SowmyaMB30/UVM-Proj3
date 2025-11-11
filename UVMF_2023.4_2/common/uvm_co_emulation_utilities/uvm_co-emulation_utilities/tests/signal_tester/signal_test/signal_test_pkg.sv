package signal_test_pkg;
  import uvm_pkg::*;
  import clock_pkg::*;
  import reset_pkg::*;
  import signal_driver_pkg::*;
  import signal_monitor_pkg::*;
  import cpu_pc_monitor_pkg::*;
  import cpu_pc_monitor_shared_pkg::*;

`include "uvm_macros.svh"
  
  timeunit 1ps;
  timeprecision 1ps;

`include "base_test.svh"
`include "signal_test.svh"
  
endpackage : signal_test_pkg
