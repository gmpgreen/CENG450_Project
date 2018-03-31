
--
-- Created on Mon Mar  7 15:55:34 PST 2016
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;


entity ROM_VHDL is
    port(
         clk      : in  std_logic;
         addr     : in  std_logic_vector (15 downto 0);
         data     : out std_logic_vector (15 downto 0)
         );
end ROM_VHDL;

architecture BHV of ROM_VHDL is

    type ROM_TYPE is array (0 to 127 ) of std_logic_vector (15 downto 0);

    constant rom_content : ROM_TYPE := (
	000 => "0100001000000000", -- IN R0 , -2  -- This example tests how fast a multiplication operation is performed.
	001 => "0100001001000000", -- IN R1 , 03  -- The values to be loaded into the corresponding resgister.
	002 => "0100001010000000", -- IN R2 , 01
	003 => "0100001011000000", -- IN R3 , 05  --  End of initialization
	004 => "0000011110000011", -- MUL R6, R0, R3
	005 => "1000000111111111", -- BRR -1
	others => x"0000" ); -- NOP
begin

p1:    process (clk)
	 variable add_in : integer := 0;
    begin
        if rising_edge(clk) then
					 add_in := conv_integer(unsigned(addr));
                data <= rom_content(add_in);
        end if;
    end process;
end BHV;


