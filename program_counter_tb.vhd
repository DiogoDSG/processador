library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter_tb is
end entity;

architecture a_program_counter_tb of program_counter_tb is
    component program_counter
        port(
            clk: in std_logic;
            wr_en: in std_logic;
            address_in: in unsigned(6 downto 0);
            address_out: out unsigned(6 downto 0)
        ); 
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk: std_logic;
    signal wr_en: std_logic;
    signal address_in: unsigned(6 downto 0);
    signal address_out: unsigned(6 downto 0);

    begin
        uut: program_counter port map(
            clk => clk,
            wr_en => wr_en,
            address_in => address_in,
            address_out => address_out
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
        wr_en <= '1';
        address_in <= "0000010";
        wait for period_time*2;
        address_in <= "1111111";
        wait for period_time;
        wr_en <= '0';
        wait for period_time;
        address_in <= "1000000";
        wait;
    end process;
end architecture;