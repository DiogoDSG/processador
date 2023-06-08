library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branch_control is
    port (
        clk: in std_logic;
        wr_en: in std_logic;
        zero_in: in std_logic;
        overflow_in: in std_logic;
        negative_in: in std_logic;
        zero_out: out std_logic;
        overflow_out: out std_logic;
        negative_out: out std_logic
    );
end entity;

architecture a_branch_control of branch_control is
begin
    process(clk)
    begin 
    if wr_en = '1' then
        if rising_edge(clk) then
            zero_out <= zero_in;
            overflow_out <= overflow_in;
            negative_out <= negative_in;
        end if;
    end if;
    end process;

end architecture;


