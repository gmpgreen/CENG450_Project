----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:15 02/21/2018 
-- Design Name: 
-- Module Name:    Fetch - Behavioral 
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

entity Fetch is
    Port ( rst : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  branch_enable : in  STD_LOGIC;
           branch_address : in  STD_LOGIC_VECTOR (15 downto 0);
           instruction : out  STD_LOGIC_VECTOR (15 downto 0);
           instruction_addr : out  STD_LOGIC_VECTOR (15 downto 0));
end Fetch;

architecture Behavioral of Fetch is

	signal br_en : std_logic;
	signal br_addr : std_logic_vector(15 downto 0);
	signal PC_incr : std_logic_vector(15 downto 0);
	signal PC : std_logic_vector(15 downto 0);
	signal instr_addr : std_logic_vector(15 downto 0);

begin

	PC_Adder : entity work.adder_16bit port map(instr_addr, x"0002", PC_incr);
	Instr_Addr_Selector : entity work.mux2_16 port map(PC, br_addr, br_en, instr_addr);
	rom : entity work.rom port map(instr_addr, instruction);
	
	instruction_addr <= instr_addr;
	
	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				br_en <= '0';
				br_addr <= x"0000";
				PC <= x"0000";
			else
				br_en <= branch_enable;
				br_addr <= branch_address;
				PC <= PC_incr;
			end if;
		end if;
	end process;

end Behavioral;

