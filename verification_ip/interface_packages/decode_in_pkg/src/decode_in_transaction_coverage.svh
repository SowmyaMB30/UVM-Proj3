//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records decode_in transaction information using
//       a covergroup named decode_in_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class decode_in_transaction_coverage  extends uvm_subscriber #(.T(decode_in_transaction ));

  `uvm_component_utils( decode_in_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup decode_in_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    ins_type: coverpoint coverage_trans.ins_type;
    sr1: coverpoint coverage_trans.sr1;
    sr2: coverpoint coverage_trans.sr2;
    dr: coverpoint coverage_trans.dr;
    baser: coverpoint coverage_trans.baser;
    pcoffset9: coverpoint coverage_trans.pcoffset9;
    pcoffset6: coverpoint coverage_trans.pcoffset6;
    imm5: coverpoint coverage_trans.imm5;
    n: coverpoint coverage_trans.n;
    z: coverpoint coverage_trans.z;
    p: coverpoint coverage_trans.p;
    enable_decode: coverpoint coverage_trans.enable_decode;
    instr_dout: coverpoint coverage_trans.instr_dout;
    npc_in: coverpoint coverage_trans.npc_in;
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    decode_in_transaction_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that transaction variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    decode_in_transaction_cg.set_inst_name($sformatf("decode_in_transaction_cg_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    decode_in_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

