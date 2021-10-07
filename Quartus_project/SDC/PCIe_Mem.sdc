## Generated SDC file "E:/irshad/12_gen2_8NAND_only_classcode_nvme_image_upg_sdc/SDC/DMA_top.out.sdc"

## Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus Prime License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 15.1.0 Build 185 10/21/2015 SJ Standard Edition"

## DATE    "Fri Sep 02 14:31:38 2016"

##
## DEVICE  "5SGXEA3K3F40C4"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[0].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]} -period 10.000 -waveform { 0.000 5.000 } [get_pins {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[0].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}]
create_clock -name {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[3].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]} -period 10.000 -waveform { 0.000 5.000 } [get_pins {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[3].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}]
create_clock -name {pcie_refclk} -period 8.000 -waveform { 0.000 4.000 } [get_ports {pcie_refclk}]
create_clock -name {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[3].rx_pma.rx_cdr|clk90bdes} -period 0.400 -waveform { 0.000 0.200 } [get_pins {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[3].rx_pma.rx_cdr|clk90bdes}]
create_clock -name {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[2].rx_pma.rx_cdr|clk90bdes} -period 0.400 -waveform { 0.000 0.200 } [get_pins {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[2].rx_pma.rx_cdr|clk90bdes}]
create_clock -name {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[1].rx_pma.rx_cdr|clk90bdes} -period 0.400 -waveform { 0.000 0.200 } [get_pins {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[1].rx_pma.rx_cdr|clk90bdes}]
create_clock -name {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[0].rx_pma.rx_cdr|clk90bdes} -period 0.400 -waveform { 0.000 0.200 } [get_pins {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_pma|rx_pma.sv_rx_pma_inst|rx_pmas[0].rx_pma.rx_cdr|clk90bdes}]
create_clock -name {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|observablecoreclkdiv} -period 8.000 -waveform { 0.000 4.000 } [get_pins {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|observablecoreclkdiv}]
create_clock -name {clk_100} -period 10.000 -waveform { 0.000 5.000 } [get_ports {*clk_100*}]
create_clock -name {nand_if0_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if0_bank00_io_dqs}]
create_clock -name {nand_if0_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if0_bank00_ren_wrn}]
create_clock -name {nand_if1_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if1_bank00_io_dqs}]
create_clock -name {nand_if1_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if1_bank00_ren_wrn}]
create_clock -name {nand_if2_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if2_bank00_io_dqs}]
create_clock -name {nand_if2_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if2_bank00_ren_wrn}]
create_clock -name {nand_if3_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if3_bank00_io_dqs}]
create_clock -name {nand_if3_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if3_bank00_ren_wrn}]
create_clock -name {nand_if4_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if4_bank00_io_dqs}]
create_clock -name {nand_if4_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if4_bank00_ren_wrn}]
create_clock -name {nand_if5_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if5_bank00_io_dqs}]
create_clock -name {nand_if5_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if5_bank00_ren_wrn}]
create_clock -name {nand_if6_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if6_bank00_io_dqs}]
create_clock -name {nand_if6_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if6_bank00_ren_wrn}]
create_clock -name {nand_if7_bank00_io_dqs} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if7_bank00_io_dqs}]
create_clock -name {nand_if7_bank00_ren_wrn} -period 25.000 -waveform { 0.000 12.500 } [get_ports {nand_if7_bank00_ren_wrn}]


#**************************************************************
# Create Generated Clock
#**************************************************************

derive_pll_clocks -create_base_clocks


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

