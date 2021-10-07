-- ============================================================================
--
-- File Name: epcq_registers.vhd
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
-- Description:  Top for EPCQ Flash Upgradation Logic Registers
--
-- Target Device	: 5SGXEA3K3F40C4
-- Device Family 	: ALTERA Stratix V 
-- Synthesis Tool	: Quartus II Subscription Edition 14.1
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library altera_mf;
use altera_mf.all;

entity epcq_registers is
port
	(		
		clk_250m				: in std_logic;									-- Clock 250MHz for reading/writing data to the registers
		clk_20m        	: in std_logic;                       		-- Clock 20MHz for processing the data
		reset     			: in std_logic;                        	-- Reset signal	
			
		wr_strobe_in  		: in std_logic;  									-- Write strobe from Avalon MM simple slave interface
		rd_strobe_in		: in std_logic;									-- Read strobe from Avalon MM simple slave interface
		reg_addres_in		: in std_logic_vector(7 downto 0);			-- Register address from Avalon MM simple slave interface 
		reg_data_in			: in std_logic_vector(31 downto 0);			-- Data input from Avalon MM simple slave interface
		reg_data_out		: out std_logic_vector(31 downto 0);		-- Data output from Avalon MM simple slave interface
		
		fifo_data_out		: out std_logic_vector(31 downto 0);		-- Configuration data input for fifo32x64
		fifo_wr_out			: out std_logic;									-- Write strobe for fifo32x64
		
		asmi_busy_in		: in std_logic;									-- Busy signal from ASMI IP   
		data_valid_in		: in std_logic;									-- Data valid signal from ASMI IP 
		wr_done_in			: in std_logic;									-- Write done input signal from epcq_wr_block 
		epcq_id_in			: in std_logic_vector(7 downto 0);			-- EPCQ256 ID from ASMI IP
		epcq_status_in		: in std_logic_vector(7 downto 0);			-- EPCQ256 status from ASMI IP
		epcq_data_in		: in std_logic_vector(7 downto 0);			-- EPCQ256 read data from ASMI IP
		
		asmi_ip_reset_out	: out std_logic;									-- Reset signal to the ASMI IP
		bulk_erase_out		: out std_logic;									-- Bulk erase signal to the ASMI IP
		epcq_status_out	: out std_logic;									-- Read status request signal to the ASMI IP
		epcq_id_out			: out std_logic;									-- Read EPCQ256 memory capacity ID request to the ASMI IP
		epcq_wr_out			: out std_logic;									-- Data write strobe to the epcq_wr_data block 
		epcq_rd_out			: out std_logic;									-- Data read request to ASMI IP
		en4b_addr_out		: out std_logic;									-- Enable 4 byte address mode request to ASMI IP
		byte_const_out 	: out std_logic_vector(7 downto 0);			-- No of byte to write from FIFO to epcq_wr_block
		epcq_addr_out		: out std_logic_vector(31 downto 0)			-- Address to the ASMI IP	
	);
end epcq_registers;

architecture Behavioral of epcq_registers is
----------------------------------- CONSTANT ADDRESSES FOR SFL REGISTER -----------------------------------------
constant cntrl_status_addr_c 	: std_logic_vector (7 downto 0) := x"00"; 	--  STATUS/control register address
constant epcq_device_id_c		: std_logic_vector (7 downto 0) := X"01"; 	--  EPCQ Device ID register address 
constant epcq_status_c			: std_logic_vector (7 downto 0) := X"02"; 	--  EPCQ Status register address 
constant epcq_wr_data_c			: std_logic_vector (7 downto 0) := X"03"; 	--  EPCQ write register address 
constant epcq_rd_data_c			: std_logic_vector (7 downto 0) := X"04"; 	--  EPCQ read register address
constant epcq_addr_c			: std_logic_vector (7 downto 0) := X"05"; 	--  EPCQ address register address
constant byte_constant_c		: std_logic_vector (7 downto 0) := X"06"; 	--  Byte constant register address 
constant version_num_reg_c   	: std_logic_vector (7 downto 0) := X"07"; 	--  Byte constant register address 

----------------------------------------------------------------------------------------------------------------
constant version_number_c    	: std_logic_vector (31 downto 0) := X"0001000b"; 	--  Byte constant register address 

-- Below signals which stores the control register bits
signal asmi_ip_reset_s			: std_logic;
signal bulk_erase_s				: std_logic;
signal epcq_status_s				: std_logic;
signal epcq_id_s					: std_logic;
signal epcq_rd_s					: std_logic;
signal epcq_wr_s					: std_logic;
signal en4b_addr_s				: std_logic;
-- Signals used to latch the data from 250MHz clock 
signal reg_addres_s				: std_logic_vector(7 downto 0);
signal reg_data_s					: std_logic_vector(31 downto 0);
-- Signals used to store the data and address
signal data_out_s 				: std_logic_vector(31 downto 0);
signal epcq_addr_s 				: std_logic_vector(31 downto 0);
signal epcq_data_s 				: std_logic_vector(31 downto 0);
signal no_of_byte_s 				: std_logic_vector(7 downto 0);
-- List of signals used for detecting the positive edges of the control signals
signal wen_dly0					: std_logic;
signal wen_pos_s					: std_logic;

