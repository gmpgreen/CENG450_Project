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

    type ROM_TYPE is array (0 to 255) of std_logic_vector (7 downto 0);

    constant rom_content : ROM_TYPE := (
--		-- TEST 1
--		"00100100","00000011", -- LOADIMM.lower #3
--		"00100111","10111000", -- MOV r6, r7			r6=3
--		"00100100","00000001", -- LOADIMM.lower #1
--		"00100111","01111000", -- MOV r5, r7			r5=1
--		"00100100","00000010", -- LOADIMM.lower #2	-- To fix issues with word alignment
--		"01000010","00000000", -- IN r0					--(IN-->r0, r1=r0+1)
--		"00000010","01000110", -- ADD r1, r0, r6		--r1=r0+3,2,1
--		"00000110","10000000", -- MUL r2, r0, r0		--r2=r0^2
--		"00000110","11001001", -- MUL r3, r1, r1		--r3=r1^2
--		"00000100","11011010", -- SUB r3, r3, r2		r1^2-r0^2
--		"00100011","11011000", -- STORE r7, r3			r3,@r7
--		"00000010","10000001", -- ADD r2, r0, r1		r1+r0
--		"00100011","00010000", -- STORE r4, r2			r2,@r4
--		"00100000","10100000", -- LOAD r2, r4			r2,@r4
--		"00100000","11111000", -- LOAD r3, r7			r3,@r7
--		"00000100","10010011", -- SUB r2, r2, r3		-- it should be zero
--		"00001110","10000000", -- TEST r2
--		"10000100","00000011", -- BRR.Z 3				-- goto (OUT)
--		"00000101","10110101", -- SUB r6, r6, r5		-- decrement r6; r6=r6-1
--		"10000111","11000101", -- BR r7, 5				-- goto (r7+10)=12 (000a)
--		"01000000","11000000", -- OUT r3					-- print the result
--		"10000001","11101011", -- BRR -21				-- loop forever	
--		-- TEST 2		
		"00100100","00000001", -- LOADIMM.lower #1 	0
		"00100111","01111000", -- MOV r5, r7 			2
		"00100110","01101000", -- MOV r1, r5			4
		"00100111","10101000", -- MOV r6, r5			6
		"00001011","10000001", -- SHL r6 #1				8
		"01000010","00000000", -- IN r0					10
		"00000110","01001000", -- MUL r1, r1, r0		12-- actual mul for factorial of IN
		"00000100","00000101", -- SUB r0, r0, r5		14
		"00000101","00000101", -- SUB r4, r0, r5		16
		"00000000","00000000", -- NOP						18
		"00001111","00000000", -- TEST r4				20
		"10000010","00000011", -- BRR.N 3				22 -- goto (OUT)
		"10000111","10000101", -- BR r6, 5				24 -- goto (MUL)
		"00000000","00000000", -- NOP						26
		"01000000","01000000", -- OUT r1					28 -- print the result
		"10000001","11110001", -- BRR -15				30 -- loop forever
--		-- TEST 2B
--		"00000000","00000000", -- NOP # CENG450
--		"00000000","00000000", -- NOP # The factorial of IN input number
--		"00000000","00000000", -- NOP # OUT(r1)=IN*(IN-1)*(IN-2)*…*2
--		"00000000","00000000", -- NOP # This loop should run (N-1) times
--		"00000000","00000000", -- NOP # The start of this program must be at address 0, make sure of the correct branching
--		"00100100","00000001", -- LOADIMM.lower #1 
--		"00100111","01111000", -- MOV r5, r7	-- r5 is the decrement value
--		"00100110","01101000", -- MOV r1, r5 	-- r1 is the Factorial variable, so it is initialized to 1
--		"00100111","10101000", -- MOV r6, r5 	-- r6 is initialized to 1, then it’s shifted to get 2
--		"00001011","10000001", -- SHL r6#1 	-- the lowest value to be multiplied by (r6=2)
--		"01000010","00000000", -- IN r0
--		"00000000","00000000", -- NOP
--		"00000000","00000000", -- NOP
--		"00000110","01001000", -- Mul r1,r1,r0 -- the actual multiplication to find the factorial (IN!)
--		"00000100","00000101", -- Sub r0,r0,r5 -- to move to the lower number (r0-1)
--		"00000101","00000110", -- Sub r4,r0,r6 -- to check if r0 reaches 2
--		"00000000","00000000", -- NOP
--		"00000000","00000000", -- NOP
--		"00001111","00000000", -- TEST r4 		-- IF negative 
--		"10000010","00000100", -- BRR.N +4		-- goto OUT
--		"10000111","10001011", -- BR r6,11		-- ElSE: r6=2, 11*2=22, 22+2=24 Byte = 12 Word : goto 12
--		"00000000","00000000", -- NOP
--		"00000000","00000000", -- NOP
--		"01000000","01000000", -- OUT r1 		-- Printout the Factorial
--		"00000000","00000000", -- NOP
--		"10000001","11101011", -- BRR -21		-- goto to the beginning 
--		"00000000","00000000", -- NOP
--		"00000000","00000000", -- NOP
		others => "00000000"); -- NOP
begin

p1:    process (clk)
	 variable add_in : integer := 0;
    begin
        if rising_edge(clk) then
					add_in := conv_integer(unsigned(addr));
					data(7 downto 0) <= rom_content(add_in+1);
					data(15 downto 8) <= rom_content(add_in);					 
        end if;
		  
    end process;

end BHV;