library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit
        port(
            opcode: in unsigned(3 downto 0);
            jump_en: out std_logic;
            alu_src: out std_logic;
            reg_write: out std_logic
        );
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal  jump_en, reg_write, alu_src: std_logic;
    signal opcode: unsigned(3 downto 0);

    begin
        uut: control_unit port map(
            opcode => opcode,
            jump_en => jump_en,
            alu_src => alu_src,
            reg_write => reg_write
        );


    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    process
    begin
        opcode <= "1111";
        wait for period_time/2;
        opcode <= "0110";
        wait for period_time/2;
        opcode <= "0001";
        wait for period_time/2;
        wait;
    end process;
end architecture;