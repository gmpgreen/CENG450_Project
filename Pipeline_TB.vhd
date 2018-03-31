--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:21:56 03/14/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm.UVIC.000/CENG450_Project/Pipeline_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pipeline
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
 
ENTITY Pipeline_TB IS
END Pipeline_TB;
 
ARCHITECTURE behavior OF Pipeline_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pipeline
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         input : IN  std_logic_vector(15 downto 0);
         output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal input : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pipeline PORT MAP (
          clk => clk,
          rst => rst,
          input => input,
          output => output
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
      wait for 50 ns;
		rst <= '0';
		
		-- Initialize the register file
		input <= x"0002"; -- R0
		wait for clk_period;
		input <= x"0003"; -- R1
      wait for clk_period;
		input <= x"0001"; -- R2
      wait for clk_period;
		input <= x"0005"; -- R3
      wait for clk_period;
		input <= x"0012"; -- R4
      wait for clk_period;
		input <= x"0001"; -- R5
      wait for clk_period;
		input <= x"0005"; -- R6
      wait for clk_period;
		input <= x"0000"; -- R7
		wait for clk_period;
		
      -- insert stimulus here 

      wait;
   end process;

END;
