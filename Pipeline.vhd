----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:48 02/28/2018 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
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

entity Pipeline is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  input : in std_logic_vector(15 downto 0);
			  output : out std_logic_vector(15 downto 0));
end Pipeline;

architecture Behavioral of Pipeline is
-- Clock signals
signal clk_fetch : std_logic;

-- Reset signals
signal rst_decode : std_logic;
signal rst_execute : std_logic;
signal rst_branch : std_logic;

-- Branch output signals
signal branch_enable_b : std_logic := '0';
signal branch_addr_b : std_logic_vector(15 downto 0) := x"0000";
signal wrback_en_b : std_logic;
signal subroutine_ret_b : std_logic_vector(15 downto 0) := x"0000";

-- Fetch output signals
signal instruction : std_logic_vector(15 downto 0);
signal PC_f : std_logic_vector(15 downto 0);
signal input_f : std_logic_vector(15 downto 0);

-- Decode ouput signals
signal ra_idx_d : std_logic_vector(2 downto 0);
signal PC_d : std_logic_vector(15 downto 0);
signal branch_enable_d : std_logic;
signal branch_mode_d : std_logic_vector(2 downto 0);
signal branch_offset_d : std_logic_vector(15 downto 0);
signal alu_mode : std_logic_vector(2 downto 0);
signal wrback_mode_d : std_logic_vector(1 downto 0);
signal ld_imm_d : std_logic_vector(7 downto 0);
signal rd_data1 : std_logic_vector(15 downto 0);
signal rd_data2 : std_logic_vector(15 downto 0);
signal shift : std_logic_vector(3 downto 0);
signal imm_mode_d : std_logic;
signal mem_mode_d : std_logic_vector(1 downto 0);
signal output_en_d : std_logic;
signal input_en_d : std_logic;
signal input_d : std_logic_vector(15 downto 0);
signal raw_detected : std_logic;
signal desired_write_idx : std_logic_vector(2 downto 0);
signal counter_start_en : std_logic;
signal raw_pos_1 : std_logic_vector(1 downto 0);
signal raw_pos_2 : std_logic_vector(1 downto 0);

-- Execute output signals
signal z : std_logic;
signal n : std_logic;
signal alu_result_e : std_logic_vector(15 downto 0);
signal ra_idx_e : std_logic_vector(2 downto 0);
signal mem_mode_e : std_logic_vector(1 downto 0);
signal imm_mode_e : std_logic;
signal wrback_mode_e : std_logic_vector(1 downto 0);
signal ld_imm_e : std_logic_vector(7 downto 0);
signal reg1_val : std_logic_vector(15 downto 0);
signal reg2_val : std_logic_vector(15 downto 0);
signal output_en_e : std_logic;
signal input_en_e : std_logic;
signal input_e : std_logic_vector(15 downto 0);

-- Memory output signals
signal mem_read_data : std_logic_vector(15 downto 0);
signal src_reg : std_logic_vector(15 downto 0);
signal wrback_en_m : std_logic;
signal subroutine_ret_m : std_logic_vector(15 downto 0);
signal alu_result_m : std_logic_vector(15 downto 0);
signal wrback_mode_m : std_logic_vector(1 downto 0);
signal imm_mode_m : std_logic;
signal ra_idx_m : std_logic_vector(2 downto 0);
signal output_en_m : std_logic;
signal input_en_m : std_logic;
signal input_m : std_logic_vector(15 downto 0);
signal writeback_future : std_logic_vector(15 downto 0);
signal raw_detected : std_logic;

-- Writeback output signals
signal wr_idx : std_logic_vector(2 downto 0);
signal wr_data : std_logic_vector(15 downto 0);
signal wr_en : std_logic;

begin
	-- Setup the fetch stage
	Fetch : entity work.fetch port map(rst, clk_fetch, branch_enable_b, branch_addr_b, instruction, PC_f, 
		input, input_f);
	
	-- Setup the decode stage
	Decode : entity work.decode port map(rst_decode, clk, instruction, ra_idx_d, PC_f, PC_d, branch_enable_d, 
		branch_mode_d, branch_offset_d, alu_mode, wrback_mode_d, ld_imm_d, rd_data1, rd_data2, wr_idx, 
		wr_data, wr_en, shift, imm_mode_d, mem_mode_d, output_en_d, input_en_d, input_f, input_d,
		desired_write_idx, desired_write_idx, counter_start_en, counter_start_en, raw_pos_1, raw_pos_2);
		
	-- Setup the branch stage
	Branch : entity work.branch port map(rst_branch, clk, PC_d, rd_data1, PC_f, branch_enable_d, branch_mode_d,
		branch_offset_d, z, n, branch_enable_b, branch_addr_b, wrback_en_b, subroutine_ret_b);  
		
	-- Setup the execute stage
	Execute : entity work.execute port map(rst_execute, clk, alu_mode, rd_data1, rd_data2, shift, z, n, alu_result_e,
		ra_idx_d, ra_idx_e, mem_mode_d, mem_mode_e, imm_mode_d, imm_mode_e, wrback_mode_d, wrback_mode_e,
		ld_imm_d, ld_imm_e, reg1_val, reg2_val, output_en_d, output_en_e, input_en_d, input_en_e, 
		input_d, input_e, raw_pos_1, raw_pos_2);
		
	-- Setup the memory stage
	Memory : entity work.memory port map(rst, clk, mem_mode_e, reg1_val, reg2_val, src_reg, mem_read_data, 
		wrback_en_b, wrback_en_m, subroutine_ret_b, subroutine_ret_m, alu_result_e, alu_result_m, wrback_mode_e, 
		wrback_mode_m, imm_mode_e, imm_mode_m, ra_idx_e, ra_idx_m, output_en_e, output_en_m, 
		input_en_d, input_en_m, input_e, input_m);
		
	-- Setup the writeback stage
	Writeback : entity work.writeback port map(rst, clk, wrback_mode_m, ra_idx_m, alu_result_m, 
		mem_read_data, wrback_en_m, subroutine_ret_m, src_reg, wr_en, wr_idx, wr_data, output_en_m, 
		output, input_en_m, input_m); 
		
	-- Reset the decode, execute and branch latches when a branch is taken
	-- Insert bubble in execute when RAW hazard is detected
	rst_decode <= '1' when branch_enable_b = '1' else rst;
	rst_branch <= '1' when branch_enable_b = '1' else rst;
	rst_execute <= 
		'1' when branch_enable_b = '1' else 
		'1' when raw_detected = '1' else
		rst;
	
	-- Freeze the fetch clock when RAW hazard is detected
	clk_fetch <= 
		clk when branch_enable_b = '1' else
		'0' when raw_detected = '1' else
		clk;

end Behavioral;

