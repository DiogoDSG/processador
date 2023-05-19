library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
    component rom
        port(  
            address: in unsigned(6 downto 0);         
            data: out unsigned(13 downto 0)
        ); 
    end component;

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal address: unsigned(6 downto 0);
    begin
        uut: rom port map(
            address => address
        );

    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    process
    begin
        address <= "0000000";
        address <= "0000001";
        address <= "1111111";
        address <= "0000000";
        wait;
    end process;
end architecture;