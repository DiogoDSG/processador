library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_tb is
end entity;

architecture a_state_machine_tb of state_machine_tb is
    component state_machine
        port(
            clk: in std_logic;
            rst: in std_logic;
            current_state: out unsigned(0 downto 0)
        ); 
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk: std_logic;
    signal rst: std_logic;
    begin
        uut: state_machine port map(
            clk => clk,
            rst => rst
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
        rst <= '0';
        wait for period_time*10;
        rst <= '1';
        wait;
    end process;
end architecture;