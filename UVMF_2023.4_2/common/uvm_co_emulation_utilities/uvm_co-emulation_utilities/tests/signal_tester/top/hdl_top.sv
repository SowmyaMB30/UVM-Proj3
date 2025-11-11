`include "cpu_pc_monitor_defines.svh"

module hdl_top();
  // pragma attribute hdl_top partition_module_xrtl

  import shared_params_pkg::*;
  
  // Wires
  logic [NUM_CLK_RSTS-1:0] clks;
  logic [NUM_CLK_RSTS-1:0] rst_n;
  logic [NUM_CLK_RSTS-1:0] async_rst;
  
  // Declare the pin interfaces
  genvar                   ii;
  for (ii = 0; ii < NUM_CLK_RSTS; ii++) begin : clk_rst_block
    clock_bfm #(shared_params_pkg::CLK_INIT_HALF_PERIOD_IN_PS,
                shared_params_pkg::CLK_PHASE_OFFSET_IN_PS) clk_if_h(clks[ii]);
    sync_reset_bfm #(shared_params_pkg::RST_POLARITY) rst_if_h(clks[ii],
                                                               rst_n[ii]);
    async_reset_bfm #(shared_params_pkg::ASYNC_RST_POLARITY,
                      shared_params_pkg::ASYNC_INIT_IDLE_TIME_IN_PS * (ii+1),
                      shared_params_pkg::ASYNC_RST_ACTIVE_IN_PS * (ii+1)
                      ) async_rst_if_h(clks[ii], async_rst[ii]);

    initial begin //tbx vif_binding_block
      import uvm_pkg::uvm_config_db;
      uvm_config_db #(virtual clock_bfm #(shared_params_pkg::CLK_INIT_HALF_PERIOD_IN_PS, shared_params_pkg::CLK_PHASE_OFFSET_IN_PS))::set(null, "", $psprintf("clk%0d_if_h", ii), clk_if_h);
      uvm_config_db #(virtual sync_reset_bfm #(shared_params_pkg::RST_POLARITY))::set(null, "", $psprintf("rst%0d_if_h", ii), rst_if_h);
      uvm_config_db #(virtual async_reset_bfm #(
                         shared_params_pkg::ASYNC_RST_POLARITY,
                         shared_params_pkg::ASYNC_INIT_IDLE_TIME_IN_PS * (ii+1),
                         shared_params_pkg::ASYNC_RST_ACTIVE_IN_PS * (ii+1)
                                                ))::set(null, "", $psprintf("async_rst%0d_if_h", ii), async_rst_if_h);
    end 
  end
  
//------------------------------------------------------------------
// Signal driver and monitor BFMs
//------------------------------------------------------------------
// Generic counter
bit [shared_params_pkg::CLK_COUNTER_SIZE-1:0] clock_counter;
bit [31:0] cpu_pc;
bit [31:0] cpu_r1;
bit [31:0] cpu_r2;
bit [31:0] cpu_r3;
bit [31:0] cpu_r4;
bit [31:0] cpu_r5;

always @(posedge clks[0] or negedge rst_n[0]) begin
  if(!rst_n[0]) begin
    clock_counter <= 0;
    cpu_pc <= 0;
  end else begin
    clock_counter <= clock_counter + 1;
    if(clock_counter[1:0] == 2'b0) begin
      cpu_pc <= cpu_pc + 1;
    end
  end
end

// Note that SIGNAL_DRIVER_SIZE is set to match the size of cpu_r1 which is fixed in this example
signal_driver_bfm  #(.SIGNAL_SIZE(shared_params_pkg::SIGNAL_DRIVER_SIZE)) cpu_r1_driver(
  .clock(clks[0] ),
  .signals_out(cpu_r1 )
);

signal_monitor_bfm  #(.SIGNAL_SIZE(shared_params_pkg::CLK_COUNTER_SIZE),
                      .BUFFER_SIZE(shared_params_pkg::CLK_MONITOR_BUF_SIZE)) clk0_count_monitor (
  .clock(clks[0] ),
  .signals_in(clock_counter )
);

cpu_pc_monitor_bfm #(`CPU_PC_NUMBER_OF_TRIGGERS) cpu_pc_monitor(
  .clock(clks[0] ),
  .reset_l(rst_n[0] ),
  .r1_in(cpu_r1 ),
  .r2_in(cpu_r2 ),
  .r3_in(cpu_r3 ),
  .r4_in(cpu_r4 ),
  .r5_in(cpu_r5 ),
  .pc_in(cpu_pc )
);

initial begin //tbx vif_binding_block
  import uvm_pkg::uvm_config_db;
  uvm_config_db #(virtual signal_monitor_bfm #(
                     shared_params_pkg::CLK_COUNTER_SIZE,
                     shared_params_pkg::CLK_MONITOR_BUF_SIZE))::set(null, "", "clk0_count_monitor", clk0_count_monitor);
  uvm_config_db #(virtual signal_driver_bfm #(shared_params_pkg::SIGNAL_DRIVER_SIZE))::set(null,"","cpu_r1_driver",cpu_r1_driver);
  uvm_config_db #(virtual cpu_pc_monitor_bfm #(`CPU_PC_NUMBER_OF_TRIGGERS))::set(null, "", "cpu_pc_monitor", cpu_pc_monitor);
end

endmodule : hdl_top
