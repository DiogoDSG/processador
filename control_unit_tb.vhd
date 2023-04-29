library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit
        port(
            clk: in std_logic;
            rst: in std_logic;
            data: out unsigned(13 downto 0);
            current_state: out std_logic
        );
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk: std_logic;
    signal rst: std_logic;
    signal data: unsigned(13 downto 0);
    signal current_state: std_logic;

    begin
        uut: control_unit port map(
            clk => clk,
            rst => rst,
            data => data,
            current_state => current_state
        );

    rst_global: process
    begin
        rst <= '1';
        wait for period_time;
        rst <= '0';
        wait;
    end process rst_global;

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

    -- process
    -- begin
    --     rst <= '1';
    --     wait for period_time/2;
    --     rst <= '0';
    --     wait;
    -- end process;
end architecture;