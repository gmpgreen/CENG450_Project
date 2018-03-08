--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:04:12 03/07/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm.UVIC.000/CENG450_Project/Branch_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Branch
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
 
ENTITY Branch_TB IS
END Branch_TB;
 
ARCHITECTURE behavior OF Branch_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Branch
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         branch_instr_address : IN  std_logic_vector(15 downto 0);
         reg_val : IN  std_logic_vector(15 downto 0);
         next_instr_address : IN  std_logic_vector(15 downto 0);
         branch_mode_en : IN  std_logic;
         branch_mode : IN  std_logic_vector(2 downto 0);
         branch_offset : IN  std_logic_vector(15 downto 0);
         N : IN  std_logic;
         Z : IN  std_logic;
         branch_enable : OUT  std_logic;
         branch_address : OUT  std_logic_vector(15 downto 0);
         writeback_enable : OUT  std_logic;
         return_address : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal branch_instr_address : std_logic_vector(15 downto 0) := (others => '0');
   signal reg_val : std_logic_vector(15 downto 0) := (others => '0');
   signal next_instr_address : std_logic_vector(15 downto 0) := (others => '0');
   signal branch_mode_en : std_logic := '0';
   signal branch_mode : std_logic_vector(2 downto 0) := (others => '0');
   signal branch_offset : std_logic_vector(15 downto 0) := (others => '0');
   signal N : std_logic := '0';
   signal Z : std_logic := '0';

 	--Outputs
   signal branch_enable : std_logic;
   signal branch_address : std_logic_vector(15 downto 0);
   signal writeback_enable : std_logic;
   signal return_address : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Branch PORT MAP (
          rst => rst,
          clk => clk,
          branch_instr_address => branch_instr_address,
          reg_val => reg_val,
          next_instr_address => next_instr_address,
          branch_mode_en => branch_mode_en,
          branch_mode => branch_mode,
          branch_offset => branch_offset,
          N => N,
          Z => Z,
          branch_enable => branch_enable,
          branch_address => branch_address,
          writeback_enable => writeback_enable,
          return_address => return_address
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
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';
      wait for clk_period*10;
		Z <= '0';
		N <= '0';
		branch_instr_address <= x"1000";
		reg_val <= x"4000";
		next_instr_address <= x"1002";
		
      -- BRR (enabled)
		branch_mode_en <= '1';
		branch_mode <= "000";
		branch_offset <= x"0020";
		wait for clk_period;
		
		-- BRR (disabled)
		branch_mode_en <= '0';
		branch_offset <= x"0030";
		wait for clk_period;
		
		-- BRR.N (disabled, N=0)
		branch_mode_en <= '0';
		branch_mode <= "001";
		branch_offset <= x"0040";
		N <= '0';
		wait for clk_period;
		
		-- BRR.N (disabled, N=1)
		N <= '1';
		wait for clk_period;
		
		-- BRR.N (enabled, N=0)
		branch_mode_en <= '1';
		N <= '0';
		wait for clk_period;
		
		-- BRR.N (enabled, N=1)
		N <= '1';
		wait for clk_period;
		
		-- BRR.Z (disabled, Z=0)
		branch_mode_en <= '0';
		branch_mode <= "010";
		branch_offset <= x"0050";
		Z <= '0';
		wait for clk_period;
		
		-- BRR.Z (disabled, Z=1)
		Z <= '1';
		wait for clk_period;
		
		-- BRR.Z (enabled, Z=0)
		branch_mode_en <= '1';
		Z <= '0';
		wait for clk_period;
		
		-- BRR.Z (enabled, Z=1)
		Z <= '1';
		wait for clk_period;
		
      -- BR (enabled)
		branch_mode_en <= '1';
		branch_mode <= "011";
		branch_offset <= x"0060";
		wait for clk_period;
		
		-- BR (disabled)
		branch_mode_en <= '0';
		branch_offset <= x"0070";
		wait for clk_period;
		
		-- BR.N (disabled, N=0)
		branch_mode_en <= '0';
		branch_mode <= "100";
		branch_offset <= x"0080";
		N <= '0';
		wait for clk_period;
		
		-- BR.N (disabled, N=1)
		N <= '1';
		wait for clk_period;
		
		-- BR.N (enabled, N=0)
		branch_mode_en <= '1';
		N <= '0';
		wait for clk_period;
		
		-- BR.N (enabled, N=1)
		N <= '1';
		wait for clk_period;
		
		-- BR.Z (disabled, Z=0)
		branch_mode_en <= '0';
		branch_mode <= "101";
		branch_offset <= x"0022";
		Z <= '0';
		wait for clk_period;
		
		-- BR.Z (disabled, Z=1)
		Z <= '1';
		wait for clk_period;
		
		-- BR.Z (enabled, Z=0)
		branch_mode_en <= '1';
		Z <= '0';
		wait for clk_period;
		
		-- BR.Z (enabled, Z=1)
		Z <= '1';
		wait for clk_period;
		
      -- BR.SUB (enabled)
		branch_mode_en <= '1';
		branch_mode <= "110";
		branch_offset <= x"0011";
		wait for clk_period;
		
		-- BR.SUB (disabled)
		branch_mode_en <= '0';
		branch_offset <= x"0070";
		wait for clk_period;
		
      -- RETURN (enabled)
		branch_mode_en <= '1';
		branch_mode <= "111";
		branch_offset <= x"0333";
		wait for clk_period;
		
		-- RETURN (disabled)
		branch_mode_en <= '0';
		branch_offset <= x"0333";
		wait for clk_period;

      wait;
   end process;

END;
