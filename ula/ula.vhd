library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port (
        a,b:    in unsigned(7 downto 0);
        sel_op: in unsigned(2 downto 0);
        result: out unsigned(7 downto 0);
        exceed: out std_logic
    );
end entity;

architecture a_ula of ula is
    signal sum,sub,equal,greater: unsigned(7 downto 0);
    signal unsigned_part_greater: std_logic;

begin
    sum <= a+b;
    sub <= a-b;
    equal <= "11111111" when a = b else "00000000";

    -- GREATER
    unsigned_part_greater <= '1' when a(6 downto 0) > b(6 downto 0) else '0';
    greater <= "11111111" when 
                (b(7) = '1' and unsigned_part_greater = '1') or 
                (a(7) = '0' and unsigned_part_greater = '1') or
                (a(7) = '0' and b(7) = '1')
                else "00000000";

    -- EXCEED
    exceed <=  '1' when
                (sel_op="000" and ((a(7)='0' and b(7)='0' and sum(7)='1') or (a(7)='1' and b(7)='1' and sum(7)='0'))) or -- SUM
                (sel_op="001" and ((a(7)='1' and b(7)='0' and sub(7)='0') or (a(7)='0' and b(7)='1' and sub(7)='1')))  -- SUB
                else '0';

    -- RESULT
    result <=   sum when sel_op="000" else
                sub when sel_op="001" else
                equal when sel_op="010" else
                greater when sel_op="011" else 
                "00000000";

end architecture;
