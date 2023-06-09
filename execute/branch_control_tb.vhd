library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branch_control_tb is
end entity;

architecture a_branch_control_tb of branch_control_tb is
    component branch_control
        port(
            clk: in std_logic;
            wr_en: in std_logic;
            zero_in: in std_logic;
            overflow_in: in std_logic;
            negative_in: in std_logic;
            zero_out: out std_logic;
            overflow_out: out std_logic;
            negative_out: out std_logic

        ); 
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal zero_in, wr_en, zero_out, negative_in, negative_out, overflow_in, overflow_out, clk: std_logic;

    begin
        uut: branch_control port map(
            clk => clk,
            wr_en => wr_en,
            zero_in => zero_in,
            overflow_in => overflow_in,
            negative_in => negative_in,
            zero_out => zero_out,
            overflow_out => overflow_out,
            negative_out => negative_out
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
        negative_in <= '1';
        zero_in <= '0';
        overflow_in <= '1';
        wait for period_time/4;
        zero_in <= '1';
        wait for period_time;
        wait;
    end process;
end architecture;