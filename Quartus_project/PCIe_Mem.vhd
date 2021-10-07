-- ==============================================================================
--
-- File Name: PCIe_Mem.vhd
--  
-- Authors	: Nikhil Kannanthra <nikhil.kannanthra@vvdntech.com>
--
-- Project	: FSLU_NVME : iSSD Storage Card Development.
-- Company 	: VVDN Technologies Pvt. Ltd
--
-- ==============================================================================
--
-- Copyright (c) 2013 VVDN Technologies Pvt. Ltd.   http://www.vvdntech.com/ 
-- All rights reserved.
--	
-- This file is owned and controlled by VVDN Technologies Pvt. Ltd. and must be 
-- used solely for design, simulation, implementation and creation of design files
-- used in conjunction with Texas Instruments Inc. devices or technologies.
-- Use in other designs is expressly prohibited and immediately terminates the
-- license to use this file.
--
-- This file is provided without any express or implied warranties, including, but
-- not limited to, the implied warranties of merchantability and fitness for a 
-- particular purpose. It is not intended for use in life support appliances, 
-- devices, or systems. Use in such applications is expressly prohibited.
--
-- VVDN Technologies Pvt. Ltd. and Texas Instruments Inc. make no guarantee or 
-- representation regarding the use of, or the results of the use of, the software
-- and documentation in terms of correctness, accuracy, reliability, currentness, or
-- otherwise; Reliance upon the results, software, or documentation is solely at the
-- users own risk.
--
-- ==============================================================================
--
-- $Revision: 1.0 $ $Date: 2013/04/19 09:00 AM $
--
-- Description:
-- Top file for PCIE/DDR3/NVME/SFL Blocks
-- 
--
--
-- Target Device	: 5SGGSMD5K2F40C2 
-- Device Family 	: ALTERA Stratix V 
-- Synthesis Tool	: Quartus II Subscription Edition 14.1
------------------------------------------------------------------------------------------
-- Revision : 1.1 $ Date:
------------------------------------------------------------------------------------------

LIBRARY ieee ;
USE ieee.std_logic_1164.ALL ;


