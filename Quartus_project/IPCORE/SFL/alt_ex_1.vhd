-- ============================================================================
--
-- File Name: alt_ex_1.vhd  
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
-- Description:  Top for EPCQ Flash Upgradation Logic
--
-- Target Device	: 5SGXEA3K3F40C4
-- Device Family 	: ALTERA Stratix V 
-- Synthesis Tool	: Quartus II Subscription Edition 14.1

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library altera_mf;
use altera_mf.all;	

entity epcq_top is
	port
	(			
		clk_250m        		: in std_logic;      						-- 250MHz Clock coming from PCIe interface                  	
		clk_20m					: in std_logic;								-- 20MHz Clock coming from the PLL
		asmi_sfl_reset      	: in std_logic;                      	-- Reset signal from Avalon MM simple slave interface
		asmi_sfl_read        : in std_logic;                     	-- Read strobe from Avalon MM simple slave interface 	 
		asmi_sfl_write      	: in std_logic;                      	-- Write strobe from Avalon MM simple slave interface
		asmi_sfl_address		: in std_logic_vector(7 downto 0);    	-- Address from the Avalon MM simple slave interface
		asmi_data_to_sfl     : in std_logic_vector(31 downto 0);		-- Data input to the epcq top module from Avalon MM simple slave interface 
		asmi_data_from_sfl   : out std_logic_vector(31 downto 0) 	-- Data output from epcq top module to Avalon MM simple slave interface 
	);
end epcq_top;

architecture Behavioral of epcq_top is

component epcq_registers is
port
	(		
		
		clk_250m				: in std_logic;									-- Clock 250MHz for reading/writing data to the registers
		clk_20m        	: in std_logic;                       		-- Clock 20MHz for processing the data
		reset     			: in std_logic;                        	-- Reset signal	
			
		wr_strobe_in  		: in std_logic;  									-- Write strobe from Avalon MM simple slave interface
		rd_strobe_in		: in std_logic;									-- Read strobe from Avalon MM simple slave interface
		reg_addres_in		: in std_logic_vector(7 downto 0);			-- Register address from Avalon MM simple slave interface 
		reg_data_in			: in std_logic_vector(31 downto 0);			-- Data input from Avalon MM simple slave interface
		reg_data_out		: out std_logic_vector(31 downto 0);		-- Data outptut from Avalon MM simple slave interface
		
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
		epcq_id_out			: out std_logic;									-- Read EPCQ256 memory capcity ID request to the ASMI IP
		epcq_wr_out			: out std_logic;									-- Data write strobe to the epcq_wr_data block 
		epcq_rd_out			: out std_logic;									-- Data read request to ASMI IP
		en4b_addr_out		: out std_logic;									-- Enable 4 byte address mode request to ASMI IP
		byte_const_out 	: out std_logic_vector(7 downto 0);			-- No of byte to write from FIFO to epcq_wr_block
		epcq_addr_out		: out std_logic_vector(31 downto 0)			-- Addrress to the ASMI IP	
	);
end component;

component asmi is
port 
	(
		clkin         : in  std_logic                     := 'X';             -- clk
		rden          : in  std_logic                     := 'X';             -- rden
		addr          : in  std_logic_vector(31 downto 0) := (others => 'X'); -- addr
		reset         : in  std_logic                     := 'X';             -- reset
		dataout       : out std_logic_vector(7 downto 0);                     -- dataout
		busy          : out std_logic;                                        -- busy
		data_valid    : out std_logic;                                        -- data_valid
		write         : in  std_logic                     := 'X';             -- write
		datain        : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- datain
		illegal_write : out std_logic;                                        -- illegal_write
		wren          : in  std_logic                     := 'X';             -- wren
		shift_bytes   : in  std_logic                     := 'X';             -- shift_bytes
		bulk_erase    : in  std_logic                     := 'X';             -- bulk_erase
		illegal_erase : out std_logic;                                        -- illegal_erase
		read_status   : in  std_logic                     := 'X';             -- read_status
		status_out    : out std_logic_vector(7 downto 0);                     -- status_out
		en4b_addr     : in  std_logic                     := 'X';             -- en4b_addr
		read_rdid     : in  std_logic                     := 'X';             -- read_rdid
		rdid_out      : out std_logic_vector(7 downto 0);                     -- rdid_out
		fast_read     : in  std_logic                     := 'X'	             -- fast_read 
	);
end component;

component fifo32x64 is
	port
	(	
		aclr		: IN STD_LOGIC  := '0';									-- Asynchronous reset signal 						
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);				-- Data input  
		rdclk		: IN STD_LOGIC ;											-- Read clock for reading the data
		rdreq		: IN STD_LOGIC ;											-- Read request for reading the data 
		wrclk		: IN STD_LOGIC ;											-- Write clock for writing the data
		wrreq		: IN STD_LOGIC ;											-- Write request for writing the data
		q			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);				-- Data out 
		rdempty	: OUT STD_LOGIC ;											-- FIFO empty 	
		wrfull	: OUT STD_LOGIC 											-- FIFO full 
	);
end component;

