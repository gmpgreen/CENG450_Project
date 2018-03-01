--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:51:19 03/01/2018
-- Design Name:   
-- Module Name:   /home/ise/Shared/CENG450_Project/Decode_TB2.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decode
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Decode_TB2 IS
END Decode_TB2;
 
ARCHITECTURE behavior OF Decode_TB2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decode
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         instruction : IN  std_logic_vector(15 downto 0);
         ra_index : OUT  std_logic_vector(2 downto 0);
         pc_in : IN  std_logic_vector(15 downto 0);
         pc_out : OUT  std_logic_vector(15 downto 0);
         branch_mode : OUT  std_logic_vector(2 downto 0);
         branch_offset : OUT  std_logic_vector(8 downto 0);
         ALU_Mode : OUT  std_logic_vector(2 downto 0);
         Writeback_Mode : OUT  std_logic_vector(1 downto 0);
         Immediate : OUT  std_logic_vector(7 downto 0);
         rd_data1 : OUT  std_logic_vector(15 downto 0);
         rd_data2 : OUT  std_logic_vector(15 downto 0);
         wr_index : IN  std_logic_vector(2 downto 0);
         wr_data : IN  std_logic_vector(15 downto 0);
         wr_enable : IN  std_logic;
         c1 : OUT  std_logic_vector(3 downto 0);
         immediate_mode : OUT  std_logic;
         mem_mode : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal instruction : std_logic_vector(15 downto 0) := (others => '0');
   signal pc_in : std_logic_vector(15 downto 0) := (others => '0');
   signal wr_index : std_logic_vector(2 downto 0) := (others => '0');
   signal wr_data : std_logic_vector(15 downto 0) := (others => '0');
   signal wr_enable : std_logic := '0';

 	--Outputs
   signal ra_index : std_logic_vector(2 downto 0);
   signal pc_out : std_logic_vector(15 downto 0);
   signal branch_mode : std_logic_vector(2 downto 0);
   signal branch_offset : std_logic_vector(8 downto 0);
   signal ALU_Mode : std_logic_vector(2 downto 0);
   signal Writeback_Mode : std_logic_vector(1 downto 0);
   signal Immediate : std_logic_vector(7 downto 0);
   signal rd_data1 : std_logic_vector(15 downto 0);
   signal rd_data2 : std_logic_vector(15 downto 0);
   signal c1 : std_logic_vector(3 downto 0);
   signal immediate_mode : std_logic;
   signal mem_mode : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	--Op Code Definitions
constant nop_op : std_logic_vector(6 downto 0)  := "0000000";
constant add_op : std_logic_vector(6 downto 0)  := "0000001";
constant sub_op : std_logic_vector(6 downto 0)  := "0000010";
constant mul_op : std_logic_vector(6 downto 0)  := "0000011";
constant nand_op : std_logic_vector(6 downto 0) := "0000100";
constant shl_op : std_logic_vector(6 downto 0)  := "0000101";
constant shr_op : std_logic_vector(6 downto 0)  := "0000110";
constant test_op : std_logic_vector(6 downto 0) := "0000111";
constant out_op : std_logic_vector(6 downto 0)  := "0100000";
constant in_op : std_logic_vector(6 downto 0)   := "0100001";
constant load_imm : std_logic_vector(6 downto 0):= "0010010";
constant load : std_logic_vector(6 downto 0)		:= "0010000";
constant store : std_logic_vector(6 downto 0)	:= "0010001";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decode PORT MAP (
          rst => rst,
          clk => clk,
          instruction => instruction,
          ra_index => ra_index,
          pc_in => pc_in,
          pc_out => pc_out,
          branch_mode => branch_mode,
          branch_offset => branch_offset,
          ALU_Mode => ALU_Mode,
          Writeback_Mode => Writeback_Mode,
          Immediate => Immediate,
          rd_data1 => rd_data1,
          rd_data2 => rd_data2,
          wr_index => wr_index,
          wr_data => wr_data,
          wr_enable => wr_enable,
          c1 => c1,
          immediate_mode => immediate_mode,
          mem_mode => mem_mode
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	

      wait for clk_period*3;

      -- insert stimulus here 
		instruction <= in_op & "001" & "111101"; --load value into reg 001
		wait for clk_period*10;
		instruction <= load & "010" & "001" & "000"; --load reg 001 into 002
      wait;
   end process;

END;
