----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:53:39 02/21/2018 
-- Design Name: 
-- Module Name:    Execute - Behavioral 
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

entity Execute is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  frz : in 	STD_LOGIC;
			  alu_rst : in STD_LOGIC;
			  ALU_Mode : in  STD_LOGIC_VECTOR (2 downto 0);
           input1 : in  STD_LOGIC_VECTOR (15 downto 0);
           input2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  shift : in std_logic_vector(3 downto 0);
           ALU_Result : out  STD_LOGIC_VECTOR(15 downto 0);
			  ra_idx_in : in std_logic_vector(2 downto 0);
			  ra_idx_out : out std_logic_vector(2 downto 0);
           Mem_Mode_In : in  STD_LOGIC_VECTOR (1 downto 0);
           Mem_Mode_Out : out  STD_LOGIC_VECTOR (1 downto 0);
			  Imediate_Mode_In : std_logic;
			  Immediate_Mode_Out : out std_logic;
           Wr_Back_Mode_In : in  STD_LOGIC_VECTOR (2 downto 0);
           Wr_Back_Mode_Out : out  STD_LOGIC_VECTOR (2 downto 0);
           Load_Imm_In : in  STD_LOGIC_VECTOR (7 downto 0);
           Load_Imm_Out : out  STD_LOGIC_VECTOR (7 downto 0);
			  reg1_val : out std_logic_vector(15 downto 0);
			  reg2_val : out std_logic_vector(15 downto 0);
			  output_en_in : in std_logic;
			  output_en_out : out std_logic;
			  input_en_in : in std_logic;
			  input_en_out : out std_logic;
			  input_in : in std_logic_vector(15 downto 0);
			  input_out : out std_logic_vector(15 downto 0);
			  raw_hazard : out std_logic;
			  raw_position_1 : in std_logic_vector(1 downto 0);
			  raw_position_2 : in std_logic_vector(1 downto 0);
			  writeback_memory : in std_logic_vector(15 downto 0);
			  writeback_writeback : in std_logic_vector(15 downto 0);
			  writeback_execute : in std_logic_vector(15 downto 0);
			  writeback_future : out std_logic_vector(15 downto 0);
			  --raw_hazard : out std_logic;
			  -- Branch inputs/outputs
           branch_instr_address : in  STD_LOGIC_VECTOR (15 downto 0);
           next_instr_address : in  STD_LOGIC_VECTOR (15 downto 0);
			  branch_mode_en : in std_logic;
           branch_mode : in  STD_LOGIC_VECTOR (2 downto 0);
           branch_offset : in  STD_LOGIC_VECTOR (15 downto 0);
           branch_enable : out  STD_LOGIC;
           branch_address : out  STD_LOGIC_VECTOR (15 downto 0);
           wr_branch : out  STD_LOGIC;
           return_address : out  STD_LOGIC_VECTOR (15 downto 0));
end Execute;

architecture Behavioral of Execute is

-- Used to decrement raw_positions in the event of a freeze
-- See RAW Handler for more details on how this works
type lookup is array (integer range 0 to 3) of std_logic_vector(1 downto 0);
constant subtract_lookup : lookup := ("00", "00", "01", "10");

-- Branch Signals
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
signal nxt_instr_addr_intrn : std_logic_vector(15 downto 0);
signal branch_mode_en_intrn : std_logic;
signal branch_mode_intrn : std_logic_vector(2 downto 0);
signal branch_offset_intrn : std_logic_vector(15 downto 0);

-- Extra signals
signal muxed_relative_addr : std_logic_vector(15 downto 0);
signal br_adder_output : std_logic_vector(15 downto 0);
signal branch_taken : std_logic;
signal subroutine_mode : std_logic;
signal branch_enable_intrn : std_logic;
signal wr_branch_intrn : std_logic;
signal load_imm : std_logic_vector(7 downto 0);
signal load_imm_reg : std_logic_vector(15 downto 0);
signal imm_mode : std_logic;

