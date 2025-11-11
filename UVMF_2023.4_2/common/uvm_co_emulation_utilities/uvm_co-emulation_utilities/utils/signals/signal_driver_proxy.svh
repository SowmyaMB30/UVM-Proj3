
class signal_driver_proxy #(int unsigned SIGNAL_SIZE=4 ) extends uvm_object;

  `uvm_object_param_utils(signal_driver_proxy #(SIGNAL_SIZE))

  // Virtual Interface
  //bfm is local because we must set the proxy handle for proper operation
  local virtual signal_driver_bfm #(SIGNAL_SIZE) bfm;

  function new(string name = "signal_driver_proxy");
    super.new(name);
  endfunction : new

  //---------------------------------------------------------------------------
  // BFM Accessors Code
  //---------------------------------------------------------------------------
  
  virtual function void set_bfm(virtual signal_driver_bfm #(SIGNAL_SIZE) sbfm);
    bfm = sbfm;
    bfm.proxy = this;
  endfunction : set_bfm;

  virtual function virtual signal_driver_bfm #(SIGNAL_SIZE) get_bfm();
    return bfm;
  endfunction : get_bfm

  virtual function void set_signals_to_drive (bit [SIGNAL_SIZE-1:0] signals2drv );
    bfm.set_driven_signals(signals2drv);
  endfunction

  virtual function void get_signals_to_drive (output bit [SIGNAL_SIZE-1:0] signals2drv );
    bfm.get_driven_signals(signals2drv);
  endfunction : get_signals_to_drive

endclass : signal_driver_proxy
