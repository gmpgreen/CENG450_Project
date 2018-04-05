--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:16:12 04/03/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm/CENG450_Project/Controller_TB.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Controller
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
 
ENTITY Controller_TB IS
END Controller_TB;
 
ARCHITECTURE behavior OF Controller_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Controller
    PORT(
         clk_external : IN  std_logic;
			clk_internal : in STD_LOGIC;
         rst : IN  std_logic;
         an : OUT  std_logic_vector(3 downto 0);
         sseg : OUT  std_logic_vector(6 downto 0);
         input : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_external : std_logic := '0';
	signal clk_internal : std_logic := '0';
   signal rst : std_logic := '0';
   signal input : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal an : std_logic_vector(3 downto 0);
   signal sseg : std_logic_vector(6 downto 0);
   signal output : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Controller PORT MAP (
          clk_external => clk_external,
			 clk_internal => clk_internal,
          rst => rst,
          an => an,
          sseg => sseg,
          input => input,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk_external <= '0';
		wait for clk_period/2;
		clk_external <= '1';
		wait for clk_period/2;
   end process;
 
	clk_internal <= clk_external;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
      wait for clk_period*10;
		rst <= '0';

      -- insert stimulus here 
		
		input <= x"06"; -- R0
		wait for clk_period*2;
		--input <= x"03"; -- R1
      wait for clk_period*2;
		--input <= x"CD"; -- R2
      wait for clk_period*2;
		--input <= x"04"; -- R3 /will change to R4
      wait for clk_period*2;
		--input <= x"12"; -- R4
      wait for clk_period*2;
		--input <= x"01"; -- R5
      wait for clk_period*2;
		--input <= x"05"; -- R6
      wait for clk_period*2;
		--input <= x"06"; -- R7
		wait for clk_period*2;

      wait;
   end process;

END;
