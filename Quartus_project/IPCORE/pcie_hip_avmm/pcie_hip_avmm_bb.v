
module pcie_hip_avmm (
	avl_to_asmi_0_conduit_end_sfl_address,
	avl_to_asmi_0_conduit_end_sfl_read,
	avl_to_asmi_0_conduit_end_sfl_readdata_from,
	avl_to_asmi_0_conduit_end_sfl_write,
	avl_to_asmi_0_conduit_end_sfl_writedata_to,
	avl_to_asmi_0_conduit_end_sfl_clk,
	avl_to_asmi_0_conduit_end_sfl_reset,
	clk_clk,
	clk_1_clk,
	fast_mem_address,
	fast_mem_read,
	fast_mem_readdata,
	fast_mem_readdatavalid,
	fast_mem_waitrequest,
	fast_mem_write,
	fast_mem_writedata,
	fast_mem_burstcount,
	fast_mem_lock,
	hip_ctrl_test_in,
	hip_ctrl_simu_mode_pipe,
	hip_serial_rx_in0,
	hip_serial_rx_in1,
	hip_serial_rx_in2,
	hip_serial_rx_in3,
	hip_serial_tx_out0,
	hip_serial_tx_out1,
	hip_serial_tx_out2,
	hip_serial_tx_out3,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_dm,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_1_mem_a,
	memory_1_mem_ba,
	memory_1_mem_ck,
	memory_1_mem_ck_n,
	memory_1_mem_cke,
	memory_1_mem_cs_n,
	memory_1_mem_dm,
	memory_1_mem_ras_n,
	memory_1_mem_cas_n,
	memory_1_mem_we_n,
	memory_1_mem_reset_n,
	memory_1_mem_dq,
	memory_1_mem_dqs,
	memory_1_mem_dqs_n,
	memory_1_mem_odt,
	mgmt_clk_clk,
	mgmt_rst_reset,
	oct_rzqin,
	oct_1_rzqin,
	pcie_npor_npor,
	pcie_npor_pin_perst,
	pcie_refclock_clk,
	reconfig_xcvr_clk_clk,
	reconfig_xcvr_rst_reset,
	reset_reset_n,
	reset_1_reset_n,
	slow_mem_address,
	slow_mem_read,
	slow_mem_readdata,
	slow_mem_readdatavalid,
	slow_mem_write,
	slow_mem_writedata,
	slow_mem_waitrequest,
	slow_mem_burstcount,
	slow_mem_lock);	

	output	[7:0]	avl_to_asmi_0_conduit_end_sfl_address;
	output		avl_to_asmi_0_conduit_end_sfl_read;
	input	[31:0]	avl_to_asmi_0_conduit_end_sfl_readdata_from;
	output		avl_to_asmi_0_conduit_end_sfl_write;
	output	[31:0]	avl_to_asmi_0_conduit_end_sfl_writedata_to;
	output		avl_to_asmi_0_conduit_end_sfl_clk;
	output		avl_to_asmi_0_conduit_end_sfl_reset;
	input		clk_clk;
	input		clk_1_clk;
	input	[31:0]	fast_mem_address;
	input		fast_mem_read;
	output	[511:0]	fast_mem_readdata;
	output		fast_mem_readdatavalid;
	output		fast_mem_waitrequest;
	input		fast_mem_write;
	input	[511:0]	fast_mem_writedata;
	input	[5:0]	fast_mem_burstcount;
	input		fast_mem_lock;
	input	[31:0]	hip_ctrl_test_in;
	input		hip_ctrl_simu_mode_pipe;
	input		hip_serial_rx_in0;
	input		hip_serial_rx_in1;
	input		hip_serial_rx_in2;
	input		hip_serial_rx_in3;
	output		hip_serial_tx_out0;
	output		hip_serial_tx_out1;
	output		hip_serial_tx_out2;
	output		hip_serial_tx_out3;
	output	[12:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output	[1:0]	memory_mem_ck;
	output	[1:0]	memory_mem_ck_n;
	output	[1:0]	memory_mem_cke;
	output	[1:0]	memory_mem_cs_n;
	output	[7:0]	memory_mem_dm;
	output	[0:0]	memory_mem_ras_n;
	output	[0:0]	memory_mem_cas_n;
	output	[0:0]	memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[63:0]	memory_mem_dq;
	inout	[7:0]	memory_mem_dqs;
	inout	[7:0]	memory_mem_dqs_n;
	output	[1:0]	memory_mem_odt;
	output	[12:0]	memory_1_mem_a;
	output	[2:0]	memory_1_mem_ba;
	output	[1:0]	memory_1_mem_ck;
	output	[1:0]	memory_1_mem_ck_n;
	output	[1:0]	memory_1_mem_cke;
	output	[1:0]	memory_1_mem_cs_n;
	output	[7:0]	memory_1_mem_dm;
	output	[0:0]	memory_1_mem_ras_n;
	output	[0:0]	memory_1_mem_cas_n;
	output	[0:0]	memory_1_mem_we_n;
	output		memory_1_mem_reset_n;
	inout	[63:0]	memory_1_mem_dq;
	inout	[7:0]	memory_1_mem_dqs;
	inout	[7:0]	memory_1_mem_dqs_n;
	output	[1:0]	memory_1_mem_odt;
	input		mgmt_clk_clk;
	input		mgmt_rst_reset;
	input		oct_rzqin;
	input		oct_1_rzqin;
	input		pcie_npor_npor;
	input		pcie_npor_pin_perst;
	input		pcie_refclock_clk;
	input		reconfig_xcvr_clk_clk;
	input		reconfig_xcvr_rst_reset;
	input		reset_reset_n;
	input		reset_1_reset_n;
	input	[31:0]	slow_mem_address;
	input		slow_mem_read;
	output	[511:0]	slow_mem_readdata;
	output		slow_mem_readdatavalid;
	input		slow_mem_write;
	input	[511:0]	slow_mem_writedata;
	output		slow_mem_waitrequest;
	input	[5:0]	slow_mem_burstcount;
	input		slow_mem_lock;
endmodule
