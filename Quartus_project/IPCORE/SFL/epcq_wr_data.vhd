-- ============================================================================
--
-- File Name: epcq_wr_data.vhd
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
-- Description:  Top for EPCQ Flash Data Write Logic
--
-- Target Device	: 5SGXEA3K3F40C4
-- Device Family 	: ALTERA Stratix V 
-- Synthesis Tool	: Quartus II Subscription Edition 14.1


library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library altera_mf;
use altera_mf.all;

entity epcq_wr_data is
port
	(			
		clk_20m          	: in std_logic; 								-- Clock 20MHz 	
		reset		 			: in std_logic;								-- Reset for initialize the internal logic
	
		asmi_busy_in		: in std_logic;								-- Busy signal from ASMI IP to indicate the progression of the write command
		data_wr_in			: in std_logic;								-- Data write strobe signal from register interface
		fifo_data_in		: in std_logic_vector(7 downto 0);		-- Configuration data input from the FIFO 
		byte_count_in		: in std_logic_vector(7 downto 0);		-- No of bytes to send to ASMI IP 
		
		fifo_rd_out			: out std_logic;								-- Read request for FIFO
		asmi_wr_done_out	: out std_logic;								-- Write operation is completed 
		asmi_wren_out		: out std_logic;								-- Write enable signal to ASMI IP		
		asmi_write_out		: out std_logic;								-- Write signal to ASMI IP
		asmi_shift_out		: out std_logic;								-- Shift bytes signal to ASMI IP
		asmi_data_out		: out std_logic_vector(7 downto 0)		-- Sending configuration data to the ASMI IP	
	);
end epcq_wr_data;

architecture Behavioral of epcq_wr_data is

-- Signals for detecting the falling edge of the busy signal
signal busy_dly0			: std_logic;
signal busy_fal_s			: std_logic;
-- Signals for state machine for writing the data to the ASMI IP
signal epcq_write_s		: std_logic;
signal send_data_s		: std_logic;
signal wr_done_s			: std_logic;

signal data_dly0			: std_logic;

signal asmi_addr_s 		: std_logic_vector(31 downto 0);
signal config_data_s 	: std_logic_vector(7 downto 0);
signal byte_count_s		: std_logic_vector(8 downto 0);
----------------------------------------------------------------
-- State machine declaration
----------------------------------------------------------------
type DATA_WRITE is 
		( 	
			IDLE,
			SEND_DATA,
			DELAY,
			DELAY_1,
			EPCQ_WRITE,
			POLL_BUSY,
			DONE
		);						
signal wr_prststate,wr_nxtstate : DATA_WRITE;

begin 
-----------------------------------------------------------------
-- State transition process 
-----------------------------------------------------------------
process(clk_20m,reset)
begin
		if reset = '1' then
			wr_prststate <= IDLE;
		elsif rising_edge(clk_20m) then
			wr_prststate <= wr_nxtstate;
		end if;
end process;
-----------------------------------------------------------------
-- State machine 
-----------------------------------------------------------------
process(wr_prststate,data_wr_in,busy_fal_s,byte_count_s,byte_count_in)

begin
	case wr_prststate is 
		-------------------------------------------
		when IDLE =>
			if data_wr_in = '1' then
				wr_nxtstate <= SEND_DATA;				
			else
				wr_nxtstate <= IDLE;
			end if;
		-------------------------------------------	
		when SEND_DATA =>
			if byte_count_s = byte_count_in then 
				wr_nxtstate <= DELAY;
			else 
				wr_nxtstate <= SEND_DATA;
			end if;
		-------------------------------------------	
		when DELAY 	=> 
				wr_nxtstate <= DELAY_1;
		-------------------------------------------	
		when DELAY_1 => 
				wr_nxtstate <= EPCQ_WRITE;
		-------------------------------------------
		when EPCQ_WRITE 	=> 
				wr_nxtstate <= POLL_BUSY;
		-------------------------------------------
		when POLL_BUSY =>
			if busy_fal_s = '1' then 
				wr_nxtstate <= DONE;
			else 
				wr_nxtstate <= POLL_BUSY;
			end if;
		-------------------------------------------
		when DONE =>	
			wr_nxtstate <= IDLE;
		-------------------------------------------		
		when others =>
			wr_nxtstate <= IDLE;
		-------------------------------------------
    end case;			 				
end process;
				
-------- Output Assignments --------------
process(wr_prststate)
begin
	case wr_prststate is
-----------------------------------------
		when IDLE =>
			send_data_s		<= '0';
			epcq_write_s	<= '0';	
			wr_done_s		<= '0';
-----------------------------------------
		when SEND_DATA =>
			send_data_s		<= '1';
			epcq_write_s	<= '0';	
			wr_done_s		<= '0';
-----------------------------------------	
		when DELAY =>
			send_data_s		<= '0';
			epcq_write_s	<= '0';	
			wr_done_s		<= '0';
-----------------------------------------
		when DELAY_1 =>
			send_data_s		<= '0';
			epcq_write_s	<= '0';	
			wr_done_s		<= '0';
-----------------------------------------
		when EPCQ_WRITE =>
			send_data_s		<= '0';
			epcq_write_s	<= '1';	
			wr_done_s		<= '0';			
-----------------------------------------
		when POLL_BUSY =>
			send_data_s		<= '0';
			epcq_write_s	<= '0';	
			wr_done_s		<= '0';	
-----------------------------------------
		when DONE => 
			send_data_s		<= '0';
			epcq_write_s	<= '0';	
			wr_done_s		<= '1';	
-----------------------------------------
		when others =>
			send_data_s		<= '0';
			epcq_write_s	<= '0';	
			wr_done_s		<= '0';	
-----------------------------------------			
	end case;
end process;
---------------------------------------------------------------
-- Delay signal which is necessary of synchronization of the logic
---------------------------------------------------------------
process(clk_20m)
begin 
	if rising_edge(clk_20m) then 
		if reset = '1' then 
			data_dly0	<= '0';
		else
			data_dly0	<= send_data_s;
		end if;
	end if;
end process;	
---------------------------------------------------------------
-- Detecting the falling edge of the signals 
---------------------------------------------------------------
process(clk_20m)
begin 
	if rising_edge(clk_20m) then 
		if reset = '1' then 
			busy_dly0	<= '0';
			busy_fal_s	<= '0';
		else
			busy_dly0  	<= asmi_busy_in;
			busy_fal_s	<= busy_dly0 and (not asmi_busy_in);
		end if;
	end if;
end process;	
---------------------------------------------------------------
-- Counter logic which keep track of no of bytes sent to ASMI IP
---------------------------------------------------------------
process(clk_20m)
begin 
	if rising_edge(clk_20m) then	
		if reset = '1' or wr_done_s = '1' then 
			byte_count_s <= (others => '0');
		elsif send_data_s = '1' then 
			byte_count_s <= byte_count_s + '1'; 
		else 
			byte_count_s <= byte_count_s;	
		end if;
	end if;
end process;
---------------------------------------------------------------
-- Driving the signals as per ASMI IP requirement
---------------------------------------------------------------
process(clk_20m)
begin 
	if falling_edge(clk_20m) then	
		asmi_write_out	<= epcq_write_s;					
		asmi_wren_out	<= data_dly0 or epcq_write_s; 
		asmi_data_out 	<= config_data_s;
		asmi_shift_out	<= data_dly0;
	end if;
end process;
---------------------------------------------------------------
-- Output signal assignments
asmi_wr_done_out 	<= wr_done_s;
fifo_rd_out			<= send_data_s;
config_data_s 		<= fifo_data_in;
---------------------------------------------------------------
end Behavioral; 