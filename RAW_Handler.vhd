----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:01:44 03/30/2018 
-- Design Name: 
-- Module Name:    RAW_Handler - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAW_Handler is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  frz : in	STD_LOGIC;
			  wr_en : in STD_LOGIC;
           wr_idx : in  STD_LOGIC_VECTOR (2 downto 0);
           rd_idx1 : in  STD_LOGIC_VECTOR (2 downto 0);
           rd_idx2 : in  STD_LOGIC_VECTOR (2 downto 0);
           raw_1 : out  STD_LOGIC_VECTOR (1 downto 0);
           raw_2 : out  STD_LOGIC_VECTOR (1 downto 0));
end RAW_Handler;

architecture Behavioral of RAW_Handler is

type counter_array is array (integer range 0 to 7) of std_logic_vector(1 downto 0);
type lookup is array (integer range 0 to 3) of std_logic_vector(1 downto 0);

signal raw_tracker : counter_array;
signal raw_start : std_logic_vector(7 downto 0);

-- Lookup table for next state for the RAW Tracker.
-- 0 -> 0
-- 1 -> 0
-- 2 -> 1
-- 3 -> 2
constant subtract_lookup : lookup := ("00", "00", "01", "10");
constant freeze_lookup : lookup := ("00", "00", "01", "11");

begin

	-- Asynchronously update start bits (when set, next rising edge will trigger countdown)
	raw_start(0) <= wr_en when wr_idx = "000" else '0';
	raw_start(1) <= wr_en when wr_idx = "001" else '0';
	raw_start(2) <= wr_en when wr_idx = "010" else '0';
	raw_start(3) <= wr_en when wr_idx = "011" else '0';
	raw_start(4) <= wr_en when wr_idx = "100" else '0';
	raw_start(5) <= wr_en when wr_idx = "101" else '0';
	raw_start(6) <= wr_en when wr_idx = "110" else '0';
	raw_start(7) <= wr_en when wr_idx = "111" else '0';

	-- Determine if there is a RAW hazard
	raw_1 <= raw_tracker(to_integer(unsigned(rd_idx1)));
	raw_2 <= raw_tracker(to_integer(unsigned(rd_idx2)));

	process(clk)
	begin
		-- Process on the rising clock edge
		if(rising_edge(clk)) then
		
			-- Handle case of reset
			if(rst = '1') then
				for i in 0 to 7 loop
					raw_tracker(i) <= "00";
				end loop;
				
			-- Update the raw_tracker
			elsif(frz = '0') then
				for i in 0 to 7 loop
					-- Go to state 3 if raw_start has been set for this index
					if raw_start(i) = '1' then
						raw_tracker(i) <= "11";
					
					-- Otherwise, go to next state, as defined in the comment above subtract_lookup
					else
						raw_tracker(i) <= subtract_lookup(to_integer(unsigned(raw_tracker(i))));
					end if;
				end loop;
			elsif(frz = '1') then
				for i in 0 to 7 loop
					-- Go to state 3 if raw_start has been set for this index
					if raw_start(i) = '1' then
						raw_tracker(i) <= "11";
					
					-- Otherwise, go to next state, as defined in the comment above subtract_lookup
					else
						raw_tracker(i) <= freeze_lookup(to_integer(unsigned(raw_tracker(i))));
					end if;
				end loop;
			end if;
		end if;
	end process;
end Behavioral;

