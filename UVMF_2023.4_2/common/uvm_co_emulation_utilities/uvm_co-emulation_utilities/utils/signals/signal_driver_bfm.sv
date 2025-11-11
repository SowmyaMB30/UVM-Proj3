interface signal_driver_bfm  #(int unsigned SIGNAL_SIZE=4) (
input clock,
output bit [SIGNAL_SIZE-1:0] signals_out);
// pragma attribute signal_driver_bfm partition_interface_xif

//---------------------------------------------------------------------------
// Declarations
//---------------------------------------------------------------------------
signal_driver_pkg::signal_driver_proxy #(SIGNAL_SIZE) proxy;

bit [SIGNAL_SIZE-1:0] signals_to_drive;

//---------------------------------------------------------------------------
// Tasks to talk to the proxy
//---------------------------------------------------------------------------
// control monitoring enable and timeout
function void set_driven_signals(bit [SIGNAL_SIZE-1:0] drive_signals); // pragma tbx xtf
  signals_to_drive = drive_signals;
endfunction

function void get_driven_signals(output bit [SIGNAL_SIZE-1:0] driven_signals); // pragma tbx xtf
  driven_signals = signals_out;
endfunction

//---------------------------------------------------------------------------
// Drive out signals on the clock edge
//---------------------------------------------------------------------------
// Register incoming signals
always @(posedge clock) begin
  signals_out <= signals_to_drive;
end

endinterface

