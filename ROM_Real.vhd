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
    Port ( addr : in  STD_LOGIC_VECTOR (15 downto 0);
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
	constant out_op : std_logic_vector(6 downto 0)  := "0100000";
	constant in_op : std_logic_vector(6 downto 0)   := "0100001";
	constant load_imm : std_logic_vector(6 downto 0):= "0010010";
	constant load : std_logic_vector(6 downto 0)		:= "0010000";
	constant store : std_logic_vector(6 downto 0)	:= "0010001";
	constant brr : std_logic_vector(6 downto 0) 		:= "1000000";
	constant brr_neg : std_logic_vector(6 downto 0) := "1000001";
	constant brr_zero : std_logic_vector(6 downto 0):= "1000010";
	constant br : std_logic_vector(6 downto 0) 		:= "1000011";
	constant br_neg : std_logic_vector(6 downto 0) 	:= "1000100";
	constant br_zero : std_logic_vector(6 downto 0) := "1000101";
	constant br_sub : std_logic_vector(6 downto 0) 	:= "1000110"; 
	constant rtn	: std_logic_vector(6 downto 0)	:= "1000111";
	
	-- Next byte
	signal odd_byte : std_logic_vector(15 downto 0);

	-- ROM Data
	type ROM_TYPE is array (0 to 255) of std_logic_vector (7 downto 0);

	constant rom_content : ROM_TYPE := (
		in_op  & "0", "00000000", -- R0 = 02
		in_op  & "0", "01000000", -- R1 = 03
		in_op  & "0", "10000000", -- R2 = 01
		in_op  & "0", "11000000", -- R3 = 05
		in_op  & "1", "00000000", -- R4 = 00
		in_op  & "1", "01000000", -- R5 = 01
		in_op  & "1", "10000000", -- R6 = 05
		in_op  & "1", "11000000", -- R7 = 00
		out_op & "0", "00000000",
		out_op & "0", "01000000",
		out_op & "0", "10000000",
		out_op & "0", "11000000",
		out_op & "1", "00000000",
		out_op & "1", "01000000",
		out_op & "1", "10000000",
		out_op & "1", "11000000",
		br_sub & "1", "00000001", -- Store return address, go to subroutine
		brr    & "1", "11111111", -- infinite loop (at program's end)
		add_op & "0", "10001101", -- Start of subroutine. Runs 5 times, R2 <-- R1 + 1
		sub_op & "1", "10110101", -- R6 <-- R6 - 1 (loop counter)
		test_op & "1","10000000", -- Check R6
		br_zero & "1", "00000001", -- Branch if R6 was zero to R4 + 1
		brr     & "1", "11111011", -- Jump to begining of subroutine
		rtn     & "0", "00000000", -- Return to the infinite loop
		test_op & "0", "00000000", -- TEST r0
		test_op & "1", "00000000", -- TEST r4
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		add_op & "1", "00" & "000" & "001", -- ADD r4,r0,r1
		shl_op & "0", "01" & "00" & "0100", -- SHL r1#4
		shl_op & "1", "10" & "00" & "1101", -- SHL r6#13
		shr_op & "1", "11" & "00" & "0101", -- SHR r7#5
		mul_op & "1", "01" & "000" & "011", -- MUL r5,r0,r3
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nand_op & "1", "11" & "010" & "011", -- NAND r7,r2,r3
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		add_op & "0", "10" & "100" & "001", -- ADD r2,r4,r1
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		nop_op & "0", "00000000",
		"00000000", "00000000");
begin

	odd_byte_adder : entity work.adder_16bit port map(addr, x"0001", odd_byte);
	--odd_byte <= addr(15 downto 1) & '1';
	data <= rom_content(conv_integer(unsigned(addr))) & rom_content(conv_integer(unsigned(odd_byte)));
	 
end Behavioral;

