library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_mem is
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
end entity;

architecture a_ex_mem of ex_mem is
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            mem_write_out <= mem_write_in;
            alu_result_out <= alu_result_in;
            write_data_out <= write_data_in;
            address_out <= address_in;
            reg_write_out <= reg_write_in;
            mem_to_reg_out <= mem_to_reg_in;
            reg_dst_out <= reg_dst_in;
        end if;
    end process;
end architecture;


