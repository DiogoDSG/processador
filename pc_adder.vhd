library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_adder is 
    port(
        state: unsigned (2 downto 0);
        current_address: in unsigned(6 downto 0);
        next_address: out unsigned(6 downto 0)
    );
end entity;

architecture a_pc_adder of pc_adder is
begin 
    next_address <= current_address + 1;
end architecture;