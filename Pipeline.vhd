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
           rst : in  STD_LOGIC);
end Pipeline;

architecture Behavioral of Pipeline is

-- Branch output signals
signal branch_enable : std_logic := '0';
signal branch_addr : std_logic_vector(15 downto 0) := x"0000";
signal subroutine_ret_b : std_logic_vector(15 downto 0) := x"0000";

-- Fetch output signals
signal instruction : std_logic_vector(15 downto 0);
signal PC_f : std_logic_vector(15 downto 0);

-- Decode ouput signals
signal ra_idx_d : std_logic_vector(2 downto 0);
signal PC_d : std_logic_vector(15 downto 0);
signal branch_mode : std_logic_vector(2 downto 0);
signal branch_offset : std_logic_vector(8 downto 0);
signal alu_mode : std_logic_vector(2 downto 0);
signal wrback_mode_d : std_logic_vector(1 downto 0);
signal ld_imm_d : std_logic_vector(7 downto 0);
signal rd_data1 : std_logic_vector(15 downto 0);
signal rd_data2 : std_logic_vector(15 downto 0);
signal shift : std_logic_vector(3 downto 0);
signal imm_mode_d : std_logic;
signal mem_mode_d : std_logic_vector(1 downto 0);

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

-- Memory output signals
signal mem_read_data : std_logic_vector(15 downto 0);
signal src_reg : std_logic_vector(15 downto 0);
signal subroutine_ret_m : std_logic_vector(15 downto 0);
signal alu_result_m : std_logic_vector(15 downto 0);
signal wrback_mode_m : std_logic_vector(1 downto 0);
signal imm_mode_m : std_logic;
signal ra_idx_m : std_logic_vector(2 downto 0);

-- Writeback output signals
signal wr_idx : std_logic_vector(2 downto 0);
signal wr_data : std_logic_vector(15 downto 0);
signal wr_en : std_logic;

begin
	-- Setup the fetch stage
	Fetch : entity work.fetch port map(rst, clk, branch_enable, branch_addr, instruction, PC_f);
	
	-- Setup the decode stage
	Decode : entity work.decode port map(rst, clk, instruction, ra_idx_d, PC_f, PC_d, branch_mode,
		branch_offset, alu_mode, wrback_mode_d, ld_imm_d, rd_data1, rd_data2, wr_idx, wr_data, wr_en,
		shift, imm_mode_d, mem_mode_d);
		
	-- Setup the execute stage
	Execute : entity work.execute port map(rst, clk, alu_mode, rd_data1, rd_data2, shift, z, n, alu_result_e,
		ra_idx_d, ra_idx_e, mem_mode_d, mem_mode_e, imm_mode_d, imm_mode_e, wrback_mode_d, wrback_mode_e,
		ld_imm_d, ld_imm_e, reg1_val, reg2_val);
		
	-- Setup the memory stage
	Memory : entity work.memory port map(rst, clk, mem_mode_e, reg1_val, reg2_val, src_reg, mem_read_data, 
		subroutine_ret_b, subroutine_ret_m, alu_result_e, alu_result_m, wrback_mode_e, wrback_mode_m, 
		imm_mode_e, imm_mode_m, ra_idx_e, ra_idx_m);
		
	-- Setup the writeback stage
	Writeback : entity work.writeback port map(rst, clk, wrback_mode_m, ra_idx_m, alu_result_m, 
		mem_read_data, subroutine_ret_m, src_reg, wr_en, wr_idx, wr_data); 

end Behavioral;

