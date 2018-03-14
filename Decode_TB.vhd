--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:17:39 02/22/2018
-- Design Name:   
-- Module Name:   /home/ise/Shared/CENG450_Project/Decode_TB.vhd
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
 
ENTITY Decode_TB IS
END Decode_TB;
 
ARCHITECTURE behavior OF Decode_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decode
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         instruction : IN  std_logic_vector(15 downto 0);
         pc : IN  std_logic_vector(6 downto 0);
         branch_mode : OUT  std_logic_vector(2 downto 0);
         branch_offset : OUT  std_logic_vector(8 downto 0);
         ALU_Mode : OUT  std_logic_vector(2 downto 0);
         MEM_Mode : OUT  std_logic_vector(1 downto 0);
         Writeback_Mode : OUT  std_logic_vector(1 downto 0);
         Immediate : OUT  std_logic_vector(7 downto 0);
         rd_index1 : OUT  std_logic_vector(2 downto 0);
         rd_index2 : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal instruction : std_logic_vector(15 downto 0) := (others => '0');
   signal pc : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal branch_mode : std_logic_vector(2 downto 0);
   signal branch_offset : std_logic_vector(8 downto 0);
   signal ALU_Mode : std_logic_vector(2 downto 0);
   signal MEM_Mode : std_logic_vector(1 downto 0);
   signal Writeback_Mode : std_logic_vector(1 downto 0);
   signal Immediate : std_logic_vector(7 downto 0);
   signal rd_index1 : std_logic_vector(2 downto 0);
   signal rd_index2 : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decode PORT MAP (
          rst => rst,
          clk => clk,
          instruction => instruction,
          pc => pc,
          branch_mode => branch_mode,
          branch_offset => branch_offset,
          ALU_Mode => ALU_Mode,
          MEM_Mode => MEM_Mode,
          Writeback_Mode => Writeback_Mode,
          Immediate => Immediate,
          rd_index1 => rd_index1,
          rd_index2 => rd_index2
        );
-- Constants
constant brr : std_logic_vector(6 downto 0) 			:= "1000000";
constant brr_neg : std_logic_vector(6 downto 0) 	:= "1000001";
constant brr_zero : std_logic_vector(6 downto 0) 	:= "1000010";
constant br : std_logic_vector(6 downto 0) 			:= "1000011";
constant br_neg : std_logic_vector(6 downto 0) 		:= "1000100";
constant br_zero : std_logic_vector(6 downto 0) 	:= "1000101";
constant br_sub : std_logic_vector(6 downto 0) 		:= "1000110";
constant rtn	: std_logic_vector(6 downto 0)		:= "1000111";

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

      wait for clk_period*10;

      -- insert stimulus here
		instruction <= br_zero & "111" &;
		wait for clk_period*3;
		
      wait;
   end process;

END;
