
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
    0 => "01010110000111",
	1 => "01011000000001",
	2 => "01011110000001",
	3 => "00010110000000",
	4 => "00011000000000",
	5 => "01011001110000",
	6 => "01011110110000",
	7 => "00010000000011",
	8 => "01010111110000",
	9 => "00110000111101",
	10 => "11100000000010",
	11 => "01011011000000",
	
    others => (others=>'0'));    
    begin
    data <= rom_content(to_integer(address));      
 
end architecture;
