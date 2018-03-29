----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:48:29 03/27/2018 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( 
			  clk : in STD_LOGIC;
			  RW_Enable : in  STD_LOGIC;
           Address : in  STD_LOGIC_VECTOR (15 downto 0);
           WR_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           RD_Data : out  STD_LOGIC_VECTOR (15 downto 0));
end RAM;

architecture Behavioral of RAM is
	
	type RAM_type is array (0 to 1024) of std_logic_vector (15 downto 0);
	
	signal RAM_memory : RAM_type;

begin

	
	process(clk)
	begin
		if rising_edge(clk) then
			if (RW_Enable = '1') then
				RAM_memory(to_integer(unsigned('0' & Address(15 downto 1)))) <= WR_Data;
			else
				RD_Data <= RAM_memory(to_integer(unsigned('0' & Address(15 downto 1))));
			end if;
		end if;
	end process;
	
	
end Behavioral;