entity PCIe_Mem is
        port (
            
				clk_100						: in  std_logic; -- clk
				pcie_perst 		  : in  std_logic;  -- pin_perst
				
            --========================== PCIe Left ==========================--
				pcie1_refclk		      : in  std_logic; -- clk
				
				serial_pcie1_rx_in0    : in  std_logic; -- rx_in0
            serial_pcie1_rx_in1    : in  std_logic; -- rx_in1
            serial_pcie1_rx_in2    : in  std_logic; -- rx_in2
            serial_pcie1_rx_in3    : in  std_logic; -- rx_in3
            serial_pcie1_tx_out0   : out std_logic;        -- tx_out0
            serial_pcie1_tx_out1   : out std_logic;        -- tx_out1
            serial_pcie1_tx_out2   : out std_logic;        -- tx_out2
            serial_pcie1_tx_out3   : out std_logic;        -- tx_out3
				

				--========================== M2 ==========================--
				mem2_a            : out   std_logic_vector(15 downto 0);                    -- mem_a
            mem2_ba           : out   std_logic_vector(2 downto 0);                     -- mem_ba
            mem2_ck           : out   std_logic_vector(1 downto 0);                     -- mem_ck
            mem2_ck_n         : out   std_logic_vector(1 downto 0);                     -- mem_ck_n
            mem2_cke          : out   std_logic_vector(1 downto 0);                     -- mem_cke
            mem2_cs_n         : out   std_logic_vector(1 downto 0);                     -- mem_cs_n
            mem2_dm           : out   std_logic_vector(7 downto 0);                     -- mem_dm
            mem2_ras_n        : out   std_logic_vector(0 downto 0);                     -- mem_ras_n
            mem2_cas_n        : out   std_logic_vector(0 downto 0);                     -- mem_cas_n
            mem2_we_n         : out   std_logic_vector(0 downto 0);                     -- mem_we_n
            mem2_reset_n      : out   std_logic;                                        -- mem_reset_n
            mem2_dq           : inout std_logic_vector(63 downto 0) := (others => 'X'); -- mem_dq
            mem2_dqs          : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dqs
            mem2_dqs_n        : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dqs_n
            mem2_odt          : out   std_logic_vector(1 downto 0);                     -- mem_odt
            oct2_rzqin        : in    std_logic                     := 'X';             -- rzqin
            ddr2_clk          : in    std_logic                     := 'X';            -- clk
				
				--========================== M4 ==========================--
				mem4_a            : out   std_logic_vector(15 downto 0);                    -- mem4_a
            mem4_ba           : out   std_logic_vector(2 downto 0);                     -- mem4_ba
            mem4_ck           : out   std_logic_vector(1 downto 0);                     -- mem4_ck
            mem4_ck_n         : out   std_logic_vector(1 downto 0);                     -- mem4_ck_n
            mem4_cke          : out   std_logic_vector(1 downto 0);                     -- mem4_cke
            mem4_cs_n         : out   std_logic_vector(1 downto 0);                     -- mem4_cs_n
            mem4_dm           : out   std_logic_vector(7 downto 0);                     -- mem4_dm
            mem4_ras_n        : out   std_logic_vector(0 downto 0);                     -- mem4_ras_n
            mem4_cas_n        : out   std_logic_vector(0 downto 0);                     -- mem4_cas_n
            mem4_we_n         : out   std_logic_vector(0 downto 0);                     -- mem4_we_n
            mem4_reset_n      : out   std_logic;                                        -- mem4_reset_n
            mem4_dq           : inout std_logic_vector(63 downto 0) := (others => 'X'); -- mem4_dq
            mem4_dqs          : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem4_dqs
            mem4_dqs_n        : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem4_dqs_n
            mem4_odt          : out   std_logic_vector(1 downto 0);                     -- mem4_odt
            oct4_rzqin        : in    std_logic                     := 'X';             -- rzqin
            ddr4_clk          : in    std_logic                     := 'X'           -- clk

				

				
        );
		end entity;
architecture schematics of PCIe_Mem is

signal hip_ctrl_test_in : std_logic_vector(31 downto 0);

