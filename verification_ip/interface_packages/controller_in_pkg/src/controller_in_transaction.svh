//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an controller_in
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class controller_in_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( controller_in_transaction )

  bit complete_data ;
  bit complete_instr ;
  bit [15:0] IR ;
  bit [2:0] NZP ;
  bit [2:0] psr ;
  bit [15:0] IR_Exec ;
  bit [15:0] IMem_dout ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in controller_in_macros.svh

  //*******************************************************************
  // Monitor macro used by controller_in_monitor and controller_in_monitor_bfm
  // This struct is defined in controller_in_macros.svh
  `controller_in_MONITOR_STRUCT
    controller_in_monitor_s controller_in_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a controller_in_monitor_s
  // structure.  The function returns the handle to the controller_in_monitor_struct.
  // This function is defined in controller_in_macros.svh
  `controller_in_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_in_macros.svh
  `controller_in_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by controller_in_driver and controller_in_driver_bfm
  // to communicate initiator driven data to controller_in_driver_bfm.
  // This struct is defined in controller_in_macros.svh
  `controller_in_INITIATOR_STRUCT
    controller_in_initiator_s controller_in_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a controller_in_initiator_s
  // structure.  The function returns the handle to the controller_in_initiator_struct.
  // This function is defined in controller_in_macros.svh
  `controller_in_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_in_macros.svh
  `controller_in_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by controller_in_driver and controller_in_driver_bfm
  // to communicate Responder driven data to controller_in_driver_bfm.
  // This struct is defined in controller_in_macros.svh
  `controller_in_RESPONDER_STRUCT
    controller_in_responder_s controller_in_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a controller_in_responder_s
  // structure.  The function returns the handle to the controller_in_responder_struct.
  // This function is defined in controller_in_macros.svh
  `controller_in_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_in_macros.svh
  `controller_in_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("complete_data:0x%x complete_instr:0x%x IR:0x%x NZP:0x%x psr:0x%x IR_Exec:0x%x IMem_dout:0x%x ",complete_data,complete_instr,IR,NZP,psr,IR_Exec,IMem_dout);
    // pragma uvmf custom convert2string end
  endfunction

  //*******************************************************************
  // FUNCTION: do_print()
  // This function is automatically called when the .print() function
  // is called on this class.
  //
  virtual function void do_print(uvm_printer printer);
    // pragma uvmf custom do_print begin
    // UVMF_CHANGE_ME : Current contents of do_print allows for the use of UVM 1.1d, 1.2 or P1800.2.
    // Update based on your own printing preference according to your preferred UVM version
    $display(convert2string());
    // pragma uvmf custom do_print end
  endfunction

  //*******************************************************************
  // FUNCTION: do_compare()
  // This function is automatically called when the .compare() function
  // is called on this class.
  //
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    controller_in_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    controller_in_transaction  RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.complete_data = RHS.complete_data;
    this.complete_instr = RHS.complete_instr;
    this.IR = RHS.IR;
    this.NZP = RHS.NZP;
    this.psr = RHS.psr;
    this.IR_Exec = RHS.IR_Exec;
    this.IMem_dout = RHS.IMem_dout;
    // pragma uvmf custom do_copy end
  endfunction

  // ****************************************************************************
  // FUNCTION: add_to_wave()
  // This function is used to display variables in this class in the waveform 
  // viewer.  The start_time and end_time variables must be set before this 
  // function is called.  If the start_time and end_time variables are not set
  // the transaction will be hidden at 0ns on the waveform display.
  // 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    `ifdef QUESTA
    if (transaction_view_h == 0) begin
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"controller_in_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,complete_data,"complete_data");
    $add_attribute(transaction_view_h,complete_instr,"complete_instr");
    $add_attribute(transaction_view_h,IR,"IR");
    $add_attribute(transaction_view_h,NZP,"NZP");
    $add_attribute(transaction_view_h,psr,"psr");
    $add_attribute(transaction_view_h,IR_Exec,"IR_Exec");
    $add_attribute(transaction_view_h,IMem_dout,"IMem_dout");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

