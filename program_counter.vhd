library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is 
    port(
        clk: in std_logic;
        wr_en: in std_logic;
        address_in: in unsigned(6 downto 0);
        address_out: out unsigned(6 downto 0)
    );
end entity;

architecture a_program_counter of program_counter is
    signal data: unsigned(6 downto 0);
begin 
    process (clk, wr_en)
    begin 
        if (wr_en='1') then
            if (rising_edge(clk)) then
                data <= address_in;
            end if;
        end if;
    end process;
    address_out <= data;
end architecture;