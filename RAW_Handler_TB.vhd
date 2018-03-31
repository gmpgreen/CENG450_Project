--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:30:28 03/30/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm/CENG450_Project/RAW_Handler_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAW_Handler
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
 
ENTITY RAW_Handler_TB IS
END RAW_Handler_TB;
 
ARCHITECTURE behavior OF RAW_Handler_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAW_Handler
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         wr_en : IN  std_logic;
         wr_idx : IN  std_logic_vector(2 downto 0);
         rd_idx1 : IN  std_logic_vector(2 downto 0);
         rd_idx2 : IN  std_logic_vector(2 downto 0);
         raw_1 : OUT  std_logic_vector(1 downto 0);
         raw_2 : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal wr_en : std_logic := '0';
   signal wr_idx : std_logic_vector(2 downto 0) := (others => '0');
   signal rd_idx1 : std_logic_vector(2 downto 0) := (others => '0');
   signal rd_idx2 : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal raw_1 : std_logic_vector(1 downto 0);
   signal raw_2 : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAW_Handler PORT MAP (
          rst => rst,
          clk => clk,
          wr_en => wr_en,
          wr_idx => wr_idx,
          rd_idx1 => rd_idx1,
          rd_idx2 => rd_idx2,
          raw_1 => raw_1,
          raw_2 => raw_2
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
		wait for clk_period/2;
		rst <= '0';
      wait for clk_period;
		-- RAW 1 should be 0
		-- RAW 2 should be 0
		wr_en <= '1';
		wr_idx <= "101";
		rd_idx1 <= "001";
		rd_idx2 <= "011";
      wait for clk_period;
		-- RAW 1 should be 3
		-- RAW 2 should be 0
		wr_en <= '1';
		wr_idx <= "011";
		rd_idx1 <= "101";
		rd_idx2 <= "011";
      wait for clk_period;
		-- RAW 1 should be 2
		-- RAW 2 should be 3
		wr_en <= '1';
		wr_idx <= "100";
		rd_idx1 <= "101";
		rd_idx2 <= "011";
      wait for clk_period;
		-- RAW 1 should be 3
		-- RAW 2 should be 1
		wr_en <= '1';
		wr_idx <= "100";
		rd_idx1 <= "100";
		rd_idx2 <= "101";
      wait for clk_period;
		-- RAW 1 should be 0
		-- RAW 2 should be 1
		wr_en <= '1';
		wr_idx <= "100";
		rd_idx1 <= "101";
		rd_idx2 <= "011";

      -- insert stimulus here 

      wait;
   end process;

END;
