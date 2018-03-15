----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:54:26 03/07/2018 
-- Design Name: 
-- Module Name:    Branch - Behavioral 
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

entity Branch is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           branch_instr_address : in  STD_LOGIC_VECTOR (15 downto 0);
			  reg_val : in std_logic_vector(15 downto 0);
           next_instr_address : in  STD_LOGIC_VECTOR (15 downto 0);
			  branch_mode_en : in std_logic;
           branch_mode : in  STD_LOGIC_VECTOR (2 downto 0);
           branch_offset : in  STD_LOGIC_VECTOR (15 downto 0);
           Z : in  STD_LOGIC;
           N : in  STD_LOGIC;
           branch_enable : out  STD_LOGIC;
           branch_address : out  STD_LOGIC_VECTOR (15 downto 0);
           writeback_enable : out  STD_LOGIC;
           return_address : out  STD_LOGIC_VECTOR (15 downto 0));
end Branch;

architecture Behavioral of Branch is

-- Branch modes
constant brr : std_logic_vector(2 downto 0) := "000";
constant brr_n : std_logic_vector(2 downto 0) := "001";
constant brr_z : std_logic_vector(2 downto 0) := "010";
constant br : std_logic_vector(2 downto 0) := "011";
constant br_n : std_logic_vector(2 downto 0) := "100";
constant br_z : std_logic_vector(2 downto 0) := "101";
constant br_sub : std_logic_vector(2 downto 0) := "110";
constant ret : std_logic_vector(2 downto 0) := "111";

-- Latch signals
signal br_instr_addr_intrn : std_logic_vector(15 downto 0);
signal reg_val_intrn : std_logic_vector(15 downto 0);
signal nxt_instr_addr_intrn : std_logic_vector(15 downto 0);
signal branch_mode_en_intrn : std_logic;
signal branch_mode_intrn : std_logic_vector(2 downto 0);
signal branch_offset_intrn : std_logic_vector(15 downto 0);
signal N_intrn : std_logic;
signal Z_intrn : std_logic;

-- Extra signals
signal muxed_relative_addr : std_logic_vector(15 downto 0);
signal first_adder_output : std_logic_vector(15 downto 0);
signal second_adder_output : std_logic_vector(15 downto 0);
signal branch_taken : std_logic;
signal subroutine_mode : std_logic;
signal branch_enable_intrn : std_logic;

begin
	
	-- Decide if you can take the branch
	branch_taken <=
		Z_intrn when (branch_mode_intrn = brr_z) else
		Z_intrn when (branch_mode_intrn = br_z) else
		N_intrn when (branch_mode_intrn = brr_n) else
		N_intrn when (branch_mode_intrn = br_n) else
		'1';
		
	-- Set branch enable output bit
	branch_enable <= branch_mode_en_intrn when (branch_taken = '1') else '0';
	branch_enable_intrn <= branch_mode_en_intrn when (branch_taken = '1') else '0';
	
	-- Determine whether its a relative or absolute branch
	with branch_mode_intrn select
		muxed_relative_addr <=
			br_instr_addr_intrn(15 downto 1) & '0' when brr | brr_n | brr_z,
			reg_val_intrn(15 downto 1) & '0' when others;
	
	-- Calculate the branch address
	first_adder : entity work.Adder_16bit port map(muxed_relative_addr, branch_offset_intrn, first_adder_output);
	second_adder : entity work.Adder_16bit port map(first_adder_output, branch_offset_intrn, second_adder_output);
	
	-- Determine the branch address
	branch_address <= reg_val_intrn when (branch_mode_intrn = ret) else second_adder_output;
	
	-- Return address
	return_address <= nxt_instr_addr_intrn;
	
	-- Enable/Disable writeback
	subroutine_mode <= '1' when (branch_mode_intrn = br_sub) else '0';
	writeback_enable <= subroutine_mode when (branch_enable_intrn = '1') else '0';

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				br_instr_addr_intrn <= x"0000";
				reg_val_intrn <= x"0000";
				nxt_instr_addr_intrn <= x"0000";
				branch_mode_en_intrn <= '0';
				branch_mode_intrn <= "000";
				branch_offset_intrn <= x"0000";
				N_intrn <= '0';
				Z_intrn <= '0';
			else
				br_instr_addr_intrn <= branch_instr_address;
				reg_val_intrn <= reg_val;
				nxt_instr_addr_intrn <= next_instr_address;
				branch_mode_en_intrn <= branch_mode_en;
				branch_mode_intrn <= branch_mode;
				branch_offset_intrn <= branch_offset;
				N_intrn <= N;
				Z_intrn <= Z;
			end if;
		end if;
	end process;

end Behavioral;

