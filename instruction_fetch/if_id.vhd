library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id is
    port(
        clk: in std_logic;
        rst: in std_logic;
        instruction_in: in unsigned(13 downto 0);
        instruction_out: out unsigned(13 downto 0) := "00000000000000"
    );
end entity;

architecture a_if_id of if_id is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            instruction_out <= "00000000000000";
        elsif (rising_edge(clk)) then
            instruction_out <= instruction_in;
        end if;
    end process;
end architecture;


