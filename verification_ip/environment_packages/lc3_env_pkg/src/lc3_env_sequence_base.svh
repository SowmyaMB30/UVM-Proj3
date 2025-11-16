//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains environment level sequences that will
//    be reused from block to top level simulations.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class lc3_env_sequence_base #( 
      type CONFIG_T
      ) extends uvmf_virtual_sequence_base #(.CONFIG_T(CONFIG_T));


  `uvm_object_param_utils( lc3_env_sequence_base #(
                           CONFIG_T
                           ) );

  
// This lc3_env_sequence_base contains a handle to a lc3_env_configuration object 
// named configuration.  This configuration variable contains a handle to each 
// sequencer within each agent within this environment and any sub-environments.
// The configuration object handle is automatically assigned in the pre_body in the
// base class of this sequence.  The configuration handle is retrieved from the
// virtual sequencer that this sequence is started on.
// Available sequencer handles within the environment configuration:

  // Initiator agent sequencers in lc3_environment:

  // Responder agent sequencers in lc3_environment:

  // Virtual sequencers in sub-environments located in sub-environment configuration
    // configuration.execute_env_config.vsqr


// This example shows how to use the environment sequence base for sub-environments
// It can only be used on environments generated with UVMF_2022.3 and later.
// Environment sequences generated with UVMF_2022.1 and earlier do not have the required 
//    environment level virtual sequencer
// typedef execute_env_sequence_base #(
//         .CONFIG_T(execute_env_configuration)
//         ) 
//         execute_env_sequence_base_t;
// rand execute_env_sequence_base_t execute_env_seq;



  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  function new(string name = "" );
    super.new(name);

//     execute_env_seq = execute_env_sequence_base_t::type_id::create("execute_env_seq");

  endfunction

  virtual task body();

  

//     execute_env_seq.start(configuration.execute_env_config.vsqr);

  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

