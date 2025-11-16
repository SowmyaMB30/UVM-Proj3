//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an controller_out
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class controller_out_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( controller_out_transaction )

  bit enable_updatePC ;
  bit enable_fetch ;
  bit enable_decode ;
  bit enable_execute ;
  bit enable_writeback ;
  bit br_taken ;
  bit bypass_alu_1 ;
  bit bypass_alu_2 ;
  bit bypass_mem_1 ;
  bit bypass_mem_2 ;
  bit [1:0] mem_state ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in controller_out_macros.svh

  //*******************************************************************
  // Monitor macro used by controller_out_monitor and controller_out_monitor_bfm
  // This struct is defined in controller_out_macros.svh
  `controller_out_MONITOR_STRUCT
    controller_out_monitor_s controller_out_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a controller_out_monitor_s
  // structure.  The function returns the handle to the controller_out_monitor_struct.
  // This function is defined in controller_out_macros.svh
  `controller_out_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_out_macros.svh
  `controller_out_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by controller_out_driver and controller_out_driver_bfm
  // to communicate initiator driven data to controller_out_driver_bfm.
  // This struct is defined in controller_out_macros.svh
  `controller_out_INITIATOR_STRUCT
    controller_out_initiator_s controller_out_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a controller_out_initiator_s
  // structure.  The function returns the handle to the controller_out_initiator_struct.
  // This function is defined in controller_out_macros.svh
  `controller_out_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_out_macros.svh
  `controller_out_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by controller_out_driver and controller_out_driver_bfm
  // to communicate Responder driven data to controller_out_driver_bfm.
  // This struct is defined in controller_out_macros.svh
  `controller_out_RESPONDER_STRUCT
    controller_out_responder_s controller_out_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a controller_out_responder_s
  // structure.  The function returns the handle to the controller_out_responder_struct.
  // This function is defined in controller_out_macros.svh
  `controller_out_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in controller_out_macros.svh
  `controller_out_FROM_RESPONDER_STRUCT_FUNCTION 
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
    return $sformatf("enable_updatePC:0x%x enable_fetch:0x%x enable_decode:0x%x enable_execute:0x%x enable_writeback:0x%x br_taken:0x%x bypass_alu_1:0x%x bypass_alu_2:0x%x bypass_mem_1:0x%x bypass_mem_2:0x%x mem_state:0x%x ",enable_updatePC,enable_fetch,enable_decode,enable_execute,enable_writeback,br_taken,bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2,mem_state);
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
    controller_out_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.enable_updatePC == RHS.enable_updatePC)
            &&(this.enable_fetch == RHS.enable_fetch)
            &&(this.enable_decode == RHS.enable_decode)
            &&(this.enable_execute == RHS.enable_execute)
            &&(this.enable_writeback == RHS.enable_writeback)
            &&(this.br_taken == RHS.br_taken)
            &&(this.bypass_alu_1 == RHS.bypass_alu_1)
            &&(this.bypass_alu_2 == RHS.bypass_alu_2)
            &&(this.bypass_mem_1 == RHS.bypass_mem_1)
            &&(this.bypass_mem_2 == RHS.bypass_mem_2)
            &&(this.mem_state == RHS.mem_state)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    controller_out_transaction  RHS;
    if(!$cast(RHS,rhs))begin
      `uvm_fatal("CAST","Transaction cast in do_copy() failed!")
    end
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.enable_updatePC = RHS.enable_updatePC;
    this.enable_fetch = RHS.enable_fetch;
    this.enable_decode = RHS.enable_decode;
    this.enable_execute = RHS.enable_execute;
    this.enable_writeback = RHS.enable_writeback;
    this.br_taken = RHS.br_taken;
    this.bypass_alu_1 = RHS.bypass_alu_1;
    this.bypass_alu_2 = RHS.bypass_alu_2;
    this.bypass_mem_1 = RHS.bypass_mem_1;
    this.bypass_mem_2 = RHS.bypass_mem_2;
    this.mem_state = RHS.mem_state;
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
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"controller_out_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,enable_updatePC,"enable_updatePC");
    $add_attribute(transaction_view_h,enable_fetch,"enable_fetch");
    $add_attribute(transaction_view_h,enable_decode,"enable_decode");
    $add_attribute(transaction_view_h,enable_execute,"enable_execute");
    $add_attribute(transaction_view_h,enable_writeback,"enable_writeback");
    $add_attribute(transaction_view_h,br_taken,"br_taken");
    $add_attribute(transaction_view_h,bypass_alu_1,"bypass_alu_1");
    $add_attribute(transaction_view_h,bypass_alu_2,"bypass_alu_2");
    $add_attribute(transaction_view_h,bypass_mem_1,"bypass_mem_1");
    $add_attribute(transaction_view_h,bypass_mem_2,"bypass_mem_2");
    $add_attribute(transaction_view_h,mem_state,"mem_state");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

