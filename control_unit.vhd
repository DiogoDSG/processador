library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(
        overflow: in std_logic;
        negative: in std_logic;
        opcode: in unsigned(3 downto 0);
        immediate_id: in std_logic;
        jump_en: out std_logic;
        reg_write: out std_logic;
        alu_src: out std_logic
    );
end entity;

architecture a_control_unit of control_unit is
begin
    jump_en <= '1' when 
    opcode = "1111" or 
    ((opcode="1110") and (negative='1' xor overflow='1'))  
    else '0';

    alu_src <= '1' when (opcode = "0101" or opcode="0001" or opcode="0010") and immediate_id ='1' else '0';
    reg_write <= '1' when opcode /= "0000" and opcode /= "1111" and opcode /="1110" else '0';
end architecture;