signal clk_50		: std_logic;
signal lock		: std_logic;
------------ ASMI and Flash Programming ------
signal	asmi_sfl_address_s     				  :  std_logic_vector(7 downto 0);                    -- sfl_address
signal	asmi_sfl_read_s        				  :  std_logic;                                        -- sfl_read
signal	asmi_data_from_sfl_s   				  :  std_logic_vector(31 downto 0); -- data_from_sfl
signal	asmi_sfl_write_s      				  :  std_logic;                                        -- sfl_write
signal	asmi_data_to_sfl_s     				  :  std_logic_vector(31 downto 0);                    -- data_to_sfl
signal	clk_250m         				  		  :  std_logic;                                        -- sfl_clk
signal	asmi_sfl_reset_s      				  :  std_logic;  
signal	clk_20m   		   				  	  :  std_logic;
----------	

	component pll_50 is
		port (
			refclk   : in  std_logic := 'X'; -- clk
			rst      : in  std_logic := 'X'; -- reset
			outclk_0 : out std_logic--;        -- clk
--			locked   : out std_logic         -- export
		);
	end component pll_50;

	component pll is
	port (
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic         -- outclk0.clk
	);
	end component;
	
	
 component pcie_hip_avmm is
        port (
            hip_ctrl_test_in        : in    std_logic_vector(31 downto 0) := (others => 'X'); -- test_in
            hip_ctrl_simu_mode_pipe : in    std_logic                     := 'X';             -- simu_mode_pipe
            hip_serial_rx_in0       : in    std_logic                     := 'X';             -- rx_in0
            hip_serial_rx_in1       : in    std_logic                     := 'X';             -- rx_in1
            hip_serial_rx_in2       : in    std_logic                     := 'X';             -- rx_in2
            hip_serial_rx_in3       : in    std_logic                     := 'X';             -- rx_in3
            hip_serial_tx_out0      : out   std_logic;                                        -- tx_out0
            hip_serial_tx_out1      : out   std_logic;                                        -- tx_out1
            hip_serial_tx_out2      : out   std_logic;                                        -- tx_out2
            hip_serial_tx_out3      : out   std_logic;                                        -- tx_out3
            mgmt_clk_clk            : in    std_logic                     := 'X';             -- clk
            mgmt_rst_reset          : in    std_logic                     := 'X';             -- reset
            pcie_npor_npor          : in    std_logic                     := 'X';             -- npor
            pcie_npor_pin_perst     : in    std_logic                     := 'X';             -- pin_perst
            pcie_refclock_clk         : in    std_logic                     := 'X';             -- clk
            reconfig_xcvr_clk_clk   : in    std_logic                     := 'X';             -- clk
            reconfig_xcvr_rst_reset : in    std_logic                     := 'X';             -- reset
           
				memory_mem_a            : out   std_logic_vector(15 downto 0);                    -- mem_a
            memory_mem_ba           : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_mem_ck           : out   std_logic_vector(1 downto 0);                     -- mem_ck
            memory_mem_ck_n         : out   std_logic_vector(1 downto 0);                     -- mem_ck_n
            memory_mem_cke          : out   std_logic_vector(1 downto 0);                     -- mem_cke
            memory_mem_cs_n         : out   std_logic_vector(1 downto 0);                     -- mem_cs_n
            memory_mem_dm           : out   std_logic_vector(7 downto 0);                     -- mem_dm
            memory_mem_ras_n        : out   std_logic_vector(0 downto 0);                     -- mem_ras_n
            memory_mem_cas_n        : out   std_logic_vector(0 downto 0);                     -- mem_cas_n
            memory_mem_we_n         : out   std_logic_vector(0 downto 0);                     -- mem_we_n
            memory_mem_reset_n      : out   std_logic;                                        -- mem_reset_n
            memory_mem_dq           : inout std_logic_vector(63 downto 0) := (others => 'X'); -- mem_dq
            memory_mem_dqs          : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dqs
            memory_mem_dqs_n        : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dqs_n
            memory_mem_odt          : out   std_logic_vector(1 downto 0);                     -- mem_odt
            oct_rzqin               : in    std_logic                     := 'X';             -- rzqin
            clk_clk                 : in    std_logic                     := 'X';             -- clk
            reset_reset_n           : in    std_logic                     := 'X';              -- reset_n
				memory_1_mem_a            : out   std_logic_vector(15 downto 0);                    -- mem_a
            memory_1_mem_ba           : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_1_mem_ck           : out   std_logic_vector(1 downto 0);                     -- mem_ck
            memory_1_mem_ck_n         : out   std_logic_vector(1 downto 0);                     -- mem_ck_n
            memory_1_mem_cke          : out   std_logic_vector(1 downto 0);                     -- mem_cke
            memory_1_mem_cs_n         : out   std_logic_vector(1 downto 0);                     -- mem_cs_n
            memory_1_mem_dm           : out   std_logic_vector(7 downto 0);                     -- mem_dm
            memory_1_mem_ras_n        : out   std_logic_vector(0 downto 0);                     -- mem_ras_n
            memory_1_mem_cas_n        : out   std_logic_vector(0 downto 0);                     -- mem_cas_n
            memory_1_mem_we_n         : out   std_logic_vector(0 downto 0);                     -- mem_we_n
            memory_1_mem_reset_n      : out   std_logic;                                        -- mem_reset_n
            memory_1_mem_dq           : inout std_logic_vector(63 downto 0) := (others => 'X'); -- mem_dq
            memory_1_mem_dqs          : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dqs
            memory_1_mem_dqs_n        : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dqs_n
            memory_1_mem_odt          : out   std_logic_vector(1 downto 0);                     -- mem_odt
            oct_1_rzqin               : in    std_logic                     := 'X';             -- rzqin
            clk_1_clk                 : in    std_logic                     := 'X';             -- clk
            reset_1_reset_n           : in    std_logic                     := 'X';      
				
				
				avl_to_asmi_0_conduit_end_sfl_address               : out std_logic_vector(7 downto 0);                     --         avl_to_asmi_0_conduit_end.sfl_address
				avl_to_asmi_0_conduit_end_sfl_read                  : out std_logic;                                        --                                  .sfl_read
				avl_to_asmi_0_conduit_end_sfl_readdata_from         : in  std_logic_vector(31 downto 0) := (others => '0'); --                                  .sfl_readdata_from
				avl_to_asmi_0_conduit_end_sfl_write                 : out std_logic;                                        --                                  .sfl_write
				avl_to_asmi_0_conduit_end_sfl_writedata_to          : out std_logic_vector(31 downto 0);                    --                                  .sfl_writedata_to
				avl_to_asmi_0_conduit_end_sfl_clk                   : out std_logic;                                        --                                  .sfl_clk
				avl_to_asmi_0_conduit_end_sfl_reset                 : out std_logic
		  
            
			
		  
		  );
    end component pcie_hip_avmm;
	component epcq_top is
	port
	(	clk_250m        		: in std_logic;      						-- 250MHz Clock coming from PCIe interface                  	
		clk_20m					: in std_logic;								-- 20MHz Clock coming from the PLL
		asmi_sfl_reset      	: in std_logic;                      	-- Reset signal from Avalon MM simple slave interface
		asmi_sfl_read        : in std_logic;                     	-- Read strobe from Avalon MM simple slave interface 	 
		asmi_sfl_write      	: in std_logic;                      	-- Write strobe from Avalon MM simple slave interface
		asmi_sfl_address		: in std_logic_vector(7 downto 0);    	-- Address from the Avalon MM simple slave interface
		asmi_data_to_sfl     : in std_logic_vector(31 downto 0);		-- Data input to the epcq top module from Avalon MM simple slave interface 
		asmi_data_from_sfl   : out std_logic_vector(31 downto 0) 	-- Data output from epcq top module to Avalon MM simple slave interface 	);
	);
	end component;
	 



        component atu_ez is
	port (
			atu_interface_bar_rst_reset                 : in   std_logic                       ;                  -- reset
			atu_interface_ddr_rst_reset                 : in   std_logic                        ;                 -- reset
			atu_interface_from_bar_read                 : in   std_logic;                                         -- read
			atu_interface_from_bar_address              : in   std_logic_vector(63 downto 0);                     -- address
			atu_interface_from_bar_waitrequest          : out    std_logic                      := 'X';             -- waitrequest
			atu_interface_from_bar_write                : in   std_logic;                                         -- write
			atu_interface_from_bar_readdatavalid        : out    std_logic                      := 'X';             -- readdatavalid
			atu_interface_from_bar_readdata             : out    std_logic_vector(127 downto 0) := (others => 'X'); -- readdata
			atu_interface_from_bar_writedata            : in   std_logic_vector(127 downto 0);                    -- writedata
			atu_interface_from_bar_burstcount           : in   std_logic_vector(5 downto 0);                      -- burstcount
			atu_interface_from_bar_byteenable           : in   std_logic_vector(15 downto 0);                     -- byteenable
			atu_interface_to_ddr_address                : out    std_logic_vector(63 downto 0)  := (others => 'X'); -- address
			atu_interface_to_ddr_burstcount             : out    std_logic_vector(5 downto 0)   := (others => 'X'); -- burstcount
			atu_interface_to_ddr_byteenable             : out    std_logic_vector(15 downto 0)  := (others => 'X'); -- byteenable
			atu_interface_to_ddr_read                   : out    std_logic                      := 'X';             -- read
			atu_interface_to_ddr_readdata               : in   std_logic_vector(127 downto 0);                    -- readdata
			atu_interface_to_ddr_readdatavalid          : in   std_logic;                                         -- readdatavalid
			atu_interface_to_ddr_waitrequest            : in   std_logic;                                         -- waitrequest
			atu_interface_to_ddr_write                  : out    std_logic                      := 'X';             -- write
			atu_interface_to_ddr_writedata              : out    std_logic_vector(127 downto 0) := (others => 'X') -- writedata
	);
        end component ;































