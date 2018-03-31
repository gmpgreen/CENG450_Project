----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:54 02/21/2018 
-- Design Name: 
-- Module Name:    Writeback - Behavioral 
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

entity Writeback is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  Write_Mode : in  STD_LOGIC_VECTOR (2 downto 0);
           Write_Index_In : in  STD_LOGIC_VECTOR (2 downto 0);
           ALU_Result : in  STD_LOGIC_VECTOR (15 downto 0);
			  Memory_Read : in std_logic_vector(15 downto 0);
			  Wr_Back_Branch_En : in std_logic;
           Subroutine_Ret_Addr : in  STD_LOGIC_VECTOR (15 downto 0);
			  Source_Reg : in std_logic_vector(15 downto 0);
           Write_Enable : out  STD_LOGIC;
           Write_Index_Out : out  STD_LOGIC_VECTOR (2 downto 0);
           Write_Data_Out : out  STD_LOGIC_VECTOR (15 downto 0);
			  output_en : in std_logic;
			  output : out std_logic_vector(15 downto 0);
			  input_en : in std_logic;
			  input : in std_logic_vector(15 downto 0);
			  load_imm : in std_logic_vector(7 downto 0);
			  immediate_mode : in std_logic);
end Writeback;

architecture Behavioral of Writeback is

signal wr_mode : std_logic_vector(2 downto 0);
signal wr_branch : std_logic;
signal wr_index : std_logic_vector(2 downto 0);
signal alu_data : std_logic_vector(15 downto 0);
signal sub_ret : std_logic_vector(15 downto 0);
signal reg_src : std_logic_vector(15 downto 0);
signal mem_read : std_logic_vector(15 downto 0);
signal output_inner : std_logic_vector(15 downto 0);
signal input_inner : std_logic_vector(15 downto 0);
signal input_inner_en : std_logic;
signal load_imm_inner : std_logic_vector(7 downto 0);
signal immediate_mode_inner : std_logic;
signal load_imm_result : std_logic_vector(15 downto 0);

begin
	
	load_imm_result <= 
		Source_Reg(15 downto 8) & load_imm_inner when immediate_mode_inner = '0' else
		load_imm_inner & Source_Reg(7 downto 0);
	
	Write_Enable <=
		'1' when wr_branch = '1' else
		'1' when input_inner_en = '1' else
		'0' when wr_mode = "000" else 
		'1';
	Write_Index_Out <= 
		"111" when wr_branch = '1' else
		wr_index when wr_mode = "001" else
		wr_index when wr_mode = "010" else
		wr_index when wr_mode = "011" else
		wr_index when wr_mode = "100" else
		wr_index when input_inner_en = '1' else
		"000";
	Write_Data_Out <=
		sub_ret when wr_branch = '1' else
		input_inner when input_inner_en = '1' else
		alu_data when wr_mode = "001" else
		load_imm_result when wr_mode = "011" else
		mem_read when wr_mode = "010" else
		reg_src when wr_mode = "100" else
		x"0000";
		
	-- Configure the output
	output_inner <= alu_data when output_en = '1' else output_inner;
	output <= output_inner;

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				wr_mode <= "000";
				wr_branch <= '0';
				wr_index <= "000";
				alu_data <= x"0000";
				sub_ret <= x"0000";
				mem_read <= x"0000";
				reg_src <= x"0000";
				input_inner <= x"0000";
				input_inner_en <= '0';
				load_imm_inner <= x"00";
			else
				wr_mode <= Write_Mode;
				wr_branch <= Wr_Back_Branch_En;
				wr_index <= Write_Index_In;
				alu_data <= ALU_Result;
				sub_ret <= Subroutine_Ret_Addr;
				mem_read <= Memory_Read;
				reg_src <= Source_Reg;
				input_inner <= input;
				input_inner_en <= input_en;
				load_imm_inner <= load_imm;
				immediate_mode_inner <= immediate_mode;
			end if;
		end if;
	end process;
end Behavioral;

