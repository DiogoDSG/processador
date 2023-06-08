library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex is
    port(
        clk: in std_logic;
        rst: in std_logic;
        read_data_1_in: in unsigned(15 downto 0);
        read_data_2_in: in unsigned(15 downto 0);
        wr_reg_in: in unsigned(2 downto 0);
        immediate_in: in unsigned(15 downto 0);
        alu_src_in: in std_logic;
        reg_write_in: in std_logic;
        alu_op_in: in std_logic;
        ram_address_in: in unsigned(6 downto 0);
        opcode_in: in unsigned(3 downto 0);
        mem_write_in: in std_logic;
        mem_to_reg_in: in std_logic;
        reg_op1_in: in unsigned(2 downto 0);
        reg_op2_in: in unsigned(2 downto 0);
        read_data_1_out: out unsigned(15 downto 0);
        read_data_2_out: out unsigned(15 downto 0);
        wr_reg_out: out unsigned(2 downto 0);
        immediate_out: out unsigned(15 downto 0);
        alu_src_out: out std_logic;
        opcode_out: out unsigned(3 downto 0);
        reg_write_out: out std_logic;
        mem_write_out: out std_logic;
        mem_to_reg_out: out std_logic;
        reg_op1_out: out unsigned(2 downto 0);
        reg_op2_out: out unsigned(2 downto 0);
        ram_address_out: out unsigned(6 downto 0);
        alu_op_out: out std_logic
    );
end entity;

architecture a_id_ex of id_ex is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            read_data_1_out <= "0000000000000000";
            read_data_2_out <= "0000000000000000";
            wr_reg_out <= "000";
            immediate_out <= "0000000000000000";
            alu_src_out <= '0';
            opcode_out <= "0000";
            reg_write_out <= '0';
            mem_write_out <= '0';
            mem_to_reg_out <= '0';
            ram_address_out <= "0000000";
            reg_op1_out <= "000";
            reg_op2_out <= "000";
            alu_op_out <= '0';
        elsif (rising_edge(clk)) then
            read_data_1_out <= read_data_1_in;
            read_data_2_out <= read_data_2_in;
            wr_reg_out <= wr_reg_in;
            immediate_out <= immediate_in;
            alu_src_out <= alu_src_in;
            opcode_out <= opcode_in;
            reg_write_out <= reg_write_in;
            mem_write_out <= mem_write_in;
            mem_to_reg_out <= mem_to_reg_in;
            ram_address_out <= ram_address_in;
            reg_op1_out <= reg_op1_in;
            reg_op2_out <= reg_op2_in;
            alu_op_out <= alu_op_in;
        end if;
    end process;
end architecture;


