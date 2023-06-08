
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
    0 => "01011110000101",
	1 => "00110000001011",
	2 => "11010000000000",
	3 => "11100000000000",
	
    others => (others=>'0'));    
    begin
    data <= rom_content(to_integer(address));      
 
end architecture;
