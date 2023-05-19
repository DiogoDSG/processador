library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id_tb is
end entity;

architecture a_if_id_tb of if_id_tb is
    component if_id
        port(
            clk: in std_logic;
            rst: in std_logic;
            instruction_in: in unsigned(13 downto 0);
            instruction_out: out unsigned(13 downto 0)
        );
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk, rst: std_logic;
    signal instruction_in, instruction_out: unsigned(13 downto 0);

    begin
        uut: if_id port map(
            clk => clk,
            rst => rst,
            instruction_in => instruction_in,
            instruction_out => instruction_out
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
        rst <= '1';
        wait for period_time;
        rst <= '0';
        instruction_in <= "00010010100110";
        wait;
    end process;
end architecture;