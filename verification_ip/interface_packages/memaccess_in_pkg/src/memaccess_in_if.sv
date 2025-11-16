//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the memaccess_in interface signals.
//      It is instantiated once per memaccess_in bus.  Bus Functional Models, 
//      BFM's named memaccess_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named memaccess_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(memaccess_in_bus.M_Data), // Agent output 
// .dut_signal_port(memaccess_in_bus.M_Addr), // Agent output 
// .dut_signal_port(memaccess_in_bus.M_Control), // Agent output 
// .dut_signal_port(memaccess_in_bus.mem_state), // Agent output 
// .dut_signal_port(memaccess_in_bus.DMem_dout), // Agent output 

import uvmf_base_pkg_hdl::*;
import memaccess_in_pkg_hdl::*;

interface  memaccess_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [15:0] M_Data,
  inout tri [15:0] M_Addr,
  inout tri  M_Control,
  inout tri [1:0] mem_state,
  inout tri [15:0] DMem_dout
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input M_Data,
  input M_Addr,
  input M_Control,
  input mem_state,
  input DMem_dout
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output M_Data,
  output M_Addr,
  output M_Control,
  output mem_state,
  output DMem_dout
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input M_Data,
  input M_Addr,
  input M_Control,
  input mem_state,
  input DMem_dout
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

