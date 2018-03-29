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
use IEEE.NUMERIC_STD.ALL;

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
			  branch_en : out std_logic;
           branch_mode : out  STD_LOGIC_VECTOR (2 downto 0);
           branch_offset : out  STD_LOGIC_VECTOR (15 downto 0);
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
			  mem_mode : out std_logic_vector(1 downto 0);
			  output_en : out std_logic;
			  input_en : out std_logic;
			  input_in : in std_logic_vector(15 downto 0);
			  input_out : out std_logic_vector(15 downto 0);
			  raw_position_1 : out std_logic_vector(1 downto 0);
			  raw_position_2 : out std_logic_vector(1 downto 0));

end Decode;

architecture Behavioral of Decode is

-- RAW Detection
type counter_array is array (integer range 0 to 7) of std_logic_vector(1 downto 0);
signal raw_start_tracking : counter_array;
signal raw_tracker : counter_array;
signal rd_enable_1 : std_logic;
signal rd_enable_2 : std_logic;
signal raw_danger_1 : std_logic;
signal raw_danger_2 : std_logic;
signal raw_hazard_1 : std_logic;
signal raw_hazard_2 : std_logic;

--Signals
signal rd_index1 : STD_LOGIC_VECTOR(2 downto 0);
signal rd_index2 : STD_LOGIC_VECTOR(2 downto 0);
signal instruction_intrn : STD_LOGIC_VECTOR (15 downto 0);
signal relative_disp : STD_LOGIC_VECTOR (6 downto 0);
signal absolute_disp : STD_LOGIC_VECTOR (6 downto 0);
signal typ1_extn : STD_LOGIC_VECTOR (15 downto 0);
signal typ2_extn : STD_LOGIC_VECTOR (15 downto 0);

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
constant mov : std_logic_vector(6 downto 0)		:= "0010011";
constant brr : std_logic_vector(6 downto 0) 			:= "1000000";
constant brr_neg : std_logic_vector(6 downto 0) 	:= "1000001";
constant brr_zero : std_logic_vector(6 downto 0) 	:= "1000010";
constant br : std_logic_vector(6 downto 0) 			:= "1000011"; --uses ra
constant br_neg : std_logic_vector(6 downto 0) 		:= "1000100"; --uses ra
constant br_zero : std_logic_vector(6 downto 0) 	:= "1000101"; --uses ra
constant br_sub : std_logic_vector(6 downto 0) 		:= "1000110"; --uses ra
constant rtn	: std_logic_vector(6 downto 0)		:= "1000111";

begin

--signal assignments--
c1 <= instruction_intrn(3 downto 0); --shift
ra_index <= "111" when instruction_intrn(15 downto 9) = br_sub else instruction_intrn(8 downto 6);
		
-- Check if we're reading from rd_idx1
with instruction_intrn(15 downto 9) select
	rd_enable_1 <=
		'1' when add_op | sub_op | mul_op | nand_op | shl_op | shr_op | test_op |
			out_op | br | br_neg | br_zero | br_sub | rtn | load | store | mov,
		'0' when others;
		
-- Check if we're reading from rd_idx2
with instruction_intrn(15 downto 9) select
	rd_enable_2 <= 
		'1' when add_op | sub_op | mul_op | nand_op,
		'0' when others;
		
-- Get the RAW countdown for the current read index
raw_position_1 <= raw_tracker(to_integer(unsigned(rd_index1))) when rd_enable_1 = '1' else "00";
raw_position_2 <= raw_tracker(to_integer(unsigned(rd_index2))) when rd_enable_2 = '1' else "00";

-- Branching signals
branch_mode <= instruction_intrn(11 downto 9);
branch_en <= '1' when instruction_intrn(15 downto 13) = "100" else '0';

ALU_Mode <=
	instruction_intrn(11 downto 9) when instruction_intrn(15 downto 12) = "0000" else
	"000";
-- Select Writeback Mode
with instruction_intrn(15 downto 9) select
	Writeback_Mode <= "00" when test_op | out_op | brr | brr_neg | brr_zero | br | br_neg | 
		br_zero | rtn | nop_op,
	"01" when others;
--select shift operation
with instruction_intrn(15 downto 9) select
	Immediate <= "00000001" when shl_op | shr_op,
	"00000000" when others;
--select read index 1 for regfile	
with instruction_intrn(15 downto 9) select
	rd_index1 <= 	instruction_intrn(5 downto 3) when add_op | sub_op | mul_op | nand_op,
						instruction_intrn(8 downto 6) when shl_op | shr_op | test_op | 
						br | br_neg | br_zero | br_sub | out_op,
						"111" when rtn,
						"000" when others;	
rd_index2 <= instruction_intrn(2 downto 0);
--branch offset selection		
typ1_extn <= "1111111" & instruction_intrn(8 downto 0) when instruction_intrn(8) = '1' else
				 "0000000" & instruction_intrn(8 downto 0);

typ2_extn <= "1111111111" & instruction_intrn(5 downto 0) when instruction_intrn (5) = '1' else
				 "0000000000" & instruction_intrn(5 downto 0);
					  
with instruction_intrn(15 downto 9) select
	branch_offset(15 downto 0) <= typ1_extn when brr | brr_neg | brr_zero,
										   typ2_extn when others;
--load/store instruction selection
with instruction_intrn (15 downto 9) select
	immediate_mode <= instruction_intrn(8) when load_imm,
	'0' when others;
with instruction_intrn(15 downto 9) select	
	mem_mode <= "11" when store,
					"10" when load,
					"00" when others;
	
-- Configure input/output
output_en <= '1' when instruction_intrn(15 downto 9) = out_op else '0';
input_en <= '1' when instruction_intrn(15 downto 9) = in_op else '0';
	
--reg file (Inserted 0 for reset for testing)
reg_file : entity work.register_file port map(rst, clk, rd_index1, 
	rd_index2, rd_data1, rd_data2, wr_index, wr_data, wr_enable);
	
	--latching		
	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				instruction_intrn <= x"0000";
				pc_out <= x"0000";
				input_out <= x"0000";
				for i in 0 to 7 loop
					raw_tracker(i) <= "00";
				end loop;
			else
				instruction_intrn <= instruction;
				pc_out <= pc_in;
				
				-- Set up signals for the counters
				case instruction(15 downto 9) is
					when br_sub	=> 
						raw_start_tracking(7) <= "11";
					when add_op =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when sub_op =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when mul_op =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when nand_op =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when shl_op =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when shr_op =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when in_op =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when load =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when load_imm =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when mov =>
						raw_start_tracking(to_integer(unsigned(instruction(8 downto 6)))) <= "11";
					when others => 
				end case;
		
				-- Update counters
				for i in 0 to 7 loop
					if(raw_tracker(i) /= "00") then
						raw_tracker(i) <= std_logic_vector(unsigned(raw_tracker(i)) - 1);
					end if;
					if(raw_start_tracking(i) = "11") then
						raw_tracker(i) <= raw_start_tracking(i);
						raw_start_tracking(i) <= "00";
					end if;
				end loop;
				
				input_out <= input_in;
			end if;
		end if;
	end process;

end Behavioral;

