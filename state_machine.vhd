library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity state_machine is
    port (
        clk: in std_logic;
        rst: in std_logic;
        current_state: out unsigned(2 downto 0)
    );
end entity;

architecture a_state_machine of state_machine is
signal state: unsigned(2 downto 0) := "000";
begin
    
    process(clk, rst)
    begin   
        if rst = '1' then
            state <= "000";
        elsif rising_edge(clk) then
            if state = "100" then
                state <=  "000";
            else
                state <= state + 1;
            end if;
        end if;
    end process;

    current_state <= state;
end architecture;