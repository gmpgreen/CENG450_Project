
--
-- Created on Thu Mar 24 13:46:54 PDT 2016
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
	0000 => "0100001001000000", -- 		IN				r1				           
	0002 => "0010010011111111", -- 		LOADIMM.LOWER	0xff     
	0004 => "0010010111111111", -- 		LOADIMM.UPPER	0xff			  
	0006 => "0100000111000000", -- 		OUT				r7				          
	0008 => "0010010100000000", -- 		LOADIMM.UPPER	0x00			  
	0010 => "0010010000000111", -- 		LOADIMM.LOWER	0x07			  
	0012 => "0000010010111001", -- 		SUB				r2 r7 r1		      
	0014 => "0000111010000000", -- 		TEST			r2				          
	0016 => "1000001000010001", -- 		BRR.N			ERROR			       
	0018 => "0000111001000000", -- 		TEST			r1				          
	0020 => "1000010000001111", -- 		BRR.Z			ERROR			       
	0022 => "1000001000001110", -- 		BRR.N			ERROR			       
	0024 => "0010011010001000", -- 		MOV				r2 r1			        
	0026 => "0010010100000000", -- 		LOADIMM.UPPER	0x00     
	0028 => "0010010000000001", -- 		LOADIMM.LOWER	0x01			  
	0030 => "0000010001001111", -- LOOP.START:	SUB			r1 r1 r7		
	0032 => "0000111001000000", -- 		TEST			r1				          
	0034 => "1000010000000011", -- 		BRR.Z			LOOP.EXIT      
	0036 => "0000011010010001", -- 		MUL				r2 r2 r1		      
	0038 => "1000000111111100", -- 		BRR				LOOP.START		    
	0040 => "0100000010000000", -- LOOP.EXIT:	OUT			r2				  
	0042 => "0000000000000000", -- 		NOP                    
	0044 => "0000000000000000", -- 		NOP                    
	0046 => "0000000000000000", -- 		NOP                    
	0048 => "1000000111111100", -- 		BRR	LOOP.EXIT          
	0050 => "0010010101010101", -- ERROR:	LOADIMM.UPPER	0x55
	0052 => "0010010001010101", -- 		LOADIMM.LOWER	0x55     
	0054 => "0100000111000000", -- 		OUT				r7				          
	0056 => "0000000000000000", -- 		NOP                    
	0058 => "0000000000000000", -- 		NOP                    
	0060 => "0000000000000000", -- 		NOP                    
	0062 => "0000000000000000", -- 		NOP                    
	0064 => "0000000000000000", -- 		NOP                    
	0066 => "1000000111111000", -- 		BRR				ERROR           
	0068 => "0001000000000000", -- 		HALT
	others => x"0000" ); -- NOP
begin

p1:    process (clk)
	 variable add_in : integer := 0;
    begin
        if rising_edge(clk) then
					 add_in := conv_integer(unsigned(addr));
                data <= rom_content(add_in);
        end if;
    end process;
end BHV;


