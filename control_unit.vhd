library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(
        opcode: in unsigned(3 downto 0);
        jump_en: out std_logic;
        reg_write: out std_logic;
        alu_src: out std_logic
    );
end entity;

architecture a_control_unit of control_unit is
begin
    jump_en <= '1' when opcode = "1111" else '0';
    alu_src <= '1' when opcode = "0110" else '0';
    reg_write <= '1' when opcode /= "0000" and opcode /= "1111" else '0';
end architecture;


