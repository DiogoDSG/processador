library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_wb is
    port(
        clk: in std_logic;
        mem_to_reg_in: in std_logic;
        reg_write_in: in std_logic;
        reg_dst_in: in unsigned(2 downto 0);
        ram_data_in: in unsigned(15 downto 0);
        alu_result_in: in unsigned(15 downto 0);
        mem_to_reg_out: out std_logic;
        reg_write_out: out std_logic;
        reg_dst_out: out unsigned(2 downto 0);
        ram_data_out: out unsigned(15 downto 0);
        alu_result_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_mem_wb of mem_wb is
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            mem_to_reg_out <= mem_to_reg_in;
            reg_write_out <= reg_write_in;
            reg_dst_out <= reg_dst_in;
            ram_data_out <= ram_data_in;
            alu_result_out <= alu_result_in;
        end if;
    end process;
end architecture;


