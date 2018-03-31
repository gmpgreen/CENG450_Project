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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( 
			  clk : in STD_LOGIC;
			  RAM_Enable : in STD_LOGIC;
			  RW_Enable : in  STD_LOGIC;
           Address : in  STD_LOGIC_VECTOR (15 downto 0);
           WR_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           RD_Data : out  STD_LOGIC_VECTOR (15 downto 0));
end RAM;

architecture Behavioral of RAM is
	
	type RAM_type is array (0 to 1024) of std_logic_vector (15 downto 0);
	
	signal RAM_memory : RAM_type;
	signal address_intrn : std_logic_vector(15 downto 0);
	signal rw_enable_intrn : std_logic;
begin

	rw_enable_intrn <= RW_Enable when RAM_Enable = '1' else '0';
	address_intrn <= Address when RAM_Enable = '1' else x"0000";

	RAM_memory(conv_integer(unsigned('0' & address_intrn(15 downto 1)))) <= WR_Data when rw_enable_intrn = '1';
	RD_Data <= RAM_memory(conv_integer(unsigned('0' & address_intrn(15 downto 1)))) when rw_enable_intrn = '0';
	
end Behavioral;

