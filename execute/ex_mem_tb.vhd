library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_mem_tb is
end entity;

architecture a_ex_mem_tb of ex_mem_tb is
    component ex_mem
        port(
            clk: in std_logic;
            mem_write_in: in std_logic;
            alu_result_in: in unsigned(15 downto 0);
            address_in: in unsigned(6 downto 0);
            reg_write_in: in std_logic;
            mem_to_reg_in: in std_logic;
            reg_dst_in: in unsigned(2 downto 0);
            write_data_in: in unsigned(15 downto 0);
            mem_write_out: out std_logic;
            alu_result_out: out unsigned(15 downto 0);
            write_data_out: out unsigned(15 downto 0);
            address_out: out unsigned(6 downto 0);
            reg_write_out: out std_logic;
            mem_to_reg_out: out std_logic;
            reg_dst_out: out unsigned(2 downto 0)
        );
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk, mem_write_in, mem_write_out, reg_write_in, reg_write_out, mem_to_reg_in, mem_to_reg_out: std_logic;
    signal alu_result_in, alu_result_out: unsigned(15 downto 0);
    signal address_in, address_out: unsigned(6 downto 0);
    signal write_data_in, write_data_out: unsigned(15 downto 0);
    signal reg_dst_in, reg_dst_out: unsigned(2 downto 0);

    begin
        uut: ex_mem port map(
            clk => clk,
            address_in => address_in,
            alu_result_in => alu_result_in,
            reg_write_in => reg_write_in,
            mem_to_reg_in => mem_to_reg_in,
            reg_dst_in => reg_dst_in,
            write_data_in => write_data_in,
            mem_write_in => mem_write_in,
            write_data_out => write_data_out,
            mem_write_out => mem_write_out,
            address_out => address_out,
            alu_result_out => alu_result_out,
            reg_write_out => reg_write_out,
            mem_to_reg_out => mem_to_reg_out,
            reg_dst_out => reg_dst_out
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
        reg_dst_in <= "001";
        mem_to_reg_in <= '1';
        reg_write_in <= '1';
        alu_result_in <= "0001001010011010";
        write_data_in <= "0001001010010100";
        address_in <= "0000001";
        mem_write_in <= '1';
        wait for period_time * 1.5;
        mem_to_reg_in <= '0';
        reg_dst_in <= "010";
        reg_write_in <= '0';
        address_in <= "0000010";
        alu_result_in <= "1111001010011010";
        write_data_in <= "1111001010010111";
        mem_write_in <= '0';
        wait for period_time/4;

        wait;
    end process;
end architecture;