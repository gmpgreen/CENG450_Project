--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:30:17 01/31/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm/RegFile_ALU/Register_File_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Register_File
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
 
ENTITY Register_File_TB IS
END Register_File_TB;
 
ARCHITECTURE behavior OF Register_File_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Register_File
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         rd_index1 : IN  std_logic_vector(2 downto 0);
         rd_index2 : IN  std_logic_vector(2 downto 0);
         rd_data1 : OUT  std_logic_vector(15 downto 0);
         rd_data2 : OUT  std_logic_vector(15 downto 0);
         wr_index : IN  std_logic_vector(2 downto 0);
         wr_data : IN  std_logic_vector(15 downto 0);
         wr_enable : IN  std_logic;
			desired_wr_idx: in std_logic_vector(2 downto 0);
			desired_wr_en: in std_logic;
			raw_detected: out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal rd_index1 : std_logic_vector(2 downto 0) := (others => '0');
   signal rd_index2 : std_logic_vector(2 downto 0) := (others => '0');
   signal wr_index : std_logic_vector(2 downto 0) := (others => '0');
   signal wr_data : std_logic_vector(15 downto 0) := (others => '0');
   signal wr_enable : std_logic := '0';
	signal desired_wr_idx: std_logic_vector(2 downto 0) := "000";
	signal desired_wr_en: std_logic := '0';

 	--Outputs
   signal rd_data1 : std_logic_vector(15 downto 0);
   signal rd_data2 : std_logic_vector(15 downto 0);
	signal raw_detected: std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register_File PORT MAP (
          rst => rst,
          clk => clk,
          rd_index1 => rd_index1,
          rd_index2 => rd_index2,
          rd_data1 => rd_data1,
          rd_data2 => rd_data2,
          wr_index => wr_index,
          wr_data => wr_data,
          wr_enable => wr_enable,
			 desired_wr_idx => desired_wr_idx,
			 desired_wr_en => desired_wr_en,
			 raw_detected => raw_detected
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
      wait for clk_period*10;

      -- insert stimulus here 
		rst <= '0';
		rd_index1 <= "010";
		rd_index2 <= "100";
		wr_index <= "010";
		wr_enable <= '1';
		wr_data <= x"1515";
		desired_wr_idx <= "100";
		desired_wr_en <= '1';
		wait for clk_period;
		desired_wr_idx <= "000";
		wr_index <= "100";
		wr_data <= x"FF66";
		wait for clk_period * 3;
		desired_wr_idx <= "111";
		rd_index1 <= "000";
		rd_index2 <= "111";
		wait for clk_period * 2;
		desired_wr_en <= '0';

      wait;
   end process;

END;