signal rden_dly0					: std_logic;
signal rden_pos_s					: std_logic;

signal busy_dly0 					: std_logic;
signal busy_fal_s 				: std_logic;

signal erase_dly0 				: std_logic;
signal erase_pos_s 				: std_logic;

signal en4b_dly0 					: std_logic;
signal en4b_pos_s 				: std_logic;

signal status_dly0 				: std_logic;
signal status_pos_s 				: std_logic;

signal rd_id_dly0 				: std_logic;
signal rd_id_pos_s 				: std_logic;

signal data_rd_dly0 				: std_logic;
signal data_rd_pos_s 			: std_logic;

signal data_wr_dly0 				: std_logic;
signal data_wr_pos_s 			: std_logic;

begin 
----------------------------------------------------------------------
-- Detecting positive edge of write and read request to the registers
----------------------------------------------------------------------
process(clk_250m)
begin
	if rising_edge(clk_250m) then
		if reset = '1' then
			wen_dly0 	<= '0';
			wen_pos_s 	<= '0';
			
			rden_dly0	<= '0';
			rden_pos_s	<= '0';
 		else	
			wen_dly0		<= wr_strobe_in;
			wen_pos_s 	<= wr_strobe_in  and (not wen_dly0); 
		
			rden_dly0 	<= rd_strobe_in;
			rden_pos_s	<= rd_strobe_in and (not rden_dly0);
		end if;	
	end if;	
end process;
----------------------------------------------------------------------
-- Registering the address and data according to the write and read strobe
----------------------------------------------------------------------
process(clk_250m)
begin
	if rising_edge(clk_250m) then
		if reset = '1' then
			reg_addres_s <= (others =>'0');
			reg_data_s <= (others =>'0');
 		elsif wr_strobe_in = '1' then 				
			reg_addres_s <= reg_addres_in;
			reg_data_s <= reg_data_in ;
		elsif rd_strobe_in ='1' then
			reg_addres_s <= reg_addres_in;		
		end if;	
	end if;	
end process;
----------------------------------------------------------------------
-- Writing data to the registers 
----------------------------------------------------------------------
process(clk_250m)
	begin
		if rising_edge(clk_250m) then	
			-- Assigning the reset values to the signals 
			if reset = '1' then
				asmi_ip_reset_s	<= '0';
				bulk_erase_s		<= '0';
				epcq_status_s		<= '0';
				epcq_id_s			<= '0';
				epcq_rd_s			<= '0';
				epcq_wr_s			<= '0';
				en4b_addr_s			<= '0';
				epcq_data_s			<= (others => '0');
				no_of_byte_s		<= (others => '0');
			end if;
			-- Storing the register values to the signals 	
			if reg_addres_s = cntrl_status_addr_c and wen_pos_s = '1' then 
				asmi_ip_reset_s	<= reg_data_s(0);
				bulk_erase_s		<= reg_data_s(1);
				epcq_status_s		<= reg_data_s(2);
				epcq_id_s			<= reg_data_s(3);
				epcq_rd_s			<= reg_data_s(4);
				epcq_wr_s			<= reg_data_s(5);
				en4b_addr_s			<= reg_data_s(6);
			end if;
			-- Clearing the signals(Auto clear bits)
			if busy_fal_s = '1' then 
				bulk_erase_s 	<= '0';
				epcq_status_s	<= '0';
				epcq_id_s 		<= '0';
				epcq_rd_s 		<= '0';
				en4b_addr_s 	<= '0';
			end if;
			-- Auto clearing the bits
			if wr_done_in = '1' then 
				epcq_wr_s 		<= '0';
			end if;
			-- Writing data which is to be written in FIFO  
			if reg_addres_s = epcq_wr_data_c and wen_pos_s = '1' then   
				epcq_data_s		<= reg_data_s;
			end if;
			-- Writing address which is to specify the EPCQ address  
			if reg_addres_s = epcq_addr_c  and wen_pos_s = '1' then  
				epcq_addr_s		<= reg_data_s;
			end if;
			-- Writing the no of bytes constant(Indicates how many bytes to fetch from FIFO)
			 if reg_addres_s = byte_constant_c  and wen_pos_s = '1' then  
				no_of_byte_s	<= reg_data_s(7 downto 0);
			end if;
			----------------------------------------------------------------------
		end if;
