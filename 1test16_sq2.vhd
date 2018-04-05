
--
-- Created on Wed 29 Mar 2017 16:02:12 PDT
-- 

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;


entity ROM_VHDL is
    port(
         clk      : in  std_logic;
         addr     : in  std_logic_vector (15 downto 0);
         data     : out std_logic_vector (15 downto 0)
         );
end ROM_VHDL;

architecture BHV of ROM_VHDL is

    type ROM_TYPE is array (0 to 127 ) of std_logic_vector (15 downto 0);

    constant rom_content : ROM_TYPE := (
	000 => "0000000000000000", -- NOP # CENG450
	001 => "0000000000000000", -- NOP # The difference between the square of two adjacent numbers equals to the summation of them (IN-->r0, r1=r0+1)
	002 => "0000000000000000", -- NOP # (a+1)^2-a^2=(a+1)+a=2a+1 (r3)  (ihhazmi Equation 1993)
	003 => "0000000000000000", -- NOP # This loop should run 3 times for (r6=3, r6=2, and r6=1)
	004 => "0000000000000000", -- NOP # The start of this program must be at address 0, make sure of the correct branching
	005 => "0010010000000011", -- LOADIMM.lower #3
	006 => "0010011110111000", -- MOV r6, r7
	007 => "0010010000000001", -- LOADIMM.lower #1
	008 => "0010011101111000", -- MOV r5,r7		-- r5=1 always (the decrement constant)
	009 => "0000001100101101", -- ADD r4,r5,r5	-- r4=1+1=2
	010 => "0100001000000000", -- IN r0
	011 => "0000000000000000", -- NOP
	012 => "0000000000000000", -- NOP
	013 => "0000001001000110", -- Add r1,r0,r6	-- r1=r1+r6: When r6=1, r1^2-r0^2=r0+r1 -- The target of (BR r4,12) 
	014 => "0000011010000000", -- Mul r2,r0,r0	-- r2=r0*r0
	015 => "0000011011001001", -- Mul r3,r1,r1	-- r3=r1*r1
	016 => "0000010011011010", -- Sub r3,r3,r2	-- r3=r3-r2: Checking the difference between the square of the two numbers
	017 => "0000000000000000", -- NOP
	018 => "0000000000000000", -- NOP
	019 => "0010001100011000", -- STORE @r4,r3	-- Store the content of r3 into the address indexed by the value of r4=2 
	020 => "0000001010000001", -- Add r2,r0,r1	-- r2=r0+r1
	021 => "0000101100000001", -- SHL r4#1	-- r4=2*r4: r4=4 as another even destination for the second Store
	022 => "0010001100010000", -- STORE @r4,r2	-- Store the content of r2 into the address indexed by the value of r4=4 
	023 => "0000000000000000", -- NOP
	024 => "0000000000000000", -- NOP
	025 => "0010000010100000", -- LOAD r2,@r4	-- Load the content of the address indexed by the value of r4=4 into r2 
	026 => "0000110100000001", -- SHR r4#1	-- r4=r4/2: r4 is back to 2 as the first Store destination
	027 => "0010000011100000", -- LOAD r3,@r4	-- Load the content of the address indexed by the value of r4=2 into r3 
	028 => "0000010010010011", -- Sub r2,r2,r3	-- r2=r2-r3: Checking the difference ((r1^2-r0^2)-(r0+r1)) 
	029 => "0000111010000000", -- Test r2		 
	030 => "1000010000000011", -- BRR.Z +3	-- IF Zero: goto (OUT +/-)
	031 => "0000010110110101", -- Sub r6,r6,r5	-- ELSE: r6=r6-1: When r6=1, r1^2-r0^2=r0+r1
	032 => "1000011100001100", -- BR r4,12 	-- goto (Add r1,r0,r6) r4=2, 12*2=24, 24+2=26 Byte = 13 Word: goto 13
	033 => "0000000000000000", -- NOP
	034 => "0100000011000000", -- OUT r3		-- Printout the value (r1^2-r0^2=r0+r1)
	035 => "0000000000000000", -- NOP
	036 => "0000000000000000", -- NOP
	037 => "1000000111100000", -- BRR -32		-- goto (The beginning)
	038 => "0000000000000000", -- NOP
	039 => "0000000000000000", -- NOP
	others => x"0000" ); -- NOP
begin

p1:    process (clk)
	 variable add_in : integer := 0;
    begin
        if rising_edge(clk) then
					 add_in := conv_integer(unsigned('0' & addr(15 downto 1)));
                data <= rom_content(add_in);
        end if;
    end process;
end BHV;


