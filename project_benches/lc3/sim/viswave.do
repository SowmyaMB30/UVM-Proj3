 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { execute_env_exe_in_agent }
wave add uvm_test_top.environment.execute_env.exe_in_agent.exe_in_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_exe_in_agent_bus
wave add -group execute_env_exe_in_agent_bus hdl_top.execute_env_exe_in_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_exe_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_exe_out_agent }
wave add uvm_test_top.environment.execute_env.exe_out_agent.exe_out_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_exe_out_agent_bus
wave add -group execute_env_exe_out_agent_bus hdl_top.execute_env_exe_out_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_exe_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