-- ALU and RAW signals
signal alu_mode_buf : std_logic_vector(2 downto 0);
signal in1 : std_logic_vector(15 downto 0);
signal in2 : std_logic_vector(15 downto 0);
signal wrback_ex : std_logic_vector(15 downto 0);
signal wrback_mem : std_logic_vector(15 downto 0);
signal wrback_wrback : std_logic_vector(15 downto 0);
signal wrback_completed : std_logic_vector(15 downto 0);
signal wrback_ovrrun_1 : std_logic;
signal wrback_ovrrun_2 : std_logic;
signal c1 : std_logic_vector(15 downto 0);
signal muxed_in2 : std_logic_vector(15 downto 0);
signal muxed_in1 : std_logic_vector(15 downto 0);
signal alu_result_buf : std_logic_vector(15 downto 0);
signal output_en : std_logic;
signal raw_pos_1 : std_logic_vector(1 downto 0);
signal raw_pos_2 : std_logic_vector(1 downto 0);
signal input_inner : std_logic_vector(15 downto 0);
signal input_en : std_logic;
signal wr_mode : std_logic_vector(2 downto 0);
signal N : std_logic;
signal Z : std_logic;
signal mem_mode : std_logic_vector(1 downto 0);

begin

	ALU : entity work.alu port map(muxed_in1, muxed_in2, alu_mode_buf, clk, alu_rst, alu_result_buf, Z, N);
	
	-- Used for both result and output
	ALU_Result <= alu_result_buf when output_en = '0' else muxed_in1;
	
	load_imm_reg <= 
		muxed_in2(15 downto 8) & load_imm when imm_mode = '0' else
		load_imm & muxed_in2(7 downto 0);
		
	-- There may be a case where the result is not ready by the end of the previous
	-- execute. In this case, we have no choice but to wait.
	raw_hazard <= 
		'1' when raw_pos_1 = "11" else 
		'1' when raw_pos_2 = "11" else
		'0';
	
	-- Find the future writeback
	writeback_future <=
		nxt_instr_addr_intrn when wr_branch_intrn = '1' else -- Subroutine return address
		input_inner when input_en = '1' else
		alu_result_buf when wr_mode = "001" else
		load_imm_reg when wr_mode = "011" else
		muxed_in2 when wr_mode = "100" else
		x"0000";
	
	-- Choose input 1 for ALU, while avoiding RAW conditions
	muxed_in1 <= 
		wrback_completed when wrback_ovrrun_1 = '1' else
		wrback_ex when raw_pos_1 = "11" else
		wrback_mem when raw_pos_1 = "10" else
		wrback_wrback when raw_pos_1 = "01" else
		in1;
	
	-- Choose input 2 for ALU, while avoiding RAW conditions
	muxed_in2 <= 
		wrback_completed when wrback_ovrrun_2 = '1' else
		wrback_ex when raw_pos_2 = "11" else
		wrback_mem when raw_pos_2 = "10" else
		wrback_wrback when raw_pos_2 = "01" else
		c1 when alu_mode_buf = "101" else
		c1 when alu_mode_buf = "110" else
		in2;
	
	-- Then the RAW adjusted results on to other stages of the pipeline
	reg1_val <= muxed_in1;
	reg2_val <= muxed_in2;
					 
	output_en_out <= output_en;
	
	-- Branch section -- 
	-- Decide if you can take the branch
	branch_taken <=
		Z when (branch_mode_intrn = brr_z) else
		Z when (branch_mode_intrn = br_z) else
		N when (branch_mode_intrn = brr_n) else
		N when (branch_mode_intrn = br_n) else
		'1';
		
	Mem_mode_out <= mem_mode;
		
	-- Set branch enable output bit
	branch_enable <= branch_mode_en_intrn when (branch_taken = '1') else '0';
	branch_enable_intrn <= branch_mode_en_intrn when (branch_taken = '1') else '0';
	
	-- Determine whether its a relative or absolute branch
	with branch_mode_intrn select
		muxed_relative_addr <=
			br_instr_addr_intrn(15 downto 1) & '0' when brr | brr_n | brr_z,
			muxed_in1(15 downto 1) & '0' when others;
	
	-- Calculate the branch address
	branch_adder : entity work.Adder_16bit port map(muxed_relative_addr, branch_offset_intrn, br_adder_output);
	
	-- Determine the branch address
	branch_address <= muxed_in1 when (branch_mode_intrn = ret) else br_adder_output;
	
	-- Return address
	return_address <= nxt_instr_addr_intrn;
	
	-- Enable/Disable writeback
	subroutine_mode <= '1' when (branch_mode_intrn = br_sub) else '0';
	wr_branch_intrn <= subroutine_mode when (branch_enable_intrn = '1') else '0';
	wr_branch <= wr_branch_intrn;

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				alu_mode_buf <= "000";
				in1 <= x"0000";
				in2 <= x"0000";
				c1 <= x"0000";
				Wr_Back_Mode_Out <= "000";
				mem_mode <= "00";
				load_imm <= x"00";
				Load_Imm_Out <= x"00";
				Immediate_Mode_Out <= '0';
				imm_mode <= '0';
				ra_idx_out <= "000";
				output_en <= '0';
				input_en_out <= '0';
				input_out <= x"0000";
				wrback_ex <= x"0000";
				wrback_mem <= x"0000";
				wrback_wrback <= x"0000";
				wrback_completed <= x"0000";
				wrback_ovrrun_1 <= '0';
				wrback_ovrrun_2 <= '0';
				raw_pos_1 <= "00";
				raw_pos_2 <= "00";
				input_inner <= x"0000";
				input_en <= '0';
				wr_mode <= "000";
				-- Branch signals
				wr_mode <= "000";
				br_instr_addr_intrn <= x"0000";
				nxt_instr_addr_intrn <= x"0000";
				branch_mode_en_intrn <= '0';
				branch_mode_intrn <= "000";
				branch_offset_intrn <= x"0000";
			elsif (frz = '1') then
				-- Will sometimes need to wait for RAW conditions to settle.
				-- These signals will still need to update while waiting
				wrback_ex <= writeback_execute;
				wrback_mem <= writeback_memory;
				wrback_wrback <= writeback_writeback;
				
				mem_mode <= "00";
				
				-- There is a possibility that a RAW signal will writeback while 
				-- we're waiting. If this is the case, we will need to keep a copy of
				-- it so that we can still use it, because Decode has forgotten about
				-- this instruction by now.
				wrback_completed <= wrback_wrback;
				if raw_pos_1 = "01" then
					wrback_ovrrun_1 <= '1';
				end if;
				if raw_pos_2 = "01" then
					wrback_ovrrun_2 <= '1';
				end if;
				
				-- Decrement the position counters, because Memory and Writeback instructions
				-- can still propagate, but Decode isn't pointing at the right instruction to 
				-- let it handle this.
				raw_pos_1 <= subtract_lookup(to_integer(unsigned(raw_pos_1)));
				raw_pos_2 <= subtract_lookup(to_integer(unsigned(raw_pos_2)));
			else
				alu_mode_buf <= ALU_Mode;
				in1 <= input1;
				in2 <= input2;
				c1 <= x"000" & shift;
				Wr_Back_Mode_Out <= Wr_Back_Mode_In;
				mem_mode <= Mem_Mode_In;
				load_imm <= Load_Imm_In;
				Load_Imm_Out <= Load_Imm_In;
				Immediate_Mode_Out <= Imediate_Mode_In;
				imm_mode <= Imediate_Mode_In;
				ra_idx_out <= ra_idx_in;
				output_en <= output_en_in;
				input_en_out <= input_en_in;
				input_out <= input_in;
				wrback_ex <= writeback_execute;
				wrback_mem <= writeback_memory;
				wrback_wrback <= writeback_writeback;
				wrback_completed <= x"0000";
				wrback_ovrrun_1 <= '0';
				wrback_ovrrun_2 <= '0';
				raw_pos_1 <= raw_position_1;
				raw_pos_2 <= raw_position_2;
				input_inner <= input_in;
				input_en <= input_en_in;
				wr_mode <= Wr_Back_Mode_In;
				-- Branch signals
				br_instr_addr_intrn <= branch_instr_address;
				nxt_instr_addr_intrn <= next_instr_address;
				branch_mode_en_intrn <= branch_mode_en;
				branch_mode_intrn <= branch_mode;
				branch_offset_intrn <= branch_offset;
			end if;
		end if;
	end process;

end Behavioral;