end process;
----------------------------------------------------------------------
-- Reading data from the registers
----------------------------------------------------------------------
process(clk_250m)
begin
	if rising_edge(clk_250m) then	
		if reset = '1' then 
			reg_data_out <= (others => '0');
		
		elsif rden_pos_s = '1' then
			-----------------------------------------------------------------
			case reg_addres_s is
			
				when cntrl_status_addr_c	=> 
				-- Reads the status bits  
				reg_data_out <=  x"000000" & '0' & en4b_addr_s & epcq_wr_s & epcq_rd_s & 
												epcq_id_s & epcq_status_s & bulk_erase_s & asmi_ip_reset_s; 		
				-- Reads the device ID of EPCQ256
				when epcq_device_id_c		=> reg_data_out <= x"000000" & epcq_id_in;
				-- Reads the status of EPCQ256
				when epcq_status_c			=> reg_data_out <= x"000000" & epcq_status_in;
				-- Reads the data from EPCQ256 at the specified address
				when epcq_rd_data_c			=> reg_data_out <= x"000000" & epcq_data_in;  
				-- Reads the address which is written to address register		
				when epcq_addr_c				=> reg_data_out <= epcq_addr_s;
				-- Read the no of bytes to be read from FIFO
				when byte_constant_c			=> reg_data_out <= x"000000" & no_of_byte_s;
				-- Read the version numebr of FPGA
				when version_num_reg_c		=> reg_data_out <= version_number_c;
				
				when others		 				=> reg_data_out <= X"FFFFFFFF";
			end case;
			-----------------------------------------------------------------	
		end if;	
	end if;
end process;
---------------------------------------------------------------
-- Generating the write strobe to write the configuration data
-- to the FIFO  
---------------------------------------------------------------
process(clk_250m)
begin 
	if rising_edge(clk_250m) then 
		if (reg_addres_s = epcq_wr_data_c and wen_pos_s = '1') then  
			fifo_wr_out <=	'1';
		else 
			fifo_wr_out <=	'0';
		end if; 
	end if;
end process;
-- configuration data is send to FIFO
fifo_data_out <= epcq_data_s;
-------------------------------------------------------------------
-- Generating the strobe signals for ASMI IP for proper operation
-------------------------------------------------------------------
process(clk_20m)
begin 
	if rising_edge(clk_20m) then 
		if reset = '1' then 
			busy_dly0		<= '0';
			busy_fal_s		<= '0';
		
			erase_dly0		<= '0';
			erase_pos_s		<= '0';
		
			status_dly0		<= '0';
			status_pos_s	<= '0';
		
			rd_id_dly0		<= '0';
			rd_id_pos_s		<= '0';
			
			data_rd_dly0	<= '0';	
			data_rd_pos_s	<= '0';
			
			data_wr_dly0 	<= '0';
			data_wr_pos_s 	<= '0';
			
			en4b_dly0 		<= '0';		
			en4b_pos_s 		<= '0';

		else
		
			busy_dly0  		<= asmi_busy_in;
			busy_fal_s		<= busy_dly0 and (not asmi_busy_in);
		
			erase_dly0		<= bulk_erase_s;
			erase_pos_s		<= bulk_erase_s and (not erase_dly0);
			
			status_dly0		<= epcq_status_s;
			status_pos_s	<= epcq_status_s and (not status_dly0);
			
			rd_id_dly0		<= epcq_id_s;
			rd_id_pos_s		<= epcq_id_s and (not rd_id_dly0);
			
			data_rd_dly0	<= epcq_rd_s;	
			data_rd_pos_s		<= epcq_rd_s and (not data_rd_dly0);							
			
			data_wr_dly0 	<= epcq_wr_s;
			data_wr_pos_s 	<= epcq_wr_s and (not data_wr_dly0); 
			
			en4b_dly0		<= en4b_addr_s;
			en4b_pos_s		<= en4b_addr_s and (not en4b_dly0);
		end if;
	end if;
end process;
-------------------------------------------------------------------
-- Driving the signals as per ASMI IP requirements
-------------------------------------------------------------------
process(clk_20m)
begin 
	if falling_edge(clk_20m) then	
		bulk_erase_out		<= erase_pos_s;
		epcq_status_out	<= status_pos_s;
		epcq_id_out			<= rd_id_pos_s;
		epcq_rd_out			<= data_rd_pos_s;
		epcq_wr_out			<= data_wr_pos_s;
		en4b_addr_out		<= en4b_pos_s;
	end if;
end process;
-------------------------------------------------------------------
-- Assigning the output signals
byte_const_out 	<= no_of_byte_s;	
epcq_addr_out 		<= epcq_addr_s;
asmi_ip_reset_out <= asmi_ip_reset_s;
-------------------------------------------------------------------
end Behavioral;