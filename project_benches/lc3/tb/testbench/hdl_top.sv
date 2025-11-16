//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #21ns;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1; 
    #20ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  execute_in_if  execute_env_exe_in_agent_bus(
     // pragma uvmf custom execute_env_exe_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_exe_in_agent_bus_connections end
     );
  execute_out_if  execute_env_exe_out_agent_bus(
     // pragma uvmf custom execute_env_exe_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_exe_out_agent_bus_connections end
     );
  execute_in_monitor_bfm  execute_env_exe_in_agent_mon_bfm(execute_env_exe_in_agent_bus);
  execute_out_monitor_bfm  execute_env_exe_out_agent_mon_bfm(execute_env_exe_out_agent_bus);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation

  Execute(
    .clock(clk),
    .reset(rst),
    .E_Control(execute_env_exe_in_agent_bus.E_Control),
    .bypass_alu_1(execute_env_exe_in_agent_bus.bypass_alu_1),
    .bypass_alu_2(execute_env_exe_in_agent_bus.bypass_alu_2),
    .IR(execute_env_exe_in_agent_bus.IR),
    .npc(execute_env_exe_in_agent_bus.npc),
    .W_Control_in(execute_env_exe_in_agent_bus.W_Control_in),
    .Mem_Control_in(execute_env_exe_in_agent_bus.Mem_Control_in),
    .VSR1(execute_env_exe_in_agent_bus.VSR1),
    .VSR2(execute_env_exe_in_agent_bus.VSR2),
    .enable_execute(execute_env_exe_in_agent_bus.enable_execute),
    .Mem_Bypass_Val(execute_env_exe_in_agent_bus.Mem_Bypass_Val),
    .bypass_mem_1(execute_env_exe_in_agent_bus.bypass_mem_1),
    .bypass_mem_2(execute_env_exe_in_agent_bus.bypass_mem_2),
    .W_Control_out(execute_env_exe_in_agent_bus.W_Control_out),
    .Mem_Control_out(execute_env_exe_in_agent_bus.Mem_Control_out),
    .NZP(execute_env_exe_in_agent_bus.NZP),
    .IR_Exec(execute_env_exe_in_agent_bus.IR_Exec),
    .aluout(execute_env_exe_in_agent_bus.aluout),
    .pcout(execute_env_exe_in_agent_bus.pcout),
    .sr1(execute_env_exe_in_agent_bus.sr1),
    .sr2(execute_env_exe_in_agent_bus.sr2),
    .dr(execute_env_exe_in_agent_bus.dr),
    .M_Data(execute_env_exe_in_agent_bus.M_Data)
  );

    // LC3 DUT (
    //   .clock(clk),
    //   .reset(rst),
    //   .pc(imem_resp_bus.PC),
    //   .instrmem_rd(imem_resp_bus.instrmem_rd),
    //   .Instr_dout(imem_resp_bus.Instr_dout),
    //   .Data_addr(dmem_resp_bus.Data_addr),
    //   .complete_instr(imem_resp_bus.complete_instr),
    //   .complete_data(dmem_resp_bus.complete_data),  
    //   .Data_din(dmem_resp_bus.Data_din),
    //   .Data_dout(dmem_resp_bus.Data_dout),
    //   .Data_rd(dmem_resp_bus.Data_rd)	
    // );

  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_exe_in_agent_BFM , execute_env_exe_in_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_exe_out_agent_BFM , execute_env_exe_out_agent_mon_bfm ); 
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

