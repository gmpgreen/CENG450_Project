----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:15 02/21/2018 
-- Design Name: 
-- Module Name:    Fetch - Behavioral 
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

entity Fetch is
    Port ( rst : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  frz : in STD_LOGIC;
			  branch_enable : in  STD_LOGIC;
			  branch_enable_out : out std_logic;
           branch_address : in  STD_LOGIC_VECTOR (15 downto 0);
           instruction : out  STD_LOGIC_VECTOR (15 downto 0);
           instruction_addr : out  STD_LOGIC_VECTOR (15 downto 0);
			  input_in : in std_logic_vector(15 downto 0);
			  input_out : out std_logic_vector(15 downto 0));
end Fetch;

architecture Behavioral of Fetch is

	signal br_en : std_logic;
	signal br_addr : std_logic_vector(15 downto 0);
	signal PC_incr : std_logic_vector(15 downto 0);
	signal PC : std_logic_vector(15 downto 0);
	signal PC_to_read : std_logic_vector(15 downto 0);
	signal instr_addr : std_logic_vector(15 downto 0);
	signal clk_rom : std_logic;
	signal instruction_intrn : std_logic_vector(15 downto 0);
	signal clk_rom_en : std_logic;

begin

	--br_addr <= branch_address when rst = '0' else x"0000";
	--br_en <= branch_enable when rst = '0' else '0';

	-- Chose between PC and branch address for current instruction
	Instr_Addr_Selector : entity work.mux2_16 port map(PC, br_addr, br_en, instr_addr);
	
	-- Say we're not done here yet
	branch_enable_out <= br_en;
	
	-- Get instruction from ROM
	--rom : entity work.rom port map(clk, instr_addr, instruction);
	rom : entity work.ROM_VHDL port map(clk_rom, instr_addr, instruction_intrn);
	instruction <= instruction_intrn when rst = '0' else x"0000";
	
	-- Prepare the incremented PC
	PC_Adder : entity work.adder_16bit port map(instr_addr, x"0002", PC_incr);
	
	-- Update output address
	instruction_addr <= PC_to_read;
	
	clk_rom <= clk when clk_rom_en = '1' else '0';
	
	process(clk)
	begin
		if rising_edge(clk) then
			-- Latch internal signals
			if (rst = '1') then
				PC_to_read <= x"0000";
				PC <= x"0000";
				input_out <= x"0000";
				br_addr <= x"0000";
				br_en <= '0';
				clk_rom_en <= '0';
			elsif (frz = '0') then
				PC_to_read <= instr_addr;
				PC <= PC_incr;
				input_out <= input_in;
				br_addr <= branch_address;
				br_en <= branch_enable;
				clk_rom_en <= '1';
			elsif (frz = '1') then
				clk_rom_en <= '0';
			end if;
		end if;
	end process;

end Behavioral;

