library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
    component rom
        port(
            clk: in std_logic;         
            address: in unsigned(6 downto 0);         
            data: out unsigned(13 downto 0)
        ); 
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk: std_logic;
    signal address: unsigned(6 downto 0);
    begin
        uut: rom port map(
            clk => clk,
            address => address
        );
    clk_global: process
    begin
        while finished /= '1' loop
            clk <= '1';
            wait for period_time / 2;
            clk <= '0';
            wait for period_time / 2;
        end loop;
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    process
    begin
        wait for period_time;
        address <= "0000000";
        wait for period_time;
        address <= "0000001";
        wait for period_time;
        address <= "1111111";
        wait for period_time / 2;
        address <= "0000000";
        wait;
    end process;
end architecture;