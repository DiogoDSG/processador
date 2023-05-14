library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex_tb is
end entity;

architecture a_id_ex_tb of id_ex_tb is
    component id_ex
        port(
            clk: in std_logic;
            read_data_1_in: in unsigned(15 downto 0);
            read_data_2_in: in unsigned(15 downto 0);
            wr_reg_in: in unsigned(2 downto 0);
            immediate_in: in unsigned(15 downto 0);
            alu_src_in: in std_logic;
            reg_write_in: in std_logic;
            ram_address_in: in unsigned(6 downto 0);
            opcode_in: in unsigned(3 downto 0);
            mem_write_in: in std_logic;
            mem_to_reg_in: in std_logic;
            read_data_1_out: out unsigned(15 downto 0);
            read_data_2_out: out unsigned(15 downto 0);
            wr_reg_out: out unsigned(2 downto 0);
            immediate_out: out unsigned(15 downto 0);
            alu_src_out: out std_logic;
            opcode_out: out unsigned(3 downto 0);
            reg_write_out: out std_logic;
            mem_write_out: out std_logic;
            mem_to_reg_out: out std_logic;
            ram_address_out: out unsigned(6 downto 0)
        );
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal clk, alu_src_in, alu_src_out, reg_write_in, reg_write_out, mem_write_in, mem_write_out, mem_to_reg_in, mem_to_reg_out: std_logic;
    signal read_data_1_in, read_data_2_in, immediate_in: unsigned(15 downto 0);
    signal read_data_1_out, read_data_2_out, immediate_out: unsigned(15 downto 0);
    signal wr_reg_in, wr_reg_out: unsigned(2 downto 0);
    signal opcode_in, opcode_out: unsigned(3 downto 0);
    signal ram_address_in, ram_address_out: unsigned(6 downto 0);


    begin
        uut: id_ex port map(
            clk => clk,
            read_data_1_in => read_data_1_in,
            read_data_2_in => read_data_2_in,
            wr_reg_in => wr_reg_in,
            immediate_in => immediate_in,
            alu_src_in => alu_src_in,
            opcode_in => opcode_in,
            reg_write_in => reg_write_in,
            mem_write_in => mem_write_in,
            mem_to_reg_in => mem_to_reg_in,
            ram_address_in => ram_address_in,
            ram_address_out => ram_address_out,
            mem_to_reg_out => mem_to_reg_out,
            read_data_1_out => read_data_1_out,
            read_data_2_out => read_data_2_out,
            wr_reg_out => wr_reg_out,
            immediate_out => immediate_out,
            alu_src_out => alu_src_out,
            opcode_out => opcode_out,
            reg_write_out => reg_write_out,
            mem_write_out => mem_write_out
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
        mem_to_reg_in <= '1';
        ram_address_in <= "0000001";
        read_data_1_in <= "0000010010100110";
        read_data_2_in <= "0000011110100110";
        mem_write_in <= '1';
        immediate_in <= "0000011110100110";
        wr_reg_in <= "010";
        alu_src_in <= '1';
        opcode_in <= "1111";
        reg_write_in <= '1';
        wait;
    end process;
end architecture;