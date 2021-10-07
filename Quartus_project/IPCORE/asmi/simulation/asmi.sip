set_global_assignment -entity "asmi" -library "lib_asmi" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "asmi" -library "lib_asmi" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "asmi" -library "lib_asmi" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_asmi" -name SPD_FILE [file join $::quartus(sip_path) "../asmi.spd"]
set_global_assignment -library "lib_asmi" -name MISC_FILE [file join $::quartus(sip_path) "../../asmi.qsys"]

set_global_assignment -library "lib_asmi" -name MISC_FILE [file join $::quartus(sip_path) "asmi.v"]
set_global_assignment -library "lib_asmi" -name MISC_FILE [file join $::quartus(sip_path) "submodules/asmi_asmi_parallel_0.v"]