derive_clock_uncertainty


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -asynchronous -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[3].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}] 
set_clock_groups -asynchronous -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[0].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}] 
set_clock_groups -exclusive -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] -group [get_clocks {u0|pll_nvddr2|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[2].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[3].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[4].gpll~PLL_OUTPUT_COUNTER|divclk}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if0_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if0_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if1_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if1_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if2_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if2_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if3_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if3_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if4_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if5_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if6_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if7_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -asynchronous -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[0].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}] 
set_clock_groups -asynchronous -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[3].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -exclusive -group [get_clocks {sv_reconfig_pma_testbus_clk_0}] 
set_clock_groups -asynchronous -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[3].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}] 
set_clock_groups -asynchronous -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|g_xcvr.sv_xcvr_pipe_native|inst_sv_xcvr_native|inst_sv_xcvr_avmm|avmm_interface_insts[0].stratixv_hssi_avmm_interface_inst|pmatestbussel[0]}] 
set_clock_groups -exclusive -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] -group [get_clocks {u0|pll_nvddr2|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[2].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[3].gpll~PLL_OUTPUT_COUNTER|divclk u0|pll_nvddr2|altera_pll_i|general[4].gpll~PLL_OUTPUT_COUNTER|divclk}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if0_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if0_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if1_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if1_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if2_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if2_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {virtual_nand_if3_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if3_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if4_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if5_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if6_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {nand_if7_bank00_io_dqs}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 

set_clock_groups -exclusive -group [get_clocks {xcvr_clk50|pll_50_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 
set_clock_groups -exclusive -group [get_clocks {xcvr_clk50|pll_50_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -group [get_clocks {u0|pcie_256_hip_avmm_0|altera_s5_a2p|altpcie_hip_256_pipen1b|stratixv_hssi_gen3_pcie_hip|coreclkout}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_ue9:dffpipe17|dffe18a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_te9:dffpipe14|dffe15a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_gd9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_fd9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_ed9:dffpipe16|dffe17a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_cd9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_md9:dffpipe13|dffe14a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_ld9:dffpipe10|dffe11a*}]
set_false_path -to [get_registers {*alt_xcvr_resync*sync_r[0]}]
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_pins -compatibility_mode {*stratixv_hssi_gen3_pcie_hip|testinhip[*]}] 
set_false_path -from [get_pins -compatibility_mode {*stratixv_hssi_gen3_pcie_hip|testin1hip[*]}] 
set_false_path -from [get_registers {*sv_xcvr_pipe_native*}] -to [get_registers {*altpcie_rs_serdes|*}]
set_false_path -to [get_registers {*altpcie_rs_serdes|tx_cal_busy_r[0]}]
set_false_path -to [get_registers {*altpcie_rs_serdes|rx_cal_busy_r[0]}]
set_false_path -to [get_registers {*altpcie_rs_serdes|pll_locked_r[0]}]
set_false_path -to [get_registers {*altpcie_rs_serdes|rx_signaldetect_r[*]}]
set_false_path -to [get_registers {*altpcie_rs_serdes|rx_pll_locked_r[*]}]
set_false_path -to [get_registers {*altpcie_rs_serdes|rx_pll_freq_locked_r[0]}]
set_false_path -hold -from [get_keepers {*|alt_xcvr_reconfig_basic:basic|sv_xcvr_reconfig_basic:s5|pif_interface_sel}] 
set_false_path -from [get_ports {pcie_perst}] 


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************

set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] 20.000
set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] 20.000
set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] 20.000
set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] 20.000
set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] 20.000
set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] 20.000
set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] 20.000
set_max_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] 20.000
set_max_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] 20.000


#**************************************************************
# Set Minimum Delay
#**************************************************************

set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] -10.000
set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] -10.000
set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[0].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] -10.000
set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] -10.000
set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[1].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] -10.000
set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_rx_pld_pcs_interface_rbc:inst_sv_hssi_rx_pld_pcs_interface|asynchdatain }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] -10.000
set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[2].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_common_pld_pcs_interface_rbc:inst_sv_hssi_common_pld_pcs_interface|pldnfrzdrv }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldlccmurstbout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxiqclkout }] -10.000
set_min_delay -from [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|pldtxpmasyncpfbkpout }] -10.000
set_min_delay -to [get_ports { pcie_nand:u0|altpcie_256_hip_avmm_hwtcl:pcie_256_hip_avmm_0|altpcie_sv_hip_ast_hwtcl:altera_s5_a2p|altpcie_hip_256_pipen1b:altpcie_hip_256_pipen1b|sv_xcvr_pipe_native:g_xcvr.sv_xcvr_pipe_native|sv_xcvr_native:inst_sv_xcvr_native|sv_pcs:inst_sv_pcs|sv_pcs_ch:ch[3].inst_sv_pcs_ch|sv_hssi_tx_pld_pcs_interface_rbc:inst_sv_hssi_tx_pld_pcs_interface|asynchdatain }] -10.000


#**************************************************************
# Set Input Transition
#**************************************************************

