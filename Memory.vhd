----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:54 02/21/2018 
-- Design Name: 
-- Module Name:    Memory - Behavioral 
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

entity Memory is
    Port ( rst : in  STD_LOGIC; 
           clk : in  STD_LOGIC;
			  Mem_Mode : in  STD_LOGIC_VECTOR(1 downto 0);
			  Mem_RAW_Hazard : out std_logic;
			  Destination_Reg : in std_logic_vector(15 downto 0);
			  Source_Reg : in std_logic_vector(15 downto 0);
			  Source_Reg_Out : out std_logic_vector(15 downto 0);
           Read_Data : out  STD_LOGIC_VECTOR (15 downto 0);
			  Wr_Back_Branch_In : in STD_LOGIC;
			  Wr_Back_Branch_Out : out STD_LOGIC;
           Subr_Ret_In : in  STD_LOGIC_VECTOR (15 downto 0);
           Subr_Ret_Out : out  STD_LOGIC_VECTOR (15 downto 0);
           ALU_Result_In : in  STD_LOGIC_VECTOR (15 downto 0);
           ALU_Result_Out : out  STD_LOGIC_VECTOR (15 downto 0);
           Wr_Back_Mode_In : in  STD_LOGIC_VECTOR (2 downto 0);
           Wr_Back_Mode_Out : out  STD_LOGIC_VECTOR (2 downto 0);
			  Immediate_Mode_In : in std_logic;
			  Immediate_Mode_Out : out std_logic;
			  ra_idx_in : in std_logic_vector(2 downto 0);
			  ra_idx_out : out std_logic_vector(2 downto 0);
			  output_en_in : in std_logic;
			  output_en_out : out std_logic;
			  input_en_in : in std_logic;
			  input_en_out : out std_logic;
			  input_in : in std_logic_vector(15 downto 0);
			  input_out : out std_logic_vector(15 downto 0);
			  writeback_future : out std_logic_vector(15 downto 0);
			  load_imm_in : in std_logic_vector (7 downto 0);
			  load_imm_out: out std_logic_vector (7 downto 0)
			  );
end Memory;

architecture Behavioral of Memory is

signal read_write : std_logic;
signal mem_en : std_logic; -- Read when 0, Write when 1
signal mem_mode_intrn : std_logic_vector(1 downto 0);
signal addr : std_logic_vector(15 downto 0);
signal reg_dest : std_logic_vector(15 downto 0);
signal reg_src : std_logic_vector(15 downto 0);
signal write_data : std_logic_vector(15 downto 0);
signal sub_ret : std_logic_vector(15 downto 0);
signal input_inner : std_logic_vector(15 downto 0);
signal alu_data : std_logic_vector(15 downto 0);
signal wr_branch : std_logic;
signal input_en : std_logic;
signal wr_mode : std_logic_vector(2 downto 0);
signal rd_data_inner : std_logic_vector (15 downto 0);

begin
	
	RAM : entity work.RAM port map(clk, mem_en, read_write, addr, write_data, 
	rd_data_inner);
	
	addr <= reg_dest when (read_write = '1') else reg_src;
	write_data <= reg_src;
	
	Read_Data <= rd_data_inner;
	
	Mem_RAW_Hazard <= '1' when mem_mode_intrn = "01" else '0';
	
	writeback_future <=
		sub_ret when wr_branch = '1' else
		input_inner when input_en = '1' else
		alu_data when wr_mode = "001" else
		x"0000";

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				read_write <= '0';
				mem_en <= '0';
				mem_mode_intrn <= "00";
				reg_dest <= x"0000";
				reg_src <= x"0000";
				Wr_Back_Branch_Out <= '0';
				Subr_Ret_Out <= x"0000";
				ALU_Result_Out <= x"0000";
				Wr_Back_Mode_Out <= "000";
				Immediate_Mode_Out <= '0';
				ra_idx_out <= "000";
				Source_Reg_Out <= x"0000";
				output_en_out <= '0';
				input_en_out <= '0';
				input_out <= x"0000";
				sub_ret <= x"0000";
				input_inner <= x"0000";
				alu_data <= x"0000";
				wr_branch <= '0';
				input_en <= '0';
				wr_mode <= "000";
				load_imm_out <= x"00";
			else
				read_write <= Mem_Mode(1);
				mem_en <= Mem_Mode(0);
				mem_mode_intrn <= Mem_Mode;
				reg_dest <= Destination_Reg;
				reg_src <= Source_Reg;
				Wr_Back_Branch_Out <= Wr_Back_Branch_In;
				Subr_Ret_Out <= Subr_Ret_In;
				ALU_Result_Out <= ALU_Result_In;
				Wr_Back_Mode_Out <= Wr_Back_Mode_In;
				Immediate_Mode_Out <= Immediate_Mode_In;
				ra_idx_out <= ra_idx_in;
				Source_Reg_Out <= Source_Reg;
				output_en_out <= output_en_in;
				input_en_out <= input_en_in;
				input_out <= input_in;
				sub_ret <= Subr_Ret_In;
				input_inner <= input_in;
				alu_data <= ALU_Result_In;
				wr_branch <= Wr_Back_Branch_In;
				input_en <= input_en_in;
				wr_mode <= Wr_Back_Mode_In;
				load_imm_out <= load_imm_in;
			end if;
		end if;
	end process;

end Behavioral;

