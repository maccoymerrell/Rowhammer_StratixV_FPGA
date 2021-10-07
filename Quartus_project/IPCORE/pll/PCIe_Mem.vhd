-- Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus Prime License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity PCIe_Mem is
	port
	(
-- {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!

		altera_reserved_ntrst : in std_logic;
		altera_reserved_tck : in std_logic;
		altera_reserved_tdi : in std_logic;
		altera_reserved_tdo : out std_logic;
		altera_reserved_tms : in std_logic;
		clk_100 : in std_logic;
		ddr2_clk : in std_logic;
		mem2_a : out std_logic_vector(15 downto 0);
		mem2_ba : out std_logic_vector(2 downto 0);
		mem2_cas_n : out std_logic_vector(0 downto 0);
		mem2_ck : out std_logic_vector(1 downto 0);
		mem2_ck_n : out std_logic_vector(1 downto 0);
		mem2_cke : out std_logic_vector(1 downto 0);
		mem2_cs_n : out std_logic_vector(1 downto 0);
		mem2_dm : out std_logic_vector(7 downto 0);
		mem2_dq : inout std_logic_vector(63 downto 0);
		mem2_dqs : inout std_logic_vector(7 downto 0);
		mem2_dqs_n : inout std_logic_vector(7 downto 0);
		mem2_odt : out std_logic_vector(1 downto 0);
		mem2_ras_n : out std_logic_vector(0 downto 0);
		mem2_reset_n : out std_logic;
		mem2_we_n : out std_logic_vector(0 downto 0);
		oct2_rzqin : in std_logic;
		pcie1_refclk : in std_logic;
		pcie_perst : in std_logic;
		serial_pcie1_rx_in0 : in std_logic;
		serial_pcie1_rx_in1 : in std_logic;
		serial_pcie1_rx_in2 : in std_logic;
		serial_pcie1_rx_in3 : in std_logic;
		serial_pcie1_tx_out0 : out std_logic;
		serial_pcie1_tx_out1 : out std_logic;
		serial_pcie1_tx_out2 : out std_logic;
		serial_pcie1_tx_out3 : out std_logic;
		oct4_rzqin : in std_logic
-- {ALTERA_IO_END} DO NOT REMOVE THIS LINE!

	);

-- {ALTERA_ATTRIBUTE_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_ATTRIBUTE_END} DO NOT REMOVE THIS LINE!
end PCIe_Mem;

architecture ppl_type of PCIe_Mem is

-- {ALTERA_COMPONENTS_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_COMPONENTS_END} DO NOT REMOVE THIS LINE!
begin
-- {ALTERA_INSTANTIATION_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_INSTANTIATION_END} DO NOT REMOVE THIS LINE!

end;
