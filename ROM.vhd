----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:01:43 02/13/2018 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( clk : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (6 downto 0);
           data : out  STD_LOGIC_VECTOR (15 downto 0));
end ROM;

architecture Behavioral of ROM is

	-- Op Codes
	constant nop_op : std_logic_vector(6 downto 0)  := "0000000";
	constant add_op : std_logic_vector(6 downto 0)  := "0000001";
	constant sub_op : std_logic_vector(6 downto 0)  := "0000010";
	constant mul_op : std_logic_vector(6 downto 0)  := "0000011";
	constant nand_op : std_logic_vector(6 downto 0) := "0000100";
	constant shl_op : std_logic_vector(6 downto 0)  := "0000101";
	constant shr_op : std_logic_vector(6 downto 0)  := "0000110";
	constant test_op : std_logic_vector(6 downto 0) := "0000111";

	-- ROM Data
	type ROM_TYPE is array (0 to 127) of std_logic_vector (15 downto 0);

	constant rom_content : ROM_TYPE := (
		test_op & "000000000", -- TEST r0
		test_op & "100000000", -- TEST r4
		nop_op & "000000000",
		nop_op & "000000000",
		nop_op & "000000000",
		add_op & "100" & "000" & "001", -- ADD r4,r0,r1
		shl_op & "100" & "00" & "0100", -- SHL r4#4
		add_op & "100" & "100" & "001", -- ADD r4,r4,r1
		shl_op & "110" & "00" & "1101", -- SHL r6#13
		shr_op & "111" & "00" & "0101", -- SHR r7#5
		mul_op & "001" & "000" & "011", -- MUL r1,r0,f5
		nand_op & "010" & "010" & "011", -- NAND r2,r2,r3
		nop_op & "000000000",
		nop_op & "000000000",
		nop_op & "000000000",
		nop_op & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000",
		"0000000" & "000000000");
begin

p1:    process (clk)
	 variable add_in : integer := 0;
    begin
        if rising_edge(clk) then
					 add_in := conv_integer(unsigned(addr));
                data <= rom_content(add_in);
        end if;
    end process;
	 
end Behavioral;

