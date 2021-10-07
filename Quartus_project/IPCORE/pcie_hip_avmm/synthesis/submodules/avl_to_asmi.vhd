-- ============================================================================
--
-- File Name: avl_to_asmi.vhd
--  
-- Authors	: Irshad PP <irshad.pp@vvdntech.in >
--			 Venkadesh <venkatesh.r@vvdntech.com>
--
-- Project	: FSLU_NVME : iSSD Storage Card Development.
-- Company 	: VVDN Technologies Pvt. Ltd
--
-- ============================================================================
--
-- Copyright (c) 2013 VVDN Technologies Pvt. Ltd.   http://www.vvdntech.com/ 
-- All rights reserved.
--	
-- This file is owned and controlled by VVDN Technologies Pvt.Ltd. and must be 
-- used solely for design, simulation, implementation and creation of design 
-- Files used in conjunction with Freescale Inc , devices or technologies.
-- Use in other designs is expressly prohibited and immediately terminates the
-- License to use this file.
--
-- This file is provided without any express or implied warranties, including,
-- but not limited to, the implied warranties of merchantability and fitness 
-- for a particular purpose. It is not intended for use in life support 
-- appliances, devices, or systems. Use in such applications is expressly 
-- prohibited.
--
-- VVDN Technologies Pvt. Ltd  make no guarantee or representation regarding 
-- the use of, or the results of the use of, the software and documentation 
-- in terms of correctness, accuracy, reliability, correctness, or otherwise;
-- Reliance upon the results, software, or documentation is solely at the
-- users own risk.
--
-- ============================================================================
--
-- $Revision: 0.0 $ $Date: 2015/08/25 04:00 PM $
--
-- Description:  Module for Avalon MM interface for ASMI IP
--
-- Target Device	: 5SGXEA3K3F40C4
-- Device Family 	: ALTERA Stratix V 
-- Synthesis Tool	: Quartus II Subscription Edition 14.1

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity avl_to_asmi is
	port (
		avs_s0_address         : in  std_logic_vector(7 downto 0)  := (others => '0'); --          s0.address
		avs_s0_read            : in  std_logic                     := '0';             --            .read
		avs_s0_readdata        : out std_logic_vector(31 downto 0);                    --            .readdata
		avs_s0_write           : in  std_logic                     := '0';             --            .write
		avs_s0_writedata       : in  std_logic_vector(31 downto 0) := (others => '0'); --            .writedata
		clk                    : in  std_logic                     := '0';             --       clock.clk
		reset                  : in  std_logic                     := '0';             --       reset.reset
		asmi_sfl_address       : out std_logic_vector(7 downto 0);                     -- conduit_end.sfl_address
		asmi_sfl_read          : out std_logic;                                        --            .sfl_read
		asmi_sfl_readdata_from : in  std_logic_vector(31 downto 0) := (others => '0'); --            .sfl_readdata_from
		asmi_sfl_write         : out std_logic;                                        --            .sfl_write
		asmi_sfl_writedata_to  : out std_logic_vector(31 downto 0);                    --            .sfl_writedata_to
		asmi_sfl_clk           : out std_logic;                                        --            .sfl_clk
		asmi_sfl_reset         : out std_logic                                         --            .sfl_reset
	);
end entity avl_to_asmi;

architecture rtl of avl_to_asmi is
begin

	-- TODO: Auto-generated HDL template

	avs_s0_readdata <= asmi_sfl_readdata_from;

	asmi_sfl_reset <= reset ;

	asmi_sfl_read <= avs_s0_read;

	asmi_sfl_clk <= clk;

	asmi_sfl_address <= avs_s0_address;

	asmi_sfl_writedata_to <= avs_s0_writedata;

	asmi_sfl_write <= avs_s0_write;

end architecture rtl; -- of avl_to_asmi
