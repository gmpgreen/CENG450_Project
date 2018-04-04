----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:35:19 04/04/2018 
-- Design Name: 
-- Module Name:    Clock_Prescaler - Behavioral 
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

entity Clock_Prescaler is
    Port ( clk_in : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           prescaler : in  STD_LOGIC_VECTOR(19 downto 0);
           clk_out : out  STD_LOGIC);
end Clock_Prescaler;

architecture Behavioral of Clock_Prescaler is
signal count : unsigned(19 downto 0);
signal clk_intermediate : std_logic;
begin

	clk_out <= clk_intermediate;

	process(clk_in)
	begin
		if rising_edge(clk_in) then
			if rst = '1' then
				count <= (others => '0');
				clk_intermediate <= '0';
			else
				if count = unsigned(prescaler) then
					clk_intermediate <= not clk_intermediate;
					count <= (others => '0');
				else
					count <= count + "1";
				end if;
			end if;
		end if;
	end process;

end Behavioral;

