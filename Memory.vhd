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
    Port ( Write_Enable : in  STD_LOGIC;
           Address : in  STD_LOGIC_VECTOR (15 downto 0);
           Write_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           Read_Data : out  STD_LOGIC_VECTOR (15 downto 0);
           Subr_Ret_In : in  STD_LOGIC_VECTOR (15 downto 0);
           ALU_Result_In : in  STD_LOGIC_VECTOR (15 downto 0);
           Wr_Back_Mode_In : in  STD_LOGIC_VECTOR (1 downto 0);
           Subr_Ret_Out : out  STD_LOGIC_VECTOR (15 downto 0);
           ALU_Result_Out : out  STD_LOGIC_VECTOR (15 downto 0);
           Wr_Back_Mode_Out : out  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end Memory;

architecture Behavioral of Memory is

signal wr_en : std_logic;
signal addr : std_logic_vector(15 downto 0);
signal wr_data : std_logic_vector(15 downto 0);

begin

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				wr_en <= '0';
				addr <= x"0000";
				wr_data <= x"0000";
				Subr_Ret_Out <= x"0000";
				ALU_Result_Out <= x"0000";
				Wr_Back_Mode_Out <= "00";
			else
				wr_en <= Write_Enable;
				addr <= Address;
				wr_data <= Write_Data;
				Subr_Ret_Out <= Subr_Ret_In;
				ALU_Result_Out <= ALU_Result_In;
				Wr_Back_Mode_Out <= Wr_Back_Mode_In;
			end if;
		end if;
	end process;

end Behavioral;

