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
    Port ( clk_external : in  STD_LOGIC;
			  clk_internal : in STD_LOGIC;
           rst : in  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           sseg : out  STD_LOGIC_VECTOR (6 downto 0);
           input : in  STD_LOGIC_VECTOR (7 downto 0);
			  output : out std_logic_vector(7 downto 0));
end Controller;

architecture Behavioral of Controller is

signal rst_internal : std_logic;

signal sign_ext : std_logic_vector(7 downto 0);
signal input_extended : std_logic_vector(15 downto 0);
signal output_extended : std_logic_vector(15 downto 0);

signal count_tracker : unsigned(15 downto 0);
signal display_clk : std_logic;

begin
	
	-- Determine sign of input
	sign_ext <= (others => input(7));

	-- Sign extend the input
	input_extended <= sign_ext & input;

	Processor : entity work.pipeline port map(clk_external, rst_internal, input_extended, output_extended);
	
	output <= output_extended(7 downto 0);
	
	sseg_display : entity work.display_controller port map(display_clk, rst_internal, 
		output_extended(15 downto 12), output_extended(11 downto 8), 
		output_extended(7 downto 4), output_extended(3 downto 0),
		an, sseg);
		
	Prescaler : entity work.clock_prescaler port map(clk_internal, rst_internal, x"20000", display_clk);
	
	process(clk_external)
	begin
		if falling_edge(clk_external) then
			rst_internal <= rst;
		end if;
	end process;

end Behavioral;

