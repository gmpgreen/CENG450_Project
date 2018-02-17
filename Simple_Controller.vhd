----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:52 02/13/2018 
-- Design Name: 
-- Module Name:    Simple_Controller - Behavioral 
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

entity Simple_Controller is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  alu_out : out std_logic_vector(15 downto 0);
			  instruction_thing : out std_logic_vector(15 downto 0);
			  z : out std_logic;
			  n : out std_logic);
end Simple_Controller;

architecture Behavioral of Simple_Controller is

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

-- Controller Signals
signal PC : std_logic_vector(6 downto 0) := "0000000";
signal PC_next : std_logic_vector(6 downto 0) := "0000000";
signal op : std_logic_vector(6 downto 0);

-- ROM Signals
signal rom_data : std_logic_vector(15 downto 0);
signal instruction : std_logic_vector(15 downto 0);

-- Register File Signals
signal rd_index1 : std_logic_vector(2 downto 0);
signal rd_index2 : std_logic_vector(2 downto 0);
signal rd_data1 : std_logic_vector(15 downto 0);
signal rd_data2 : std_logic_vector(15 downto 0);
signal wr_index : std_logic_vector(2 downto 0);
signal wr_data : std_logic_vector(15 downto 0);
signal wr_enable : std_logic;

-- ALU Signals
signal alu_in1 : std_logic_vector(15 downto 0);
signal alu_in2 : std_logic_vector(15 downto 0);
signal alu_mode : std_logic_vector(2 downto 0);
signal alu_result : std_logic_vector(15 downto 0);
signal z_flag : std_logic;
signal n_flag : std_logic;

-- I/O Signals
signal input : std_logic_vector(15 downto 0);
signal output : std_logic_vector(15 downto 0);

begin

	reg_file : entity work.register_file port map(rst, clk, rd_index1, rd_index2, rd_data1, rd_data2, wr_index, wr_data, wr_enable);
	alu : entity work.alu port map(alu_in1, alu_in2, alu_mode, clk, rst, alu_result, z_flag, n_flag);
	rom : entity work.rom port map(clk, PC, rom_data);
	pc_adder : entity work.adder_7bit port map(PC, "0000001", PC_next);
	-- Should make an IO module to hook up input and output signals here
	
	-- Set the op mode if ALU is being used
	with op select
		alu_mode <=
			op(2 downto 0) when add_op | sub_op | mul_op | nand_op | shl_op | shr_op,
			sub_op(2 downto 0) when test_op,
			"000" when others;
	
	-- Organize Reg File inputs
	with op select
		rd_index1 <= 
			instruction(5 downto 3) when add_op | sub_op | mul_op | nand_op,
			instruction(8 downto 6) when shl_op | shr_op | test_op | out_op,
			rd_index1 when others;				
	with op select
		rd_index2 <=
			instruction(2 downto 0) when add_op | sub_op | mul_op | nand_op,
			rd_index2 when others;
		
	-- Organize ALU inputs
	with op select
		alu_in1 <=
			rd_data1 when add_op | sub_op | mul_op | nand_op | shl_op | shr_op | test_op,
			alu_in1 when others;
	with op select
		alu_in2 <=
			x"000" & instruction(3 downto 0) when shl_op | shr_op,
			rd_data2 when add_op | sub_op | mul_op | nand_op,
			x"0000" when test_op,
			alu_in2 when others;
	
	-- Set the output I/O
	with op select
		output <=
			rd_data1 when out_op,
			output when others;
	
	-- Organize signals dependent on whether registers are going to be written to
	with op select
		wr_index <=
			instruction(8 downto 6) when add_op | sub_op | mul_op | nand_op | shl_op | shr_op | in_op,
			wr_index when others;
	with op select
		wr_data <=
			alu_result when add_op | sub_op | mul_op | nand_op | shl_op | shr_op,
			input when in_op,
			wr_data when others;
	with op select
		wr_enable <=
			'1' when add_op | sub_op | mul_op | nand_op | shl_op | shr_op | in_op,
			'0' when others;
			
	alu_out <= wr_data;
	instruction_thing <= instruction;
	z <= z_flag;
	n <= n_flag;
			
	process(clk)
	begin
		if rising_edge(clk) then
			instruction <= rom_data;
			op <= rom_data(15 downto 9);
			PC <= PC_next;
		end if;
	end process;
end Behavioral;

