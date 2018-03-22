library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
port(
	rst : in std_logic; 
	clk: in std_logic;
	--read signals
	rd_index1: in std_logic_vector(2 downto 0); 
	rd_index2: in std_logic_vector(2 downto 0); 
	rd_data1: out std_logic_vector(15 downto 0); 
	rd_data2: out std_logic_vector(15 downto 0);
	--write signals
	wr_index: in std_logic_vector(2 downto 0); 
	wr_data: in std_logic_vector(15 downto 0); 
	wr_enable: in std_logic;
	--RAW Tracker signals
	desired_wr_idx: in std_logic_vector(2 downto 0);
	desired_wr_en: in std_logic;
	raw_detected: out std_logic);
end register_file;

architecture behavioural of register_file is

type reg_array is array (integer range 0 to 7) of std_logic_vector(15 downto 0);
type counter_array is array (integer range 0 to 7) of std_logic_vector(1 downto 0);

--internals signals
signal reg_file : reg_array := 
	(x"0000", x"0A0A", x"F0F0", x"1111", 
	 x"FFFF", x"CCCC", x"0001", x"8000");
	 
signal raw_tracker : counter_array;
signal delayed_count_start : std_logic;
signal delayed_des_wr_idx : std_logic_vector(2 downto 0);

begin

--write operation 
process(clk)
begin
   if(rising_edge(clk)) then 
		if(rst='1') then
			for i in 0 to 7 loop
				reg_file(i)<= (others => '0');
				raw_tracker(i) <= "00";
				delayed_count_start <= '0';
			end loop;
		else
		
			-- Update counters
			for i in 0 to 7 loop
				if(raw_tracker(i) /= x"0") then
					raw_tracker(i) <= std_logic_vector(unsigned(raw_tracker(i)) - 1);
				end if;
			end loop;
			
			-- Start delayed counter
			if(delayed_count_start = '1') then
				raw_tracker(to_integer(unsigned(delayed_des_wr_idx))) <= "10";
				delayed_count_start <= '0';
			end if;
		
			-- Write data to the register file
			if(wr_enable='1') then
				reg_file(to_integer(unsigned(wr_index))) <= wr_data;
			end if;
			
			-- Update the RAW condition tracker
			if(desired_wr_en='1') then
				delayed_count_start <= '1';
				delayed_des_wr_idx <= desired_wr_idx;
			end if;
		 end if; 
    end if;
end process;

--read operation
rd_data1 <=	
reg_file(0) when(rd_index1="000") else
reg_file(1) when(rd_index1="001") else
reg_file(2) when(rd_index1="010") else
reg_file(3) when(rd_index1="011") else
reg_file(4) when(rd_index1="100") else
reg_file(5) when(rd_index1="101") else
reg_file(6) when(rd_index1="110") else reg_file(7);

rd_data2 <=
reg_file(0) when(rd_index2="000") else
reg_file(1) when(rd_index2="001") else
reg_file(2) when(rd_index2="010") else
reg_file(3) when(rd_index2="011") else
reg_file(4) when(rd_index2="100") else
reg_file(5) when(rd_index2="101") else
reg_file(6) when(rd_index2="110") else reg_file(7);

-- RAW Detection
raw_detected <= 
	'1' when( raw_tracker(to_integer(unsigned(rd_index1))) /= "00" ) else
	'1' when( raw_tracker(to_integer(unsigned(rd_index2))) /= "00" ) else
	'0';

end behavioural;
