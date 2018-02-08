--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:37:22 01/31/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm/RegFile_ALU/ALU_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         in1 : IN  std_logic_vector(15 downto 0);
         in2 : IN  std_logic_vector(15 downto 0);
         alu_mode : IN  std_logic_vector(2 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         result : OUT  std_logic_vector(15 downto 0);
         z_flag : OUT  std_logic;
         n_flag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in1 : std_logic_vector(15 downto 0) := (others => '0');
   signal in2 : std_logic_vector(15 downto 0) := (others => '0');
   signal alu_mode : std_logic_vector(2 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal result : std_logic_vector(15 downto 0);
   signal z_flag : std_logic;
   signal n_flag : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          in1 => in1,
          in2 => in2,
          alu_mode => alu_mode,
          clk => clk,
          rst => rst,
          result => result,
          z_flag => z_flag,
          n_flag => n_flag
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

      wait for clk_period*10;

      -- insert stimulus here
		wait for clk_period;
		alu_mode <= "101";
		in1 <= x"1111";
		in2 <= x"0001";
		wait for clk_period*3;
		in2 <= x"0002";
		wait for clk_period*3;
		in2 <= x"0004";
		wait for clk_period*3;
		in2 <= x"0008";
		wait for clk_period*3;
		in1 <= x"FFFF";
		in2 <= x"0005";
      wait;
   end process;

END;
