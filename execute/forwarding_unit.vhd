library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwarding_unit is
    port(
        reg_op1: in unsigned(2 downto 0);
        reg_op2: in unsigned(2 downto 0);
        ex_mem_reg_dst: in unsigned(2 downto 0);
        mem_wb_reg_dst: in unsigned(2 downto 0);
        reg_op1_fw_en: out unsigned (1 downto 0);
        reg_op2_fw_en: out unsigned (1 downto 0)
    );
end entity;

architecture a_forwarding_unit of forwarding_unit is
begin
    reg_op1_fw_en <= "01" when reg_op1 = ex_mem_reg_dst else "10" when reg_op1 = mem_wb_reg_dst else "00";
    reg_op2_fw_en <= "01" when reg_op2 = ex_mem_reg_dst else "10" when reg_op2 = mem_wb_reg_dst else "00";
end architecture;


