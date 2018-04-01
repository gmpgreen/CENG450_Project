
--
-- Created on Thu Mar 24 13:46:54 PDT 2016
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
	000 => "0010010000001111", -- LOADIMM.LOWER #F
	001 => "0010010100000101", -- LOADIMM.UPPER #5
	002 => "0010011001111000", -- MOV R1, R7
	003 => "0010010000000000", -- LOADIMM.LOWER #0
	004 => "0010010100000110", -- LOADIMM.UPPER #6
	005 => "0010011010111000", -- MOV R2, R7
	006 => "0010001010001000", -- STORE R2, R1
	007 => "0010000011010000", -- LOAD R3, R2
	008 => "0010011100010000", -- MOV R4, R2
	009 => "0010011110011000", -- MOV R6, R3
	010 => "0010011101011000", -- MOV R5, R3
	011 => "0010011000011000", -- MOV R0, R3
	others => x"0000" ); -- NOP
begin

p1:    process (clk)
	 variable add_in : integer := 0;
    begin
        if rising_edge(clk) then
					 add_in := conv_integer(unsigned('0' & addr(15 downto 1)));
                data <= rom_content(add_in);
        end if;
    end process;
end BHV;


