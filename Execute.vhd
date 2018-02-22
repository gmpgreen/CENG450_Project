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
    Port ( ALU_Mode : in  STD_LOGIC_VECTOR (2 downto 0);
           input1 : in  STD_LOGIC_VECTOR (15 downto 0);
           input2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  shift : in std_logic_vector(15 downto 0);
           Z : out  STD_LOGIC;
           N : out  STD_LOGIC;
           ALU_Result : out  STD_LOGIC_VECTOR (15 downto 0);
           Mem_Mode_In : in  STD_LOGIC_VECTOR (1 downto 0);
           Wr_Back_Mode_In : in  STD_LOGIC_VECTOR (1 downto 0);
           Load_Imm_In : in  STD_LOGIC_VECTOR (7 downto 0);
           Mem_Mode_Out : out  STD_LOGIC_VECTOR (1 downto 0);
           Wr_Back_Mode_Out : out  STD_LOGIC_VECTOR (1 downto 0);
           Load_Imm_Out : out  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end Execute;

architecture Behavioral of Execute is

signal alu_mode_buf : std_logic_vector(2 downto 0);
signal in1 : std_logic_vector(15 downto 0);
signal in2 : std_logic_vector(15 downto 0);
signal c1 : std_logic_vector(15 downto 0);
signal muxed_in2 : std_logic_vector(15 downto 0);


begin

	ALU : entity work.alu port map(in1, muxed_in2, alu_mode_buf, clk, rst, ALU_Result, Z, N);
	
	muxed_in2 <= shift when alu_mode = "101" else
					 shift when alu_mode = "110" else
					 in2;

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
			else
				alu_mode_buf <= ALU_Mode;
				in1 <= input1;
				in2 <= input2;
				c1 <= shift;
				Wr_Back_Mode_Out <= Wr_Back_Mode_In;
				Mem_Mode_Out <= Mem_Mode_In;
				Load_Imm_Out <= Load_Imm_In;
			end if;
		end if;
	end process;

end Behavioral;

