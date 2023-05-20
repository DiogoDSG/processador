library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwarding_unit is
    port(
        alu_src: in std_logic;
        ex_mem_reg_write: in std_logic;
        mem_wb_reg_write: in std_logic;
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
    reg_op1_fw_en <= "01" when reg_op1 = ex_mem_reg_dst and reg_op1 /= "000" and ex_mem_reg_write='1' else "10" when reg_op1 = mem_wb_reg_dst and reg_op1 /= "000" and mem_wb_reg_write='1' else "00";
    reg_op2_fw_en <= "01" when reg_op2 = ex_mem_reg_dst and alu_src='0' and ex_mem_reg_write='1' and reg_op2 /= "000" else "10" when reg_op2 = mem_wb_reg_dst and alu_src='0' and reg_op2 /= "000" and mem_wb_reg_write='1' else "00";
end architecture;


