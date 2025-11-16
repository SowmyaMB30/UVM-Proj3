//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class execute_environment  extends uvmf_environment_base #(
    .CONFIG_T( execute_env_configuration 
  ));
  `uvm_component_utils( execute_environment )





  typedef execute_in_agent  exe_in_agent_t;
  exe_in_agent_t exe_in_agent;

  typedef execute_out_agent  exe_out_agent_t;
  exe_out_agent_t exe_out_agent;




  typedef exe_predictor #(
                .CONFIG_T(CONFIG_T)
                )
 exe_pred_t;
  exe_pred_t exe_pred;

  typedef uvmf_in_order_race_scoreboard #(.T(execute_out_transaction))  exe_scoreboard_t;
  exe_scoreboard_t exe_scoreboard;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(execute_env_configuration)) execute_vsqr_t;
  execute_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    exe_in_agent = exe_in_agent_t::type_id::create("exe_in_agent",this);
    exe_in_agent.set_config(configuration.exe_in_agent_config);
    exe_out_agent = exe_out_agent_t::type_id::create("exe_out_agent",this);
    exe_out_agent.set_config(configuration.exe_out_agent_config);
    exe_pred = exe_pred_t::type_id::create("exe_pred",this);
    exe_pred.configuration = configuration;
    exe_scoreboard = exe_scoreboard_t::type_id::create("exe_scoreboard",this);

    vsqr = execute_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    exe_in_agent.monitored_ap.connect(exe_pred.analysis_export);
    exe_out_agent.monitored_ap.connect(exe_scoreboard.actual_analysis_export);
    exe_pred.analysis_port.connect(exe_scoreboard.expected_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.execute_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

