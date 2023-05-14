
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
    0 => "01010110000001",
	1 => "01011000000001",
	2 => "01011110110000",
	3 => "00000000000000",
	4 => "00011000000000",
	5 => "00000000000000",
	6 => "01011001110000",
	7 => "00000000000000",
	8 => "01011110110000",
	9 => "01010010000011",
	10 => "00000000000000",
	11 => "00010010000000",
	12 => "00000000000000",
	13 => "01010111110000",
	14 => "01011100111101",
	15 => "01011110110000",
	16 => "00000000000000",
	17 => "00101100000000",
	18 => "11100000000010",
	
    others => (others=>'0'));    
    begin
    data <= rom_content(to_integer(address));      
 
end architecture;