begin

	hip_ctrl_test_in(4 downto 0)  <=  "01000";
	hip_ctrl_test_in(5) 			   <=  '1';
	hip_ctrl_test_in(31 downto 6) <=  "00" & X"000002";
	
--	mem_a(15 downto 14) <= "00";
--			mem_cs_n(1) <= '1';
--			mem_cke(1) <= '0';
--			mem_odt(1) <= '0';
--	
--	mem1_a(15 downto 14) <= "00";
--			mem1_cs_n(1) <= '1';
--			mem1_cke(1) <= '0';
--			mem1_odt(1) <= '0';
			

u0  :  component pcie_hip_avmm 
        port map (
            hip_ctrl_test_in        => hip_ctrl_test_in,
            hip_ctrl_simu_mode_pipe => '1',
            hip_serial_rx_in0       => serial_pcie1_rx_in0,    -- rx_in0
            hip_serial_rx_in1       => serial_pcie1_rx_in1,    -- rx_in1
            hip_serial_rx_in2       => serial_pcie1_rx_in2,    -- rx_in2
            hip_serial_rx_in3       => serial_pcie1_rx_in3,    -- rx_in3
            hip_serial_tx_out0      => serial_pcie1_tx_out0,   -- tx_out0
            hip_serial_tx_out1      => serial_pcie1_tx_out1,   -- tx_out1
            hip_serial_tx_out2      => serial_pcie1_tx_out2,   -- tx_out2
            hip_serial_tx_out3      => serial_pcie1_tx_out3,   -- tx_out3
            mgmt_clk_clk            => clk_50,       
            mgmt_rst_reset          => not(pcie_perst),
            pcie_npor_npor          => pcie_perst,
            pcie_npor_pin_perst     => pcie_perst,
            pcie_refclock_clk         => pcie1_refclk,
            reconfig_xcvr_clk_clk   => clk_50,
            reconfig_xcvr_rst_reset => not(pcie_perst),
				
            memory_mem_a             => mem2_a(15 downto 0),
            memory_mem_ba            => mem2_ba,
            memory_mem_ck            => mem2_ck,
            memory_mem_ck_n          => mem2_ck_n,
            memory_mem_cke           => mem2_cke(1 downto 0),
            memory_mem_cs_n          => mem2_cs_n(1 downto 0),
            memory_mem_dm            => mem2_dm,
            memory_mem_ras_n         => mem2_ras_n,
            memory_mem_cas_n         => mem2_cas_n,
            memory_mem_we_n          => mem2_we_n,
            memory_mem_reset_n       => mem2_reset_n,
            memory_mem_dq            => mem2_dq,
            memory_mem_dqs           => mem2_dqs,
            memory_mem_dqs_n         => mem2_dqs_n,
            memory_mem_odt           => mem2_odt(1 downto 0),
            oct_rzqin                => oct2_rzqin,
            clk_clk                  => ddr2_clk,
            reset_reset_n            => pcie_perst,
            
            
            memory_1_mem_a             => mem4_a(15 downto 0),
            memory_1_mem_ba            => mem4_ba,
            memory_1_mem_ck            => mem4_ck,
            memory_1_mem_ck_n          => mem4_ck_n,
            memory_1_mem_cke           => mem4_cke(1 downto 0),
            memory_1_mem_cs_n          => mem4_cs_n(1 downto 0),
            memory_1_mem_dm            => mem4_dm,
            memory_1_mem_ras_n         => mem4_ras_n,
            memory_1_mem_cas_n         => mem4_cas_n,
            memory_1_mem_we_n          => mem4_we_n,
            memory_1_mem_reset_n       => mem4_reset_n,
            memory_1_mem_dq            => mem4_dq,
            memory_1_mem_dqs           => mem4_dqs,
            memory_1_mem_dqs_n         => mem4_dqs_n,
            memory_1_mem_odt           => mem4_odt(1 downto 0),
            oct_1_rzqin                => oct4_rzqin,
            clk_1_clk                  => ddr4_clk,
            reset_1_reset_n            => pcie_perst,
				
				
				avl_to_asmi_0_conduit_end_sfl_address       			=> asmi_sfl_address_s,  
				avl_to_asmi_0_conduit_end_sfl_read          			=> asmi_sfl_read_s,     
				avl_to_asmi_0_conduit_end_sfl_readdata_from 			=> asmi_data_from_sfl_s,
				avl_to_asmi_0_conduit_end_sfl_write         			=> asmi_sfl_write_s,    
				avl_to_asmi_0_conduit_end_sfl_writedata_to  			=> asmi_data_to_sfl_s,  
				avl_to_asmi_0_conduit_end_sfl_clk           			=> clk_250m,           	
				avl_to_asmi_0_conduit_end_sfl_reset         			=> asmi_sfl_reset_s


        );
