--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:31:21 02/21/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm.UVIC/CENG450_Project/Fetch_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Fetch
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
 
ENTITY Fetch_TB IS
END Fetch_TB;
 
ARCHITECTURE behavior OF Fetch_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Fetch
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         branch_enable : IN  std_logic;
         branch_address : IN  std_logic_vector(15 downto 0);
         instruction : OUT  std_logic_vector(15 downto 0);
         instruction_addr : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal branch_enable : std_logic := '0';
   signal branch_address : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal instruction : std_logic_vector(15 downto 0);
   signal instruction_addr : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Fetch PORT MAP (
          clk => clk,
          rst => rst,
          branch_enable => branch_enable,
          branch_address => branch_address,
          instruction => instruction,
          instruction_addr => instruction_addr
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
		branch_enable <= '1';
		branch_address <= x"AAAA";
      -- insert stimulus here 
      wait;
   end process;

END;
