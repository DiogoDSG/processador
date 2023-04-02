library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
    component ula
        port(
            a,b:    in unsigned(7 downto 0);
            sel_op: in unsigned(2 downto 0);
            result: out unsigned(7 downto 0)
        ); 
    end component;

    signal a,b,result: unsigned(7 downto 0);
    signal sel_op: unsigned(2 downto 0);

    begin
        uut: ula port map(
            a => a,
            b => b,
            sel_op => sel_op,
            result => result
        );
    process
    begin
        -- SUM
        a <= "00001000"; -- 08
        b <= "00001000"; -- 08
        sel_op <= "000"; -- = 10
        wait for 10 ns; 
        a <= "11111101"; -- FD (-03)
        b <= "00001000"; -- 08
        sel_op <= "000"; -- = 05
        wait for 10 ns;
        a <= "11111111"; -- FF (-1)
        b <= "11111100"; -- FC (-4)
        sel_op <= "000"; -- = FB (-5)
        wait for 10 ns;

        -- SUBTRACTION
        a <= "00001000"; -- 08
        b <= "00001000"; -- 08
        sel_op <= "001"; -- = 00
        wait for 10 ns; 
        a <= "10000000"; -- -80
        b <= "10000000"; -- -80
        sel_op <= "001"; -- = 00
        wait for 10 ns;
        a <= "10000011"; -- 83 (-125)
        b <= "10000001"; -- -81 (-127)
        sel_op <= "001"; -- = 02
        wait for 10 ns;
        a <= "00000111"; -- -07
        b <= "00000001"; -- -01
        sel_op <= "001"; -- = 06
        wait for 10 ns;

        -- EQUAL
        a <= "00001000"; 
        b <= "00001000"; 
        sel_op <= "010"; -- = FF
        wait for 10 ns; 
        a <= "10000000"; 
        b <= "00000010"; 
        sel_op <= "010"; -- = 00
        wait for 10 ns;
        a <= "11011100";  
        b <= "11011101"; -- = 00
        sel_op <= "010";
        wait for 10 ns;
        a <= "11011101";  
        b <= "11011101"; -- = FF
        sel_op <= "010";
        wait for 10 ns;

        -- GREATER
        a <= "00001000";
        b <= "00001000";
        sel_op <= "011"; -- = 00
       wa it for 10 ns; 
        a <= "10000000"; -- negative 
        b <= "00000010";
        sel_op <= "011"; -- = 00
        wait for 10 ns;
        a <= "10000011";
        b <= "10000001"; -- = 00
        sel_op <= "011";
        wait for 10 ns;
        a <= "00000011";
        b <= "00000001"; -- = FF
        sel_op <= "011";
        wait for 10 ns;
        a <= "10000001";
        b <= "11111111"; -- = FF
        sel_op <= "011";
        wait for 10 ns;
        wait;
    end process;
end architecture;