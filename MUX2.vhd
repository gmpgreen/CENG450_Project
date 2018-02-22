----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:51:58 02/07/2018 
-- Design Name: 
-- Module Name:    MUX2 - Behavioral 
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Select between 2 8 bit vectors
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2_16 is
	Port(
		in1, in2 : in std_logic_vector(15 downto 0);
		sel : in std_logic;
		output : out std_logic_vector(15 downto 0) 
	);
end MUX2_16;

architecture Behavioral of MUX2_16 is
begin
	output <= in1 when sel = '0' else in2;
end Behavioral;

-- Select between 2 8 bit vectors
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2_8 is
	Port(
		in1, in2 : in std_logic_vector(7 downto 0);
		sel : in std_logic;
		output : out std_logic_vector(7 downto 0) 
	);
end MUX2_8;

architecture Behavioral of MUX2_8 is
begin
	output <= in1 when sel = '0' else in2;
end Behavioral;

-- Select between 2 4 bit vectors
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2_4 is
	Port(
		in1, in2 : in std_logic_vector(3 downto 0);
		sel : in std_logic;
		output : out std_logic_vector(3 downto 0) 
	);
end MUX2_4;

architecture Behavioral of MUX2_4 is
begin
	output <= in1 when sel = '0' else in2;
end Behavioral;

-- Select between 2 2 bit vectors
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2_2 is
	Port(
		in1, in2 : in std_logic_vector(1 downto 0);
		sel : in std_logic;
		output : out std_logic_vector(1 downto 0) 
	);
end MUX2_2;

architecture Behavioral of MUX2_2 is
begin
	output <= in1 when sel = '0' else in2;
end Behavioral;

-- Select between 2 1 bits
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2_1 is
	Port(
		in1, in2 : in std_logic;
		sel : in std_logic;
		output : out std_logic 
	);
end MUX2_1;

architecture Behavioral of MUX2_1 is
begin
	output <= in1 when sel = '0' else in2;
end Behavioral;