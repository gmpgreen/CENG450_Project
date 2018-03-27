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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( 
			  rst : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  RW_Enable : in  STD_LOGIC;
           Address : in  STD_LOGIC_VECTOR (15 downto 0);
           WR_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           RD_Data : out  STD_LOGIC_VECTOR (15 downto 0));
end RAM;

architecture Behavioral of RAM is

signal internal_enable : STD_LOGIC;
signal addr_sig : STD_LOGIC_VECTOR(15 downto 0);
signal write_sig : STD_LOGIC_VECTOR(15 downto 0);

type RAM_type is array (0 to 255) of std_logic_vector (15 downto 0);

begin

--latch	
	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				RW_Enable <= '0';
				Address <= x"0000";
				WR_Data  <= x"0000";
			else
				internal_enable <= RW_Enable;
				addr_sig <= Address;
				write_sig <= WR_Data;
			end if;
		end if;
	end process;

end Behavioral;

