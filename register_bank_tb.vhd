library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_bank_tb is
end entity;

architecture a_register_bank_tb of register_bank_tb is
    component register_bank
        port (
            clk: in std_logic;
            rst: in std_logic;
            read_reg1: in unsigned(2 downto 0);
            read_reg2: in unsigned(2 downto 0);
            wr_en: in std_logic;
            wr_data: in unsigned(15 downto 0);
            wr_reg: in unsigned(2 downto 0);
            read_data1: out unsigned(15 downto 0);
            read_data2: out unsigned(15 downto 0)
        );
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk, rst, wr_en: std_logic;
    signal read_reg1, read_reg2, wr_reg: unsigned(2 downto 0);
    signal read_data1, read_data2, wr_data: unsigned(15 downto 0);

    signal address: unsigned(6 downto 0);
    begin
        uut: register_bank port map(
            clk => clk,
            rst => rst,
            read_reg1 => read_reg1,
            read_reg2 => read_reg2,
            wr_en => wr_en,
            wr_data => wr_data,
            wr_reg => wr_reg,
            read_data1 => read_data1,
            read_data2 => read_data2
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
        wr_en <= '1';
        wr_reg <= "000";
        wr_data <= "0000000000000001";
        wait for period_time;
        wr_reg <= "001";
        wr_data <= "0000000000000010";
        wait for period_time;
        wr_reg <= "010";
        wr_data <= "0000000000000011";
        wait for period_time;
        wr_reg <= "011";
        wr_data <= "0000000000000100";
        wait for period_time;
        wr_reg <= "100";
        wr_data <= "0000000000000101";
        wait for period_time;
        wr_reg <= "101";
        wr_data <= "0000000000000110";
        wait for period_time;
        wr_reg <= "110";
        wr_data <= "0000000000000111";
        wait for period_time;
        wr_reg <= "111";
        wr_data <= "0000000000001000";
        wait for period_time;
        wr_en <= '0';
        read_reg1 <= "000";
        read_reg2 <= "001";
        wait for period_time;
        read_reg1 <= "010";
        read_reg2 <= "011";
        wait for period_time;
        read_reg1 <= "100";
        read_reg2 <= "101";
        wait for period_time;
        read_reg1 <= "110";
        read_reg2 <= "111";
        wait for period_time;
        wr_en <= '1';
        wr_reg <= "001";
        wr_data <= "0000000000010000";
        read_reg1 <= "001";
        wait for period_time;
        wr_en <= '0';
        wait;
    end process;
end architecture;