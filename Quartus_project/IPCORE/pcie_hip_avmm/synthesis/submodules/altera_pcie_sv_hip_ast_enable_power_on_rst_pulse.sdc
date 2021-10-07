# (C) 2001-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


#####################################################################
#
# altera_pcie_sv_hip_ast SDC Contraint used for soft reset controller
#
######################################################################
#
# Constraints for asynchronous logic
#
set_false_path -from [get_registers *altpcie_hip_256_pipen1b|g_npor_int.dly_cnt[9]  ]
