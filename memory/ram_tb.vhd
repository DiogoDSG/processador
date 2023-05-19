library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end entity;

architecture a_ram_tb of ram_tb is
    component ram
        port(  
            clk : in std_logic;
            address : in unsigned(6 downto 0);
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        ); 
    end component;

    constant period_time: time := 100 ns;
    signal wr_en, clk: std_logic;
    signal data_in, data_out: unsigned(15 downto 0);
    signal finished: std_logic := '0';
    signal address: unsigned(6 downto 0);
    begin
        uut: ram port map(
            clk => clk,
            address => address,
            wr_en => wr_en,
            data_in => data_in,
            data_out => data_out
        );

    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

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


    process
    begin
        wr_en <= '1';
        wait for period_time;
        data_in <= "0011000000000000";
        address <= "0000000";
        wait for period_time;
        wr_en <= '0';
        data_in <= "0011100000000000";
        address <= "0000001";
        wait for period_time;
        address <= "0000000";
        wait for period_time;
        address <= "0000001";
        wait;
    end process;
end architecture;