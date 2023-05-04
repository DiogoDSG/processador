library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity;

architecture a_processor_tb of processor_tb is
    component processor
        port(
            clk: in std_logic;
            rst: in std_logic;
            reg1: in unsigned(2 downto 0);
            reg2: in unsigned(2 downto 0);
            wr_reg: in unsigned(2 downto 0);
            sel_op: in unsigned(2 downto 0);
            alu_out: out unsigned(15 downto 0)
        ); 
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal ext_constant: unsigned(15 downto 0) := "0000000000000000";
    signal wr_en, clk, rst, alu_src: std_logic;
    signal reg1, reg2, wr_reg, sel_op: unsigned(2 downto 0);
    signal alu_out: unsigned(15 downto 0);
    begin
        uut: processor port map(
            clk => clk,
            rst => rst,
            reg1 => reg1,
            reg2 => reg2,
            wr_reg => wr_reg,
            sel_op => sel_op,
            alu_out => alu_out
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
        alu_src <= '0';
        wr_en <='1';
        wait for period_time;
        rst <= '0';
        sel_op <= "000";
        reg1 <= "001";
        wr_reg <= "001";
        ext_constant <= "0000000000000010";
        alu_src<='1';
        wait for period_time*2;
        sel_op <= "000";
        reg1 <= "001";
        reg2 <= "010";
        wr_reg <= "011";
        alu_src<='0';
        wait;
    end process;
end architecture;