asmi:component epcq_top 
	port map(
			clk_250m         		=> clk_250m,
			clk_20m					=> clk_20m,
			asmi_sfl_reset      	=> asmi_sfl_reset_s,	
			asmi_sfl_address    	=> asmi_sfl_address_s,
			asmi_sfl_read        => asmi_sfl_read_s,
			asmi_data_from_sfl   => asmi_data_from_sfl_s,
			asmi_sfl_write      	=> asmi_sfl_write_s,
			asmi_data_to_sfl     => asmi_data_to_sfl_s
		);

asmi_clk20m:component pll 
	port map (
		refclk   =>	clk_100,
		rst      => asmi_sfl_reset_s,
		outclk_0 => clk_20m
	);

		  	xcvr_clk50:	  	component pll_50 
		port map(
			refclk    => clk_100,-- clk
			rst       => not(pcie_perst),-- reset
			outclk_0  => clk_50--,-- clk
			
		);
		  



		  
		  
--
--		  mem_cs_n(1) <= '1';
--		  mem_cke(1) <= '0';
--		  mem_odt(1) <= '0';
--		  
--u1 : component pcie_hip_avmm
--        port map (
--            hip_serial_rx_in0           => serial_pcie2_rx_in0,           --          hip_serial.rx_in0
--            hip_serial_rx_in1           => serial_pcie2_rx_in1,           --                    .rx_in1
--            hip_serial_rx_in2           => serial_pcie2_rx_in2,           --                    .rx_in2
--            hip_serial_rx_in3           => serial_pcie2_rx_in3,           --                    .rx_in3
--            hip_serial_tx_out0          => serial_pcie2_tx_out0,          --                    .tx_out0
--            hip_serial_tx_out1          => serial_pcie2_tx_out1,          --                    .tx_out1
--            hip_serial_tx_out2          => serial_pcie2_tx_out2,          --                    .tx_out2
--            hip_serial_tx_out3          => serial_pcie2_tx_out3,          --                    .tx_out3
--
--            pcie_npor_npor              => pcie_perst,              --           pcie_npor.npor
--            pcie_npor_pin_perst         => pcie_perst,         --                    .pin_perst
--            mgmt_clk_clk            	 => clk_50_s,            --          mgmt_clk.clk
--            mgmt_rst_reset          	 => not(pcie_perst),          --          mgmt_rst.reset
--            reconfig_xcvr_clk_clk   	 => clk_50_s,   -- reconfig_xcvr_clk.clk
--            reconfig_xcvr_rst_reset 	 => not(pcie_perst),  
--            pcie_refclk_clk             => pcie2_refclk,              --         pcie_refclk.clk
--				hip_ctrl_test_in            => hip_ctrl_test_in,            --            hip_ctrl.test_in
--            hip_ctrl_simu_mode_pipe     => '1'      --                    .simu_mode_pipe
--        );


--------------------------------------------------------------------------------------------------		



		  
end schematics;
		
