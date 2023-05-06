library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id is
    port(
        clk: in std_logic;
        instruction_in: in unsigned(13 downto 0);
        instruction_out: out unsigned(13 downto 0)

    );
end entity;

architecture a_if_id of if_id is
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            instruction_out <= instruction_in;
        end if;
    end process;
end architecture;


