library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port (
        a,b:    in unsigned(15 downto 0);
        sel_op: in unsigned(3 downto 0);
        result: out unsigned(15 downto 0);
        overflow: out std_logic;
        negative: out std_logic
    );
end entity;

architecture a_alu of alu is
    signal sum,sub, result_signal: unsigned(15 downto 0);

begin
    sum <= a+b;
    sub <= a-b;
    -- equal <= "0000000000000001" when a = b else "0000000000000000";

    -- -- GREATER
    -- unsigned_part_greater <= '1' when a(6 downto 0) > b(6 downto 0) else '0';
    -- greater <= "0000000000000001" when 
    --             (b(15) = '1' and unsigned_part_greater = '1') or 
    --             (a(15) = '0' and unsigned_part_greater = '1') or
    --             (a(15) = '0' and b(15) = '1')
    --             else "0000000000000000";

    -- OVERFLOW
    overflow <=  '1' when
                (sel_op="0000" and (
                    (a(15)='0' and b(15)='0' and sum(15)='1') or 
                    (a(15)='1' and b(15)='1' and sum(15)='0'))) or -- SUM
                (sel_op="0001" and (
                    (a(15)='1' and b(15)='0' and sub(15)='0') or 
                    (a(15)='0' and b(15)='1' and sub(15)='1')))  -- SUB
                else '0';

    -- RESULT
    result_signal <=   sum when sel_op="0000" else 
                sum when sel_op="0001" else
                sub when sel_op="0010" else
                -- equal when sel_op="0011" else
                -- greater when sel_op="0100" else
                sum when sel_op="0101" else
                sum when sel_op="0110" else
                "0000000000000000";
    result <= result_signal;

    -- NEGATIVE
    negative <= result_signal(15);

end architecture;
