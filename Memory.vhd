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
			  Destination_Reg : in std_logic_vector(15 downto 0);
			  Source_Reg : in std_logic_vector(15 downto 0);
			  Source_Reg_Out : out std_logic_vector(15 downto 0);
           Read_Data : out  STD_LOGIC_VECTOR (15 downto 0);
           Subr_Ret_In : in  STD_LOGIC_VECTOR (15 downto 0);
           Subr_Ret_Out : out  STD_LOGIC_VECTOR (15 downto 0);
           ALU_Result_In : in  STD_LOGIC_VECTOR (15 downto 0);
           ALU_Result_Out : out  STD_LOGIC_VECTOR (15 downto 0);
           Wr_Back_Mode_In : in  STD_LOGIC_VECTOR (1 downto 0);
           Wr_Back_Mode_Out : out  STD_LOGIC_VECTOR (1 downto 0);
			  Immediate_Mode_In : in std_logic;
			  Immediate_Mode_Out : out std_logic;
			  ra_idx_in : in std_logic_vector(2 downto 0);
			  ra_idx_out : out std_logic_vector(2 downto 0));
end Memory;

architecture Behavioral of Memory is

signal read_write : std_logic;
signal mem_en : std_logic; -- Read when 0, Write when 1
signal addr : std_logic_vector(15 downto 0);
signal reg_dest : std_logic_vector(15 downto 0);
signal reg_src : std_logic_vector(15 downto 0);
signal write_data : std_logic_vector(15 downto 0);

begin

	addr <= reg_dest when (read_write = '1') else reg_src;
	write_data <= reg_src;

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				read_write <= '0';
				mem_en <= '0';
				addr <= x"0000";
				reg_dest <= x"0000";
				reg_src <= x"0000";
				Subr_Ret_Out <= x"0000";
				ALU_Result_Out <= x"0000";
				Wr_Back_Mode_Out <= "00";
				Immediate_Mode_Out <= '0';
				ra_idx_out <= "000";
				Source_Reg_Out <= x"0000";
			else
				read_write <= Mem_Mode(1);
				mem_en <= Mem_Mode(0);
				reg_dest <= Destination_Reg;
				reg_src <= Source_Reg;
				Subr_Ret_Out <= Subr_Ret_In;
				ALU_Result_Out <= ALU_Result_In;
				Wr_Back_Mode_Out <= Wr_Back_Mode_In;
				Immediate_Mode_Out <= Immediate_Mode_In;
				ra_idx_out <= ra_idx_in;
				Source_Reg_Out <= Source_Reg;
			end if;
		end if;
	end process;

end Behavioral;

