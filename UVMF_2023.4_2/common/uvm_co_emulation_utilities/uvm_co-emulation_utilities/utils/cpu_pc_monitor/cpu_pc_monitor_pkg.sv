`include "uvm_macros.svh"
`include "cpu_pc_monitor_shared_pkg.svh"

package cpu_pc_monitor_pkg;

  import uvm_pkg::*;
  import cpu_pc_monitor_shared_pkg::*;

  //Include the components
  `include "cpu_pc_monitor_proxy.svh"

endpackage : cpu_pc_monitor_pkg

