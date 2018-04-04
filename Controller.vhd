----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:31:36 04/03/2018 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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

entity Controller is
    Port ( clk : in  STD_LOGIC;
			  disp_clk : in STD_LOGIC;
			  garbage : out STD_LOGIC;
           rst : in  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           sseg : out  STD_LOGIC_VECTOR (6 downto 0);
           input : in  STD_LOGIC_VECTOR (7 downto 0);
			  output : out std_logic_vector(7 downto 0));
end Controller;

architecture Behavioral of Controller is

signal sign_ext : std_logic_vector(7 downto 0);
signal input_extended : std_logic_vector(15 downto 0);
signal output_extended : std_logic_vector(15 downto 0);

signal count_tracker : unsigned(15 downto 0);
signal disp_true_clk : std_logic;

begin
	
	-- Determine sign of input
	sign_ext <= (others => input(7));

	-- Sign extend the input
	input_extended <= sign_ext & input;

	Processor : entity work.pipeline port map(clk, rst, input_extended, output_extended);
	
	output <= output_extended(7 downto 0);
	
	sseg_display : entity work.display_controller port map(disp_true_clk, rst, 
		output_extended(15 downto 12), output_extended(11 downto 8), 
		output_extended(7 downto 4), output_extended(3 downto 0),
		an, sseg);
		
	garbage <= disp_clk;
		
	process(disp_clk)
	begin
		if rising_edge(disp_clk) then
			if rst = '1' then
				count_tracker <= (others => '0');
				disp_true_clk <= '0';
			else
				if count_tracker = x"30D40" then
					disp_true_clk <= not disp_true_clk;
					count_tracker <= (others => '0');
				else
					count_tracker <= count_tracker + "1";
				end if;
			end if;
		end if;
	end process;

end Behavioral;