component epcq_wr_data is
port
	(			
		clk_20m          	: in std_logic; 								-- Clock 20MHz 	
		reset		 			: in std_logic;								-- Reset for intializong the internal logic
	
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
end component;
----------------------------------------------------------------------
-- Signals from EPCQ register block 
signal asmi_busy_s		: std_logic;	
signal data_valid_s		: std_logic;
signal asmi_ip_reset_s	: std_logic;
signal epcq_erase_s		: std_logic;	
signal epcq_status_rd_s	: std_logic;
signal epcq_id_req_s		: std_logic;	
signal epcq_wr_s			: std_logic;
signal epcq_rd_s			: std_logic;	
signal epcq_en4b_s		: std_logic;
signal rd_dummy_clk_s	: std_logic;	
signal fifo_wr_s			: std_logic;
signal no_byte_s 			: std_logic_vector(7 downto 0);
signal rd_id_s				: std_logic_vector(7 downto 0);	
signal rd_status_s		: std_logic_vector(7 downto 0);
signal rd_data_s 			: std_logic_vector(7 downto 0);
signal fifo_data_s 		: std_logic_vector(31 downto 0);
signal epcq_addr_s 		: std_logic_vector(31 downto 0);				
----------------------------------------------------------------------
-- Signals from epcq_wr_data block
signal epcq_write_s		: std_logic;
signal epcq_wren_s		: std_logic;
signal epcq_shift_s		: std_logic;
signal wr_done_s			: std_logic;
signal fifo_rd_s			: std_logic;		
signal epcq_data_s 		: std_logic_vector(7 downto 0);
signal config_data_s 	: std_logic_vector(7 downto 0);
----------------------------------------------------------------------
begin 

u0 : epcq_registers
port map
	(		
		clk_250m				=> clk_250m,
		clk_20m        	=> clk_20m,                     
		reset     			=> asmi_sfl_reset,                    
		
		wr_strobe_in  		=> asmi_sfl_write,
		rd_strobe_in		=> asmi_sfl_read,
		reg_addres_in		=> asmi_sfl_address,
		reg_data_in			=> asmi_data_to_sfl,
		reg_data_out		=> asmi_data_from_sfl,
		
		fifo_data_out		=> fifo_data_s,
		fifo_wr_out			=> fifo_wr_s,
	
		asmi_busy_in		=> asmi_busy_s,
		data_valid_in		=> data_valid_s,
		wr_done_in			=> wr_done_s, 
		epcq_id_in			=> rd_id_s,
		epcq_status_in		=> rd_status_s,
		epcq_data_in		=> rd_data_s,
		
		asmi_ip_reset_out	=> asmi_ip_reset_s,
		bulk_erase_out		=> epcq_erase_s,
		epcq_status_out	=> epcq_status_rd_s,
		epcq_id_out			=> epcq_id_req_s,
		epcq_wr_out			=> epcq_wr_s,
		epcq_rd_out			=> epcq_rd_s,
		en4b_addr_out		=> epcq_en4b_s,
		byte_const_out		=> no_byte_s,
		epcq_addr_out		=> epcq_addr_s
	);
	
u1 :  asmi
port map 
	(
		clkin         => clk_20m,         								
		rden          => epcq_rd_s,         			
		addr          => epcq_addr_s,          				
		reset         => asmi_ip_reset_s or asmi_sfl_reset,  
		dataout       => rd_data_s,       				
		busy          => asmi_busy_s,          		
		data_valid    => data_valid_s,    			
		write         => epcq_write_s,         		
		datain        => epcq_data_s,        			
		illegal_write => open , 							
		wren          => epcq_wren_s or epcq_erase_s or epcq_en4b_s, 				
		shift_bytes   => epcq_shift_s,  	 			
		bulk_erase    => epcq_erase_s,    			
		illegal_erase => open,	 							
		read_status   => epcq_status_rd_s,   			
		status_out    => rd_status_s,    				
		en4b_addr     => epcq_en4b_s,     				
		read_rdid     => epcq_id_req_s,     			
		rdid_out      => rd_id_s,      					
		fast_read     => epcq_rd_s
	);	
	
u2 : epcq_wr_data 
port map 
	(			
		clk_20m          	=>	clk_20m,						
		reset		 			=> asmi_sfl_reset or asmi_ip_reset_s,
	
		asmi_busy_in		=> asmi_busy_s,
		data_wr_in			=> epcq_wr_s,
		fifo_data_in		=> config_data_s,
		byte_count_in		=> no_byte_s,
		
		fifo_rd_out			=> fifo_rd_s,
		asmi_wr_done_out	=> wr_done_s,
		asmi_wren_out		=> epcq_wren_s,
		asmi_write_out		=> epcq_write_s,
		asmi_shift_out		=> epcq_shift_s,
		asmi_data_out		=> epcq_data_s
	);

	
u3 : fifo32x64 
port map  
	(
		aclr	 	=> asmi_sfl_reset or asmi_ip_reset_s,
		data	 	=> fifo_data_s,
		rdclk	 	=> clk_20m,
		rdreq	 	=> fifo_rd_s,
		wrclk		=> clk_250m,
		wrreq	 	=> fifo_wr_s,
		q	 		=> config_data_s,
		rdempty	=> open,
		wrfull	=> open
	);

end Behavioral;