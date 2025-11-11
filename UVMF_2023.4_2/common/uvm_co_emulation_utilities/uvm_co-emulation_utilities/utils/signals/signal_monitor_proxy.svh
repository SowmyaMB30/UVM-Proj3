class signal_monitor_proxy #(int unsigned SIGNAL_SIZE = 4, int unsigned BUFFER_SIZE=1) extends uvm_object;

  `uvm_object_param_utils(signal_monitor_proxy #(SIGNAL_SIZE,BUFFER_SIZE))

  // Local typedef for easy packing
  typedef struct packed {
    bit valid;    // valid bit
    bit [SIGNAL_SIZE-1:0] data; } packed_signals_s;

  typedef bit[SIGNAL_SIZE : 0] packed_signals_t;

  typedef packed_signals_t[BUFFER_SIZE-1:0] packed_signals_buf_t;

  // Local buffer holding signals;
  bit [SIGNAL_SIZE-1:0] signals_data [BUFFER_SIZE];
  bit [BUFFER_SIZE-1:0] signals_valid;

  bit [SIGNAL_SIZE-1:0] signals_found_bfm;
  bit pattern_found_bfm;
  event found_pattern;

  // Virtual Interface
  //bfm is local because we must set the proxy handle for proper operation
  local virtual signal_monitor_bfm #(SIGNAL_SIZE,BUFFER_SIZE) bfm;

  function new(string name = "signal_monitor_proxy");
    super.new(name);
  endfunction : new

  //---------------------------------------------------------------------------
  // BFM Accessors Code
  //---------------------------------------------------------------------------
  
  virtual function void set_bfm(virtual signal_monitor_bfm #(SIGNAL_SIZE,BUFFER_SIZE) sbfm);
    bfm = sbfm;
    bfm.proxy = this;
  endfunction : set_bfm;

  virtual function virtual signal_monitor_bfm #(SIGNAL_SIZE,BUFFER_SIZE) get_bfm();
    return bfm;
  endfunction : get_bfm

  virtual function void monitor_control (bit enable, int unsigned timeout);
    bfm.monitor_control(enable,timeout);
  endfunction : monitor_control

  virtual task get_signals (output bit [SIGNAL_SIZE-1:0] signals_now);
    //for visibility
    bit [SIGNAL_SIZE-1:0] signals_got;

    bfm.get_signals(signals_got);
    signals_now = signals_got;
  endtask : get_signals

  virtual task wait_for_signal_pattern (input bit [SIGNAL_SIZE-1:0] signal_pattern , input bit[7:0] pattern_count, 
                                        output pattern_found, output bit [SIGNAL_SIZE-1:0] signals_found);
    bfm.get_signal_pattern(signal_pattern,pattern_count);
    @found_pattern;
    pattern_found = pattern_found_bfm;
    signals_found = signals_found_bfm;
    `uvm_info(get_full_name, $psprintf("signal_monitor looking for pattern %x found signal pattern = %x\n",signal_pattern, signals_found), UVM_LOW);
  endtask : wait_for_signal_pattern

  //---------------------------------------------------------------------------
  // BFM Communication
  //---------------------------------------------------------------------------
  virtual function void bfm_found_pattern(bit pattern_found, bit [SIGNAL_SIZE-1:0] signals_bfm);
    pattern_found_bfm = pattern_found;
    signals_found_bfm = signals_bfm;
    -> found_pattern;
  endfunction

  virtual function void write(packed_signals_buf_t signals_packet);
    packed_signals_s signals_s;

    // Unpack the signals packet
    for(int pi=0;pi<BUFFER_SIZE;pi++) begin
      signals_s = signals_packet[pi];
      signals_valid[pi] = signals_s.valid;
      signals_data[pi] = signals_s.data;
      // Add analysis port here for monitoring
      `uvm_info(get_full_name, $psprintf("signal_monitor got signals = %x\n", signals_data[pi]), UVM_LOW);
    end

  endfunction: write

endclass : signal_monitor_proxy

