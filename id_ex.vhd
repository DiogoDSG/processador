library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex is
    port(
        clk: in std_logic;
        read_data_1_in: in unsigned(15 downto 0);
        read_data_2_in: in unsigned(15 downto 0);
        wr_reg_in: in unsigned(2 downto 0);
        immediate_in: in unsigned(15 downto 0);
        alu_src_in: in std_logic;
        reg_write_in: in std_logic;
        opcode_in: in unsigned(3 downto 0);
        read_data_1_out: out unsigned(15 downto 0);
        read_data_2_out: out unsigned(15 downto 0);
        wr_reg_out: out unsigned(2 downto 0);
        immediate_out: out unsigned(15 downto 0);
        alu_src_out: out std_logic;
        opcode_out: out unsigned(3 downto 0);
        reg_write_out: out std_logic
    );
end entity;

architecture a_id_ex of id_ex is
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            read_data_1_out <= read_data_1_in;
            read_data_2_out <= read_data_2_in;
            wr_reg_out <= wr_reg_in;
            immediate_out <= immediate_in;
            alu_src_out <= alu_src_in;
            opcode_out <= opcode_in;
            reg_write_out <= reg_write_in;
        end if;
    end process;
end architecture;


