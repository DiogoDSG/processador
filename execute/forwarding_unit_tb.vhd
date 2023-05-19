library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwarding_unit_tb is
end entity;

architecture a_forwarding_unit_tb of forwarding_unit_tb is
    component forwarding_unit
        port(
            reg_op1: in unsigned(2 downto 0);
            reg_op2: in unsigned(2 downto 0);
            ex_mem_reg_dst: in unsigned(2 downto 0);
            mem_wb_reg_dst: in unsigned(2 downto 0);
            reg_op1_fw_en: out unsigned (1 downto 0);
            reg_op2_fw_en: out unsigned (1 downto 0)
        );
    end component;

    signal reg_op1, reg_op2, ex_mem_reg_dst, mem_wb_reg_dst: unsigned(2 downto 0);
    signal reg_op1_fw_en, reg_op2_fw_en: unsigned(1 downto 0);
    begin
        uut: forwarding_unit port map(
            reg_op1 => reg_op1,
            reg_op2 => reg_op2,
            ex_mem_reg_dst => ex_mem_reg_dst,
            mem_wb_reg_dst => mem_wb_reg_dst,
            reg_op1_fw_en => reg_op1_fw_en,
            reg_op2_fw_en => reg_op2_fw_en
        );

    process
    begin
        reg_op1 <= "001";
        reg_op2 <= "010";
        ex_mem_reg_dst <= "001";
        mem_wb_reg_dst <= "010";
        wait for 100 ns;
        reg_op1 <= "001";
        reg_op2 <= "010";
        ex_mem_reg_dst <= "010";
        mem_wb_reg_dst <= "001";
        wait for 100 ns;
        reg_op1 <= "001";
        reg_op2 <= "010";
        ex_mem_reg_dst <= "001";
        mem_wb_reg_dst <= "001";
        wait for 100 ns;
        reg_op1 <= "001";
        reg_op2 <= "010";
        ex_mem_reg_dst <= "010";
        mem_wb_reg_dst <= "010";
        wait;
    end process;
end architecture;