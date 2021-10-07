	component pcie_hip_avmm is
		port (
			avl_to_asmi_0_conduit_end_sfl_address       : out   std_logic_vector(7 downto 0);                      -- sfl_address
			avl_to_asmi_0_conduit_end_sfl_read          : out   std_logic;                                         -- sfl_read
			avl_to_asmi_0_conduit_end_sfl_readdata_from : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- sfl_readdata_from
			avl_to_asmi_0_conduit_end_sfl_write         : out   std_logic;                                         -- sfl_write
			avl_to_asmi_0_conduit_end_sfl_writedata_to  : out   std_logic_vector(31 downto 0);                     -- sfl_writedata_to
			avl_to_asmi_0_conduit_end_sfl_clk           : out   std_logic;                                         -- sfl_clk
			avl_to_asmi_0_conduit_end_sfl_reset         : out   std_logic;                                         -- sfl_reset
			clk_clk                                     : in    std_logic                      := 'X';             -- clk
			clk_1_clk                                   : in    std_logic                      := 'X';             -- clk
			fast_mem_address                            : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- address
			fast_mem_read                               : in    std_logic                      := 'X';             -- read
			fast_mem_readdata                           : out   std_logic_vector(511 downto 0);                    -- readdata
			fast_mem_readdatavalid                      : out   std_logic;                                         -- readdatavalid
			fast_mem_waitrequest                        : out   std_logic;                                         -- waitrequest
			fast_mem_write                              : in    std_logic                      := 'X';             -- write
			fast_mem_writedata                          : in    std_logic_vector(511 downto 0) := (others => 'X'); -- writedata
			fast_mem_burstcount                         : in    std_logic_vector(5 downto 0)   := (others => 'X'); -- burstcount
			fast_mem_lock                               : in    std_logic                      := 'X';             -- lock
			hip_ctrl_test_in                            : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- test_in
			hip_ctrl_simu_mode_pipe                     : in    std_logic                      := 'X';             -- simu_mode_pipe
			hip_serial_rx_in0                           : in    std_logic                      := 'X';             -- rx_in0
			hip_serial_rx_in1                           : in    std_logic                      := 'X';             -- rx_in1
			hip_serial_rx_in2                           : in    std_logic                      := 'X';             -- rx_in2
			hip_serial_rx_in3                           : in    std_logic                      := 'X';             -- rx_in3
			hip_serial_tx_out0                          : out   std_logic;                                         -- tx_out0
			hip_serial_tx_out1                          : out   std_logic;                                         -- tx_out1
			hip_serial_tx_out2                          : out   std_logic;                                         -- tx_out2
			hip_serial_tx_out3                          : out   std_logic;                                         -- tx_out3
			memory_mem_a                                : out   std_logic_vector(12 downto 0);                     -- mem_a
			memory_mem_ba                               : out   std_logic_vector(2 downto 0);                      -- mem_ba
			memory_mem_ck                               : out   std_logic_vector(1 downto 0);                      -- mem_ck
			memory_mem_ck_n                             : out   std_logic_vector(1 downto 0);                      -- mem_ck_n
			memory_mem_cke                              : out   std_logic_vector(1 downto 0);                      -- mem_cke
			memory_mem_cs_n                             : out   std_logic_vector(1 downto 0);                      -- mem_cs_n
			memory_mem_dm                               : out   std_logic_vector(7 downto 0);                      -- mem_dm
			memory_mem_ras_n                            : out   std_logic_vector(0 downto 0);                      -- mem_ras_n
			memory_mem_cas_n                            : out   std_logic_vector(0 downto 0);                      -- mem_cas_n
			memory_mem_we_n                             : out   std_logic_vector(0 downto 0);                      -- mem_we_n
			memory_mem_reset_n                          : out   std_logic;                                         -- mem_reset_n
			memory_mem_dq                               : inout std_logic_vector(63 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs                              : inout std_logic_vector(7 downto 0)   := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                            : inout std_logic_vector(7 downto 0)   := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                              : out   std_logic_vector(1 downto 0);                      -- mem_odt
			memory_1_mem_a                              : out   std_logic_vector(12 downto 0);                     -- mem_a
			memory_1_mem_ba                             : out   std_logic_vector(2 downto 0);                      -- mem_ba
			memory_1_mem_ck                             : out   std_logic_vector(1 downto 0);                      -- mem_ck
			memory_1_mem_ck_n                           : out   std_logic_vector(1 downto 0);                      -- mem_ck_n
			memory_1_mem_cke                            : out   std_logic_vector(1 downto 0);                      -- mem_cke
			memory_1_mem_cs_n                           : out   std_logic_vector(1 downto 0);                      -- mem_cs_n
			memory_1_mem_dm                             : out   std_logic_vector(7 downto 0);                      -- mem_dm
			memory_1_mem_ras_n                          : out   std_logic_vector(0 downto 0);                      -- mem_ras_n
			memory_1_mem_cas_n                          : out   std_logic_vector(0 downto 0);                      -- mem_cas_n
			memory_1_mem_we_n                           : out   std_logic_vector(0 downto 0);                      -- mem_we_n
			memory_1_mem_reset_n                        : out   std_logic;                                         -- mem_reset_n
			memory_1_mem_dq                             : inout std_logic_vector(63 downto 0)  := (others => 'X'); -- mem_dq
			memory_1_mem_dqs                            : inout std_logic_vector(7 downto 0)   := (others => 'X'); -- mem_dqs
			memory_1_mem_dqs_n                          : inout std_logic_vector(7 downto 0)   := (others => 'X'); -- mem_dqs_n
			memory_1_mem_odt                            : out   std_logic_vector(1 downto 0);                      -- mem_odt
			mgmt_clk_clk                                : in    std_logic                      := 'X';             -- clk
			mgmt_rst_reset                              : in    std_logic                      := 'X';             -- reset
			oct_rzqin                                   : in    std_logic                      := 'X';             -- rzqin
			oct_1_rzqin                                 : in    std_logic                      := 'X';             -- rzqin
			pcie_npor_npor                              : in    std_logic                      := 'X';             -- npor
			pcie_npor_pin_perst                         : in    std_logic                      := 'X';             -- pin_perst
			pcie_refclock_clk                           : in    std_logic                      := 'X';             -- clk
			reconfig_xcvr_clk_clk                       : in    std_logic                      := 'X';             -- clk
			reconfig_xcvr_rst_reset                     : in    std_logic                      := 'X';             -- reset
			reset_reset_n                               : in    std_logic                      := 'X';             -- reset_n
			reset_1_reset_n                             : in    std_logic                      := 'X';             -- reset_n
			slow_mem_address                            : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- address
			slow_mem_read                               : in    std_logic                      := 'X';             -- read
			slow_mem_readdata                           : out   std_logic_vector(511 downto 0);                    -- readdata
			slow_mem_readdatavalid                      : out   std_logic;                                         -- readdatavalid
			slow_mem_write                              : in    std_logic                      := 'X';             -- write
			slow_mem_writedata                          : in    std_logic_vector(511 downto 0) := (others => 'X'); -- writedata
			slow_mem_waitrequest                        : out   std_logic;                                         -- waitrequest
			slow_mem_burstcount                         : in    std_logic_vector(5 downto 0)   := (others => 'X'); -- burstcount
			slow_mem_lock                               : in    std_logic                      := 'X'              -- lock
		);
	end component pcie_hip_avmm;

	u0 : component pcie_hip_avmm
		port map (
			avl_to_asmi_0_conduit_end_sfl_address       => CONNECTED_TO_avl_to_asmi_0_conduit_end_sfl_address,       -- avl_to_asmi_0_conduit_end.sfl_address
			avl_to_asmi_0_conduit_end_sfl_read          => CONNECTED_TO_avl_to_asmi_0_conduit_end_sfl_read,          --                          .sfl_read
			avl_to_asmi_0_conduit_end_sfl_readdata_from => CONNECTED_TO_avl_to_asmi_0_conduit_end_sfl_readdata_from, --                          .sfl_readdata_from
			avl_to_asmi_0_conduit_end_sfl_write         => CONNECTED_TO_avl_to_asmi_0_conduit_end_sfl_write,         --                          .sfl_write
			avl_to_asmi_0_conduit_end_sfl_writedata_to  => CONNECTED_TO_avl_to_asmi_0_conduit_end_sfl_writedata_to,  --                          .sfl_writedata_to
			avl_to_asmi_0_conduit_end_sfl_clk           => CONNECTED_TO_avl_to_asmi_0_conduit_end_sfl_clk,           --                          .sfl_clk
			avl_to_asmi_0_conduit_end_sfl_reset         => CONNECTED_TO_avl_to_asmi_0_conduit_end_sfl_reset,         --                          .sfl_reset
			clk_clk                                     => CONNECTED_TO_clk_clk,                                     --                       clk.clk
			clk_1_clk                                   => CONNECTED_TO_clk_1_clk,                                   --                     clk_1.clk
			fast_mem_address                            => CONNECTED_TO_fast_mem_address,                            --                  fast_mem.address
			fast_mem_read                               => CONNECTED_TO_fast_mem_read,                               --                          .read
			fast_mem_readdata                           => CONNECTED_TO_fast_mem_readdata,                           --                          .readdata
			fast_mem_readdatavalid                      => CONNECTED_TO_fast_mem_readdatavalid,                      --                          .readdatavalid
			fast_mem_waitrequest                        => CONNECTED_TO_fast_mem_waitrequest,                        --                          .waitrequest
			fast_mem_write                              => CONNECTED_TO_fast_mem_write,                              --                          .write
			fast_mem_writedata                          => CONNECTED_TO_fast_mem_writedata,                          --                          .writedata
			fast_mem_burstcount                         => CONNECTED_TO_fast_mem_burstcount,                         --                          .burstcount
			fast_mem_lock                               => CONNECTED_TO_fast_mem_lock,                               --                          .lock
			hip_ctrl_test_in                            => CONNECTED_TO_hip_ctrl_test_in,                            --                  hip_ctrl.test_in
			hip_ctrl_simu_mode_pipe                     => CONNECTED_TO_hip_ctrl_simu_mode_pipe,                     --                          .simu_mode_pipe
			hip_serial_rx_in0                           => CONNECTED_TO_hip_serial_rx_in0,                           --                hip_serial.rx_in0
			hip_serial_rx_in1                           => CONNECTED_TO_hip_serial_rx_in1,                           --                          .rx_in1
			hip_serial_rx_in2                           => CONNECTED_TO_hip_serial_rx_in2,                           --                          .rx_in2
			hip_serial_rx_in3                           => CONNECTED_TO_hip_serial_rx_in3,                           --                          .rx_in3
			hip_serial_tx_out0                          => CONNECTED_TO_hip_serial_tx_out0,                          --                          .tx_out0
			hip_serial_tx_out1                          => CONNECTED_TO_hip_serial_tx_out1,                          --                          .tx_out1
			hip_serial_tx_out2                          => CONNECTED_TO_hip_serial_tx_out2,                          --                          .tx_out2
			hip_serial_tx_out3                          => CONNECTED_TO_hip_serial_tx_out3,                          --                          .tx_out3
			memory_mem_a                                => CONNECTED_TO_memory_mem_a,                                --                    memory.mem_a
			memory_mem_ba                               => CONNECTED_TO_memory_mem_ba,                               --                          .mem_ba
			memory_mem_ck                               => CONNECTED_TO_memory_mem_ck,                               --                          .mem_ck
			memory_mem_ck_n                             => CONNECTED_TO_memory_mem_ck_n,                             --                          .mem_ck_n
			memory_mem_cke                              => CONNECTED_TO_memory_mem_cke,                              --                          .mem_cke
			memory_mem_cs_n                             => CONNECTED_TO_memory_mem_cs_n,                             --                          .mem_cs_n
			memory_mem_dm                               => CONNECTED_TO_memory_mem_dm,                               --                          .mem_dm
			memory_mem_ras_n                            => CONNECTED_TO_memory_mem_ras_n,                            --                          .mem_ras_n
			memory_mem_cas_n                            => CONNECTED_TO_memory_mem_cas_n,                            --                          .mem_cas_n
			memory_mem_we_n                             => CONNECTED_TO_memory_mem_we_n,                             --                          .mem_we_n
			memory_mem_reset_n                          => CONNECTED_TO_memory_mem_reset_n,                          --                          .mem_reset_n
			memory_mem_dq                               => CONNECTED_TO_memory_mem_dq,                               --                          .mem_dq
			memory_mem_dqs                              => CONNECTED_TO_memory_mem_dqs,                              --                          .mem_dqs
			memory_mem_dqs_n                            => CONNECTED_TO_memory_mem_dqs_n,                            --                          .mem_dqs_n
			memory_mem_odt                              => CONNECTED_TO_memory_mem_odt,                              --                          .mem_odt
			memory_1_mem_a                              => CONNECTED_TO_memory_1_mem_a,                              --                  memory_1.mem_a
			memory_1_mem_ba                             => CONNECTED_TO_memory_1_mem_ba,                             --                          .mem_ba
			memory_1_mem_ck                             => CONNECTED_TO_memory_1_mem_ck,                             --                          .mem_ck
			memory_1_mem_ck_n                           => CONNECTED_TO_memory_1_mem_ck_n,                           --                          .mem_ck_n
			memory_1_mem_cke                            => CONNECTED_TO_memory_1_mem_cke,                            --                          .mem_cke
			memory_1_mem_cs_n                           => CONNECTED_TO_memory_1_mem_cs_n,                           --                          .mem_cs_n
			memory_1_mem_dm                             => CONNECTED_TO_memory_1_mem_dm,                             --                          .mem_dm
			memory_1_mem_ras_n                          => CONNECTED_TO_memory_1_mem_ras_n,                          --                          .mem_ras_n
			memory_1_mem_cas_n                          => CONNECTED_TO_memory_1_mem_cas_n,                          --                          .mem_cas_n
			memory_1_mem_we_n                           => CONNECTED_TO_memory_1_mem_we_n,                           --                          .mem_we_n
			memory_1_mem_reset_n                        => CONNECTED_TO_memory_1_mem_reset_n,                        --                          .mem_reset_n
			memory_1_mem_dq                             => CONNECTED_TO_memory_1_mem_dq,                             --                          .mem_dq
			memory_1_mem_dqs                            => CONNECTED_TO_memory_1_mem_dqs,                            --                          .mem_dqs
			memory_1_mem_dqs_n                          => CONNECTED_TO_memory_1_mem_dqs_n,                          --                          .mem_dqs_n
			memory_1_mem_odt                            => CONNECTED_TO_memory_1_mem_odt,                            --                          .mem_odt
			mgmt_clk_clk                                => CONNECTED_TO_mgmt_clk_clk,                                --                  mgmt_clk.clk
			mgmt_rst_reset                              => CONNECTED_TO_mgmt_rst_reset,                              --                  mgmt_rst.reset
			oct_rzqin                                   => CONNECTED_TO_oct_rzqin,                                   --                       oct.rzqin
			oct_1_rzqin                                 => CONNECTED_TO_oct_1_rzqin,                                 --                     oct_1.rzqin
			pcie_npor_npor                              => CONNECTED_TO_pcie_npor_npor,                              --                 pcie_npor.npor
			pcie_npor_pin_perst                         => CONNECTED_TO_pcie_npor_pin_perst,                         --                          .pin_perst
			pcie_refclock_clk                           => CONNECTED_TO_pcie_refclock_clk,                           --             pcie_refclock.clk
			reconfig_xcvr_clk_clk                       => CONNECTED_TO_reconfig_xcvr_clk_clk,                       --         reconfig_xcvr_clk.clk
			reconfig_xcvr_rst_reset                     => CONNECTED_TO_reconfig_xcvr_rst_reset,                     --         reconfig_xcvr_rst.reset
			reset_reset_n                               => CONNECTED_TO_reset_reset_n,                               --                     reset.reset_n
			reset_1_reset_n                             => CONNECTED_TO_reset_1_reset_n,                             --                   reset_1.reset_n
			slow_mem_address                            => CONNECTED_TO_slow_mem_address,                            --                  slow_mem.address
			slow_mem_read                               => CONNECTED_TO_slow_mem_read,                               --                          .read
			slow_mem_readdata                           => CONNECTED_TO_slow_mem_readdata,                           --                          .readdata
			slow_mem_readdatavalid                      => CONNECTED_TO_slow_mem_readdatavalid,                      --                          .readdatavalid
			slow_mem_write                              => CONNECTED_TO_slow_mem_write,                              --                          .write
			slow_mem_writedata                          => CONNECTED_TO_slow_mem_writedata,                          --                          .writedata
			slow_mem_waitrequest                        => CONNECTED_TO_slow_mem_waitrequest,                        --                          .waitrequest
			slow_mem_burstcount                         => CONNECTED_TO_slow_mem_burstcount,                         --                          .burstcount
			slow_mem_lock                               => CONNECTED_TO_slow_mem_lock                                --                          .lock
		);

