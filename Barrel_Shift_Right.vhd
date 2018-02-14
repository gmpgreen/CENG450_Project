----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:42:33 02/13/2018 
-- Design Name: 
-- Module Name:    Barrel_Shift_Right - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Barrel_Shift_Right is
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           shift : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0));
end Barrel_Shift_Right;

architecture Behavioral of Barrel_Shift_Right is

-- Output of 1st stage
signal stage1_output_1 : std_logic_vector(7 downto 0);
signal stage1_output_2 : std_logic_vector(7 downto 0);

-- Output of 2nd stage
signal stage2_output_1 : std_logic_vector(3 downto 0);
signal stage2_output_2 : std_logic_vector(3 downto 0);
signal stage2_output_3 : std_logic_vector(3 downto 0);
signal stage2_output_4 : std_logic_vector(3 downto 0);

-- Ouput of 3rd stage
signal stage3_output_1 : std_logic_vector(1 downto 0);
signal stage3_output_2 : std_logic_vector(1 downto 0);
signal stage3_output_3 : std_logic_vector(1 downto 0);
signal stage3_output_4 : std_logic_vector(1 downto 0);
signal stage3_output_5 : std_logic_vector(1 downto 0);
signal stage3_output_6 : std_logic_vector(1 downto 0);
signal stage3_output_7 : std_logic_vector(1 downto 0);
signal stage3_output_8 : std_logic_vector(1 downto 0);

begin
	-- Shift by 8
	stage1_1 : entity work.mux2_8 port map(input(15 downto 8), x"00", shift(3), 
		stage1_output_2);
	stage1_2 : entity work.mux2_8 port map(input(7 downto 0), input(15 downto 8), shift(3), 
		stage1_output_1);
		
	-- Shift by 4
	stage2_1 : entity work.mux2_4 port map(x"0", stage1_output_1(7 downto 4), shift(2),
		stage2_output_1);
	stage2_2 : entity work.mux2_4 port map(stage1_output_1(7 downto 4), stage1_output_1(3 downto 0), shift(2),
		stage2_output_2);
	stage2_3 : entity work.mux2_4 port map(stage1_output_2(3 downto 0), stage1_output_1(7 downto 4), shift(2),
		stage2_output_3);
	stage2_4 : entity work.mux2_4 port map(stage1_output_2(7 downto 4), stage1_output_2(3 downto 0), shift(2),
		stage2_output_4);
		
	-- Shift by 2
	stage3_1 : entity work.mux2_2 port map("00", stage2_output_1(3 downto 2),  shift(1),
		stage3_output_1);
	stage3_2 : entity work.mux2_2 port map(stage2_output_1(3 downto 2), stage2_output_1(1 downto 0), shift(1),
		stage3_output_2);
	stage3_3 : entity work.mux2_2 port map(stage2_output_2(1 downto 0), stage2_output_1(3 downto 2), shift(1),
		stage3_output_3);
	stage3_4 : entity work.mux2_2 port map(stage2_output_2(3 downto 2), stage2_output_2(1 downto 0), shift(1),
		stage3_output_4);
	stage3_5 : entity work.mux2_2 port map(stage2_output_3(1 downto 0), stage2_output_2(3 downto 2), shift(1),
		stage3_output_5);
	stage3_6 : entity work.mux2_2 port map(stage2_output_3(3 downto 2), stage2_output_3(1 downto 0), shift(1),
		stage3_output_6);
	stage3_7 : entity work.mux2_2 port map(stage2_output_4(1 downto 0), stage2_output_3(3 downto 2), shift(1),
		stage3_output_7);
	stage3_8 : entity work.mux2_2 port map(stage2_output_4(3 downto 2), stage2_output_4(1 downto 0), shift(1),
		stage3_output_8);
		
	-- Shift by 1
	stage4_1 : entity work.mux2_1 port map('0', stage3_output_1(1), shift(0), output(0));
	stage4_2 : entity work.mux2_1 port map(stage3_output_1(1), stage3_output_1(0), shift(0), output(1));
	stage4_3 : entity work.mux2_1 port map(stage3_output_2(0), stage3_output_1(1), shift(0), output(2));
	stage4_4 : entity work.mux2_1 port map(stage3_output_2(1), stage3_output_2(0), shift(0), output(3));
	stage4_5 : entity work.mux2_1 port map(stage3_output_3(0), stage3_output_2(1), shift(0), output(4));
	stage4_6 : entity work.mux2_1 port map(stage3_output_3(1), stage3_output_3(0), shift(0), output(5));
	stage4_7 : entity work.mux2_1 port map(stage3_output_4(0), stage3_output_3(1), shift(0), output(6));
	stage4_8 : entity work.mux2_1 port map(stage3_output_4(1), stage3_output_4(0), shift(0), output(7));
	stage4_9 : entity work.mux2_1 port map(stage3_output_5(0), stage3_output_4(1), shift(0), output(8));
	stage4_10 : entity work.mux2_1 port map(stage3_output_5(1), stage3_output_5(0), shift(0), output(9));
	stage4_11 : entity work.mux2_1 port map(stage3_output_6(0), stage3_output_5(1), shift(0), output(10));
	stage4_12 : entity work.mux2_1 port map(stage3_output_6(1), stage3_output_6(0), shift(0), output(11));
	stage4_13 : entity work.mux2_1 port map(stage3_output_7(0), stage3_output_6(1), shift(0), output(12));
	stage4_14 : entity work.mux2_1 port map(stage3_output_7(1), stage3_output_7(0), shift(0), output(13));
	stage4_15 : entity work.mux2_1 port map(stage3_output_8(0), stage3_output_7(1), shift(0), output(14));
	stage4_16 : entity work.mux2_1 port map(stage3_output_8(1), stage3_output_8(0), shift(0), output(15));

end Behavioral;

