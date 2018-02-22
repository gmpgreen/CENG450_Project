--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:18:22 02/21/2018
-- Design Name:   
-- Module Name:   C:/Users/lymacasm.UVIC/CENG450_Project/Execute_TB.vhd
-- Project Name:  RegFile_ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Execute
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
 
ENTITY Execute_TB IS
END Execute_TB;
 
ARCHITECTURE behavior OF Execute_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Execute
    PORT(
         ALU_Mode : IN  std_logic_vector(2 downto 0);
         input1 : IN  std_logic_vector(15 downto 0);
         input2 : IN  std_logic_vector(15 downto 0);
         shift : IN  std_logic_vector(15 downto 0);
         Z : OUT  std_logic;
         N : OUT  std_logic;
         ALU_Result : OUT  std_logic_vector(15 downto 0);
         Mem_Mode_In : IN  std_logic_vector(1 downto 0);
         Wr_Back_Mode_In : IN  std_logic_vector(1 downto 0);
         Load_Imm_In : IN  std_logic_vector(7 downto 0);
         Mem_Mode_Out : OUT  std_logic_vector(1 downto 0);
         Wr_Back_Mode_Out : OUT  std_logic_vector(1 downto 0);
         Load_Imm_Out : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ALU_Mode : std_logic_vector(2 downto 0) := (others => '0');
   signal input1 : std_logic_vector(15 downto 0) := (others => '0');
   signal input2 : std_logic_vector(15 downto 0) := (others => '0');
   signal shift : std_logic_vector(15 downto 0) := (others => '0');
   signal Mem_Mode_In : std_logic_vector(1 downto 0) := (others => '0');
   signal Wr_Back_Mode_In : std_logic_vector(1 downto 0) := (others => '0');
   signal Load_Imm_In : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Z : std_logic;
   signal N : std_logic;
   signal ALU_Result : std_logic_vector(15 downto 0);
   signal Mem_Mode_Out : std_logic_vector(1 downto 0);
   signal Wr_Back_Mode_Out : std_logic_vector(1 downto 0);
   signal Load_Imm_Out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Execute PORT MAP (
          ALU_Mode => ALU_Mode,
          input1 => input1,
          input2 => input2,
          shift => shift,
          Z => Z,
          N => N,
          ALU_Result => ALU_Result,
          Mem_Mode_In => Mem_Mode_In,
          Wr_Back_Mode_In => Wr_Back_Mode_In,
          Load_Imm_In => Load_Imm_In,
          Mem_Mode_Out => Mem_Mode_Out,
          Wr_Back_Mode_Out => Wr_Back_Mode_Out,
          Load_Imm_Out => Load_Imm_Out,
          clk => clk,
          rst => rst
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
		rst <= '1';
      wait for clk_period*10;
		rst <= '0';
      -- insert stimulus here 
		mem_mode_in <= "10";
		wr_back_mode_in <= "01";
		load_imm_in <= x"FF";
		wait for clk_period;
		alu_mode <= "101";
		input1 <= x"1212";
		shift <= x"0004";
		wait for clk_period;
		alu_mode <= "110";
		wait for clk_period;
		alu_mode <= "010";
		input2 <= x"4444";
		wait for clk_period;
		alu_mode <= "001";
      wait;
   end process;

END;
