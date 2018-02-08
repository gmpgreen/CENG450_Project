--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package MUX is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
function MUX16  (
	input : in std_logic_vector(15 downto 0);
	sel : in std_logic_vector (3 downto 0))
return std_logic;

function MUX2  (
	input : in std_logic_vector(1 downto 0);
	sel : in std_logic)
return std_logic;

function Barrel_Shift_Left (
	input : in std_logic_vector(15 downto 0);
	shift : in std_logic_vector(3 downto 0))
return std_logic_vector;

-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end MUX;

package body MUX is

---- Example 1
function MUX16  (
	input : in std_logic_vector(15 downto 0);
	sel : in std_logic_vector (3 downto 0)  
	) 
	return std_logic is
	variable output     : std_logic;
begin
	case sel is
		when "0000" => output := input(0);
		when "0001" => output := input(1);
		when "0010" => output := input(2);
		when "0011" => output := input(3);
		when "0100" => output := input(4);
		when "0101" => output := input(5);
		when "0110" => output := input(6);
		when "0111" => output := input(7);
		when "1000" => output := input(8);
		when "1001" => output := input(9);
		when "1010" => output := input(10);
		when "1011" => output := input(11);
		when "1100" => output := input(12);
		when "1101" => output := input(13);
		when "1110" => output := input(14);
		when "1111" => output := input(15);
		when others => NULL;
	end case;
	return output; 
end MUX16;

function MUX2  (
	input : in std_logic_vector(1 downto 0);
	sel : std_logic
	)
	return std_logic is
	variable output : std_logic;
begin
	if sel = '0' then
		output := input(0);
	else
		output := input(1);
	end if;
	return output;
end MUX2;

function Barrel_Shift_Left (
	input : in std_logic_vector(15 downto 0);
	shift : std_logic_vector(3 downto 0)
	)
	return std_logic_vector is
	variable shift_8 : std_logic_vector(15 downto 0);
	variable shift_4 : std_logic_vector(15 downto 0);
	variable shift_2 : std_logic_vector(15 downto 0);
	variable shift_1 : std_logic_vector(15 downto 0);
begin
	-- Shift by 8
	for i in 0 to 8 loop
		shift_8(i) := MUX2('0' & input(i), shift(3));
	end loop;
	for i in 9 to 15 loop
		shift_8(i) := MUX2(input(i-8) & input(i), shift(3));
	end loop;
	
	-- Shift by 4
	for i in 0 to 4 loop
		shift_4(i) := MUX2('0' & shift_8(i), shift(2));
	end loop;
	for i in 5 to 15 loop
		shift_4(i) := MUX2(shift_8(i-4) & shift_8(i), shift(2));
	end loop;
	
	-- Shift by 2
	for i in 0 to 2 loop
		shift_2(i) := MUX2('0' & shift_4(i), shift(1));
	end loop;
	for i in 3 to 15 loop
		shift_2(i) := MUX2(shift_4(i-2) & shift_4(i), shift(1));
	end loop;
	
	-- Shift by 1
	shift_1(0) := MUX2('0' & shift_2(0), shift(0));
	for i in 1 to 15 loop
		shift_1(i) := MUX2(shift_2(i-1) & shift(i), shift(0));
	end loop;
	
	return shift_1;
end Barrel_Shift_Left;

---- Example 2
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end MUX;
