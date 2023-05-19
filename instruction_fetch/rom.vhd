
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
entity rom is   
    port(         
    address: in unsigned(6 downto 0);         
    data: out unsigned(13 downto 0)); 
end entity; 
architecture a_rom of rom is type mem is array (0 to 127) of unsigned(13 downto 0);   
constant rom_content : mem := (
    0 => "01011110110011",
	1 => "01110000001010",
	2 => "01011110011001",
	3 => "01010010011111",
	4 => "00010010000000",
	5 => "01010011110000",
	6 => "01100000001010",
	7 => "00010010000000",
	8 => "01010101110000",
	9 => "01100000001010",
	10 => "00100010000000",
	11 => "11100000000010",
	
    others => (others=>'0'));    
    begin
    data <= rom_content(to_integer(address));      
 
end architecture;
