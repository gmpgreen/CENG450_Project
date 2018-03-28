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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Execute is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  ALU_Mode : in  STD_LOGIC_VECTOR (2 downto 0);
           input1 : in  STD_LOGIC_VECTOR (15 downto 0);
           input2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  shift : in std_logic_vector(3 downto 0);
           Z : out  STD_LOGIC;
           N : out  STD_LOGIC;
           ALU_Result : out  STD_LOGIC_VECTOR(15 downto 0);
			  ra_idx_in : in std_logic_vector(2 downto 0);
			  ra_idx_out : out std_logic_vector(2 downto 0);
           Mem_Mode_In : in  STD_LOGIC_VECTOR (1 downto 0);
           Mem_Mode_Out : out  STD_LOGIC_VECTOR (1 downto 0);
			  Imediate_Mode_In : std_logic;
			  Immediate_Mode_Out : out std_logic;
           Wr_Back_Mode_In : in  STD_LOGIC_VECTOR (1 downto 0);
           Wr_Back_Mode_Out : out  STD_LOGIC_VECTOR (1 downto 0);
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
			  raw_position_1 : in std_logic_vector(1 downto 0);
			  raw_position_2 : in std_logic_vector(1 downto 0);
			  writeback_memory : in std_logic_vector(15 downto 0);
			  writeback_writeback : in std_logic_vector(15 downto 0));
end Execute;

architecture Behavioral of Execute is

signal alu_mode_buf : std_logic_vector(2 downto 0);
signal in1 : std_logic_vector(15 downto 0);
signal in2 : std_logic_vector(15 downto 0);
signal wrback_mem : std_logic_vector(15 downto 0);
signal wrback_wrback : std_logic_vector(15 downto 0);
signal c1 : std_logic_vector(15 downto 0);
signal muxed_in2 : std_logic_vector(15 downto 0);
signal muxed_in1 : std_logic_vector(15 downto 0);
signal alu_result_buf : std_logic_vector(15 downto 0);
signal output_en : std_logic;
signal raw_pos_1 : std_logic_vector(1 downto 0);
signal raw_pos_2 : std_logic_vector(1 downto 0);


begin

	ALU : entity work.alu port map(in1, muxed_in2, alu_mode_buf, clk, rst, alu_result_buf, Z, N);
	
	-- Used for both result and output
	ALU_Result <= alu_result_buf when output_en = '0' else in1;
	
	-- Choose input 1 for ALU, while avoiding RAW conditions
	muxed_in1 <= 
		wrback_mem when raw_position_1 = "10" else
		wrback_wrback when raw_position_1 = "01" else
		in1;
	
	-- Choose input 2 for ALU, while avoiding RAW conditions
	muxed_in2 <= 
		wrback_mem when raw_position_2 = "10" else
		wrback_wrback when raw_position_2 = "01" else
		c1 when alu_mode_buf = "101" else
		c1 when alu_mode_buf = "110" else
		in2;
					 
	output_en_out <= output_en;

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				alu_mode_buf <= "000";
				in1 <= x"0000";
				in2 <= x"0000";
				c1 <= x"0000";
				Wr_Back_Mode_Out <= "00";
				Mem_Mode_Out <= "00";
				Load_Imm_Out <= x"00";
				Immediate_Mode_Out <= '0';
				reg1_val <= x"0000";
				reg2_val <= x"0000";
				ra_idx_out <= "000";
				output_en <= '0';
				input_en_out <= '0';
				input_out <= x"0000";
				wrback_mem <= x"0000";
				wrback_wrback <= x"0000";
				raw_pos_1 <= "00";
				raw_pos_2 <= "00";
			else
				alu_mode_buf <= ALU_Mode;
				in1 <= input1;
				in2 <= input2;
				c1 <= x"000" & shift;
				Wr_Back_Mode_Out <= Wr_Back_Mode_In;
				Mem_Mode_Out <= Mem_Mode_In;
				Load_Imm_Out <= Load_Imm_In;
				Immediate_Mode_Out <= Imediate_Mode_In;
				reg1_val <= input1;
				reg2_val <= input2;
				ra_idx_out <= ra_idx_in;
				output_en <= output_en_in;
				input_en_out <= input_en_in;
				input_out <= input_in;
				wrback_mem <= writeback_memory;
				wrback_wrback <= writeback_writeback;
				raw_pos_1 <= raw_position_1;
				raw_pos_2 <= raw_position_2;
			end if;
		end if;
	end process;

end Behavioral;

