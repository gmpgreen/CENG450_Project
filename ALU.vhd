----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:12:17 01/31/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use work.MUX.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( in1 : in  STD_LOGIC_VECTOR(15 downto 0);
           in2 : in  STD_LOGIC_VECTOR(15 downto 0);
           alu_mode : in  STD_LOGIC_VECTOR(2 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR(15 downto 0);
           z_flag : out  STD_LOGIC;
           n_flag : out  STD_LOGIC);
end ALU;


architecture Behavioral of ALU is
-- Constants
constant nop_op : std_logic_vector(2 downto 0) := "000";
constant add_op : std_logic_vector(2 downto 0) := "001";
constant sub_op : std_logic_vector(2 downto 0) := "010";
constant mul_op : std_logic_vector(2 downto 0) := "011";
constant nand_op : std_logic_vector(2 downto 0) := "100";
constant shl_op : std_logic_vector(2 downto 0) := "101";
constant shr_op : std_logic_vector(2 downto 0) := "110";

-- Signals
type result_array is array (integer range 0 to 6) of std_logic_vector(15 downto 0);
signal operation_results : result_array;
signal result_intermediate : std_logic_vector(15 downto 0); -- Added so that the result can be read for Z & N.

begin

-- Concurrent operations
operation_results(1) <= std_logic_vector(signed(in1) + signed(in2));
operation_results(2) <= std_logic_vector(signed(in1) - signed(in2));
operation_results(3) <= std_logic_vector(signed(in1) * signed(in2));
operation_results(4) <= std_logic_vector(in1 nand in2);
shift_left : entity work.barrel_shift_left port map(in1, in2(3 downto 0), operation_results(5));
--Barrel_Shift_Right : entity work.Barrel_Shift_Right port map(in1, in2(3 downto 0), operation_results(5));

-- Assignment of result
result_intermediate <= 
	operation_results(0) when (alu_mode = nop_op) else
	operation_results(1) when (alu_mode = add_op) else
	operation_results(2) when (alu_mode = sub_op) else
	operation_results(3) when (alu_mode = mul_op) else
	operation_results(4) when (alu_mode = nand_op) else
	operation_results(5) when (alu_mode = shl_op) else
	operation_results(6) when (alu_mode = shr_op);
	
-- Pipeline result through
result <= result_intermediate;

-- Set zero and negative flags
z_flag <= '1' when (result_intermediate = x"0000") else '0';
n_flag <= '1' when (result_intermediate(15) = '1') else '0';
	
end Behavioral;

