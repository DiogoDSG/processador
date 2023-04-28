library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits_tb is
end entity;

architecture a_reg16bits_tb of reg16bits_tb is
    component reg16bits
        port(
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0);
            wr_en: in std_logic;
            clk: in std_logic;
            rst: in std_logic

        ); 
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal data_in,data_out: unsigned(15 downto 0) := "0000000000000000";
    signal wr_en, clk, rst: std_logic;

    begin
        uut: reg16bits port map(
            data_in => data_in,
            data_out => data_out,
            wr_en => wr_en,
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
    rst_global: process
    begin
        rst <= '0';
        wait for period_time * 4;
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
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
        wr_en <= '1';
        wait for period_time*4;
        data_in <= "1111111111111111";
        wait for period_time;
        data_in <= "0101010101101101";
        wait for period_time;
        data_in <= "0101010101101101";
        wait for period_time;
        wr_en <= '0';
        wait for period_time;
        data_in <= "1010000000000000";
        wait for period_time;
        wr_en <= '1';
        wait for period_time;
        data_in <= "1010000000000000";
        wait for period_time/4;
        data_in <= "0000000000000111";
        wait;
    end process;
end architecture;