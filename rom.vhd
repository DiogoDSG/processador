
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
entity rom is   
    port( clk: in std_logic;         
    address: in unsigned(6 downto 0);         
    data: out unsigned(13 downto 0)); 
end entity; 
architecture a_rom of rom is type mem is array (0 to 127) of unsigned(13 downto 0);   
constant rom_content : mem := (
    0  => "01100010000010",
    1  => "01100100000100",      
    2  => "00010010100110",      
    3  => "00100110011000",  
    4  => "01011000001100",
    5  => "00000000000000",
    6  => "11110000000000",    
    -- 4  => "10000000000000",      
    -- 5  => "00000000001000",      
    -- 6  => "11110000000000",      
    -- 7  => "00000000001000",      
    -- 8  => "00000000001000",      
    -- 9  => "00000000000000",      
    -- 10 => "00000000000000",
    -- abaixo: casos omissos => (zero em todos os bits)      
    others => (others=>'0')); 
    
    begin
        process(clk)   
        begin      
            if(rising_edge(clk)) then         
                data <= rom_content(to_integer(address));      
            end if;   
        end process; 
end architecture;