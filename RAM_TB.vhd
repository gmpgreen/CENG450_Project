--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:15:44 03/29/2018
-- Design Name:   
-- Module Name:   /home/ise/Shared/CENG450_Project/RAM_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM
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
 
ENTITY RAM_TB IS
END RAM_TB;
 
ARCHITECTURE behavior OF RAM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         RW_Enable : IN  std_logic;
         Address : IN  std_logic_vector(15 downto 0);
         WR_Data : IN  std_logic_vector(15 downto 0);
         RD_Data : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal RW_Enable : std_logic := '0';
   signal Address : std_logic_vector(15 downto 0) := (others => '0');
   signal WR_Data : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal RD_Data : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          rst => rst,
          clk => clk,
          RW_Enable => RW_Enable,
          Address => Address,
          WR_Data => WR_Data,
          RD_Data => RD_Data
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		RW_Enable <= '1';
		WR_Data <= x"FF0F";
		Address <= x"0000";
		wait for 50 ns;
		WR_Data <= x"AB00";
		Address <= x"0002";
		wait for 50 ns;
		WR_Data <= x"00CD";
		Address <= x"0005";
		wait for 50 ns;
		RW_Enable <= '0';
		Address <= x"0000";
		wait for 50 ns;
		Address <= x"0002";
      wait;
   end process;

END;
