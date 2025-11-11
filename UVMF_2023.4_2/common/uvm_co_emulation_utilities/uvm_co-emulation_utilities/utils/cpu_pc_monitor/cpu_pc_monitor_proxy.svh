class cpu_pc_monitor_proxy #(int unsigned NUMBER_OF_TRIGGERS=1) extends uvm_object;

  `uvm_object_param_utils(cpu_pc_monitor_proxy #(NUMBER_OF_TRIGGERS))

  // Local buffer holding signals;
  packed_pc_monitor_s packed_registers;

  event found_trigger;

  // Virtual Interface
  //bfm is local because we must set the proxy handle for proper operation
  local virtual cpu_pc_monitor_bfm #(NUMBER_OF_TRIGGERS) bfm;

  function new(string name = "cpu_pc_monitor_proxy");
    super.new(name);
  endfunction : new

  //---------------------------------------------------------------------------
  // BFM Accessors Code
  //---------------------------------------------------------------------------
  
  virtual function void set_bfm(virtual cpu_pc_monitor_bfm #(NUMBER_OF_TRIGGERS) sbfm);
    bfm = sbfm;
    bfm.proxy = this;
  endfunction : set_bfm;

  virtual function virtual cpu_pc_monitor_bfm #(NUMBER_OF_TRIGGERS) get_bfm();
    return bfm;
  endfunction : get_bfm

  virtual function void set_bfm_pc_triggers (packed_pc_trigger_buf_t pc_triggers_to_find);
    bfm.set_pc_triggers(pc_triggers_to_find);
  endfunction : set_bfm_pc_triggers

  virtual task wait_for_pc_trigger(output packed_pc_monitor_s pc_registers);
    @found_trigger;
    pc_registers = packed_registers;
    `uvm_info(get_full_name, $psprintf("cpu_pc_monitor got trigger = %x\n", packed_registers.pc), UVM_HIGH);
  endtask

  //---------------------------------------------------------------------------
  // BFM communication
  //---------------------------------------------------------------------------
  virtual function void write(packed_pc_monitor_t monitor_packet);
    // Note implicit cast
    packed_registers = monitor_packet;
    -> found_trigger;
  endfunction: write

endclass : cpu_pc_monitor_proxy



