library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit
        port(
            opcode: in unsigned(3 downto 0);
            state: in unsigned(2 downto 0);
            jump_en: out std_logic;
            reg_write: out std_logic;
            alu_src: out std_logic;
            pc_write: out std_logic
        );
    end component;

    

    constant period_time: time := 100 ns;
    signal finished: std_logic := '0';
    signal  jump_en, reg_write, alu_src, pc_write: std_logic;
    signal state: unsigned(2 downto 0);
    signal opcode: unsigned(3 downto 0);

    begin
        uut: control_unit port map(
            opcode => opcode,
            state => state,
            jump_en => jump_en,
            alu_src => alu_src,
            reg_write => reg_write,
            pc_write => pc_write
        );


    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process;

    process
    begin
        -- Testando jump para todos os estados
        state <= "001";
        opcode <= "1111";
        wait for period_time/2;
        state <= "010";
        opcode <= "1111";
        wait for period_time/2;
        state <= "011";
        opcode <= "1111";
        wait for period_time/2;
        state <= "100";
        opcode <= "1111";
        wait for period_time/2;

        -- Testando alusrc para todos os estados
        state <= "001";
        opcode <= "0110";
        wait for period_time/2;
        state <= "010";
        opcode <= "0110";
        wait for period_time/2;
        state <= "011";
        opcode <= "0110";
        wait for period_time/2;
        state <= "100";
        opcode <= "0110";
        wait for period_time/2;
        opcode <= "0000";
        state <= "000";
        wait;
    end process;
end architecture;