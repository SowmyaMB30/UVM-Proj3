//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the fetch_in interface signals.
//      It is instantiated once per fetch_in bus.  Bus Functional Models, 
//      BFM's named fetch_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named fetch_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(fetch_in_bus.br_taken), // Agent output 
// .dut_signal_port(fetch_in_bus.taddr), // Agent output 
// .dut_signal_port(fetch_in_bus.enable_fetch), // Agent output 
// .dut_signal_port(fetch_in_bus.enable_updatePC), // Agent output 

import uvmf_base_pkg_hdl::*;
import fetch_in_pkg_hdl::*;

interface  fetch_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri  br_taken,
  inout tri [15:0] taddr,
  inout tri  enable_fetch,
  inout tri  enable_updatePC
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input br_taken,
  input taddr,
  input enable_fetch,
  input enable_updatePC
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output br_taken,
  output taddr,
  output enable_fetch,
  output enable_updatePC
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input br_taken,
  input taddr,
  input enable_fetch,
  input enable_updatePC
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

