class signal_test extends base_test;

  `uvm_component_utils(signal_test)

  function new(string name = "signal_test", uvm_component parent = null);
    super.new(name, parent);
    report_id = name;
  endfunction : new

  function void build_phase(uvm_phase phase);
    clock_period[0] = 4000;
    clock_period[1] = 3000;
    clock_period[2] = 5000;

    super.build_phase(phase);
    
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    fork
      signal_monitor_test(0); // signal monitor connected to clock 0
      cpu_pc_monitor_test(0); // signal monitor connected to clock 0
    join
    clk_ctrl[0].wait_clocks(20);
      
    phase.drop_objection(this);
  endtask : run_phase

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
  endfunction : report_phase

  task signal_monitor_test(int num);
    bit timeout = 0;
    bit [shared_params_pkg::CLK_COUNTER_SIZE-1:0] pattern_find;
    bit [shared_params_pkg::CLK_COUNTER_SIZE-1:0] signals_found;
    bit pattern_found;

    reset_ctrl[num].wait_reset_deassertion();
    `uvm_info(report_id, $sformatf("sync reset %0d deasserted", num), UVM_LOW)
    
    clk_ctrl[num].wait_clocks(10);
    // Enable the signal monitor and set the timeout
    clk0_monitor_proxy.monitor_control(1'b1,100); //enable, timeout count

    // Set wait for pattern
    pattern_find = 'h123;
    fork
      begin
        // pattern to find, count, pattern_found
        clk0_monitor_proxy.wait_for_signal_pattern(pattern_find,1,pattern_found,signals_found);
        if(pattern_found) begin
          if(pattern_find != signals_found) begin
            `uvm_error(report_id, $sformatf("signal find pattern mismatch expected %0h found %0h", pattern_find,signals_found));
          end
        end else begin
          `uvm_error(report_id, $sformatf("signal find pattern timeout did not find %0h", pattern_find));
        end
      end
      begin
        clk_ctrl[num].wait_clocks(1000);
        timeout = 1;
      end
    join_any
    if(timeout == 1'b1) begin
      `uvm_error(report_id, $sformatf("signal find pattern %0h timeout", num));
    end

  endtask
  
  task cpu_pc_monitor_test(int num);
    bit timeout = 0;
    packed_pc_trigger_s triggers[`CPU_PC_NUMBER_OF_TRIGGERS];
    packed_pc_trigger_t trigger_packed;
    packed_pc_trigger_buf_t triggers_packet;
    packed_pc_monitor_s trigger_found;

    int ii;

    reset_ctrl[num].wait_reset_deassertion();
    `uvm_info(report_id, $sformatf("sync reset %0d deasserted", num), UVM_LOW)
  
    // setup PC trigger
    for(ii=0;ii<`CPU_PC_NUMBER_OF_TRIGGERS;ii++) begin
      if(ii<2) begin
        triggers[ii].valid = 1'b1;
      end else begin
        triggers[ii].valid = 1'b0;
      end
      triggers[ii].pc_trigger = 10 + (ii * 10);
      //implicit cast
      trigger_packed = triggers[ii];
      triggers_packet[ii] = trigger_packed;
    end
    cpu_pc_monitor.set_bfm_pc_triggers(triggers_packet);

    // Drive some signals -> CPU R0
    fork
      begin
        clk_ctrl[num].wait_clocks(25);
        cpu_r1_driver_proxy.set_signals_to_drive(32'hdeadbeef);
        clk_ctrl[num].wait_clocks(50);
        cpu_r1_driver_proxy.set_signals_to_drive(32'ha5a5c3c3);
      end
      begin
        cpu_pc_monitor.wait_for_pc_trigger(trigger_found);
        if(trigger_found.pc !=  triggers[0].pc_trigger) begin
          `uvm_error(report_id, $sformatf("PC trigger expected %0d found %0d", triggers[0].pc_trigger,trigger_found.pc));
        end
        if(trigger_found.r1 != 32'hdeadbeef) begin
          `uvm_error(report_id, $sformatf("PC R1 expected deadbeef found %0h", trigger_found.r1));
        end
        cpu_pc_monitor.wait_for_pc_trigger(trigger_found);
        if(trigger_found.pc !=  triggers[1].pc_trigger) begin
          `uvm_error(report_id, $sformatf("PC trigger expected %0d found %0d", triggers[1].pc_trigger,trigger_found.pc));
        end
        if(trigger_found.r1 != 32'ha5a5c3c3) begin
          `uvm_error(report_id, $sformatf("PC R1 expected a5a5c3c3 found %0h", trigger_found.r1));
        end
      end
    join

  endtask
endclass : signal_test
