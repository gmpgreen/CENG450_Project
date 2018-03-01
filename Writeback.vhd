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
			  Write_Mode : in  STD_LOGIC_VECTOR (1 downto 0);
           Write_Index_In : in  STD_LOGIC_VECTOR (2 downto 0);
           ALU_Result : in  STD_LOGIC_VECTOR (15 downto 0);
			  Memory_Read : in std_logic_vector(15 downto 0);
           Subroutine_Ret_Addr : in  STD_LOGIC_VECTOR (15 downto 0);
			  Source_Reg : in std_logic_vector(15 downto 0);
           Write_Enable : out  STD_LOGIC;
           Write_Index_Out : out  STD_LOGIC_VECTOR (2 downto 0);
           Write_Data_Out : out  STD_LOGIC_VECTOR (15 downto 0));
end Writeback;

architecture Behavioral of Writeback is

signal wr_mode : std_logic_vector(1 downto 0);
signal wr_index : std_logic_vector(2 downto 0);
signal alu_data : std_logic_vector(15 downto 0);
signal sub_ret : std_logic_vector(15 downto 0);
signal reg_src : std_logic_vector(15 downto 0);
signal mem_read : std_logic_vector(15 downto 0);

begin

	Write_Enable <= '0' when wr_mode = "00" else '1';
	Write_Index_Out <= 
		wr_index when wr_mode /= "00" else
		"000";
	Write_Data_Out <=
		alu_data when wr_mode /= "00" else
		x"0000";

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				wr_mode <= "00";
				wr_index <= "000";
				alu_data <= x"0000";
				sub_ret <= x"0000";
				mem_read <= x"0000";
				reg_src <= x"0000";
			else
				wr_mode <= Write_Mode;
				wr_index <= Write_Index_In;
				alu_data <= ALU_Result;
				sub_ret <= Subroutine_Ret_Addr;
				mem_read <= Memory_Read;
				reg_src <= Source_Reg;
			end if;
		end if;
	end process;
end Behavioral;
