# Tcl do file for compile of lc3 interface

# pragma uvmf custom additional begin
# pragma uvmf custom additional end


# Include build for sub-environment execute_env_pkg
quietly set cmd [format "source %s/environment_packages/execute_env_pkg/compile.do" $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd

quietly set cmd [format "vlog -timescale 1ps/1ps +incdir+%s/environment_packages/lc3_env_pkg" $env(UVMF_VIP_LIBRARY_HOME)]
quietly set cmd [format "%s %s/environment_packages/lc3_env_pkg/lc3_env_pkg.sv" $cmd $env(UVMF_VIP_LIBRARY_HOME)]
eval $cmd


