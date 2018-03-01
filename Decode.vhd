----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:09:16 02/21/2018 
-- Design Name: 
-- Module Name:    Decode - Behavioral 
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

entity Decode is
    Port ( 
			  rst : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  instruction : in  STD_LOGIC_VECTOR (15 downto 0);
			  ra_index : out std_logic_vector(2 downto 0);
           pc_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  pc_out : out STD_LOGIC_VECTOR (15 downto 0);
           branch_mode : out  STD_LOGIC_VECTOR (2 downto 0);
           branch_offset : out  STD_LOGIC_VECTOR (8 downto 0);
           ALU_Mode : out  STD_LOGIC_VECTOR (2 downto 0);
           Writeback_Mode : out  STD_LOGIC_VECTOR (1 downto 0);
           Immediate : out  STD_LOGIC_VECTOR (7 downto 0);
			  rd_data1 : out std_logic_vector(15 downto 0); 
			  rd_data2 : out std_logic_vector(15 downto 0);
			  wr_index : in std_logic_vector(2 downto 0);
			  wr_data : in std_logic_vector(15 downto 0);
			  wr_enable : in std_logic;
			  c1 : out std_logic_vector (3 downto 0);
			  immediate_mode : out std_logic;
			  mem_mode : out std_logic_vector(1 downto 0));

end Decode;

architecture Behavioral of Decode is

--Signals
signal rd_index1 : STD_LOGIC_VECTOR(2 downto 0);
signal rd_index2 : STD_LOGIC_VECTOR(2 downto 0);
signal instruction_intrn : STD_LOGIC_VECTOR (15 downto 0);

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

begin
--signal assignments
c1 <= instruction(3 downto 0); --shift
ra_index <= instruction(8 downto 6);

ALU_Mode <=
	instruction(11 downto 9) when instruction(15 downto 12) = "0000" else
	"000";
with instruction(15 downto 9) select
	Writeback_Mode <= "00" when test_op | out_op,
	"01" when others;
with instruction(15 downto 9) select
	Immediate <= "00000001" when shl_op | shr_op,
	"00000000" when others;
with instruction(15 downto 9) select
	rd_index1 <= instruction(5 downto 3) when add_op | sub_op | mul_op | nand_op,
	"000" when others;
with instruction(15 downto 9) select
	rd_index2 <= instruction(2 downto 0) when add_op | sub_op | mul_op | nand_op,
	"000" when others;
with instruction (15 downto 9) select
	immediate_mode <= instruction(8) when load_imm,
	'0' when others;
with instruction(15 downto 9) select	
	mem_mode <= "11" when store,
	"00" when others;
with instruction(15 downto 9) select	
	mem_mode <= "10" when load,
	"00" when others;
	
--latching		
	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				instruction_intrn <= x"0000";
				pc_out <= x"0000";
			else
				instruction_intrn <= instruction;
				pc_out <= pc_in;
			end if;
		end if;
	end process;

end Behavioral;
