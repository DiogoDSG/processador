library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
    component ula
        port(
            a,b:    in unsigned(15 downto 0);
            sel_op: in unsigned(2 downto 0);
            result: out unsigned(15 downto 0);
            exceed: out std_logic

        ); 
    end component;

    signal a,b,result: unsigned(15 downto 0);
    signal exceed: std_logic;
    signal sel_op: unsigned(2 downto 0);

    begin
        uut: ula port map(
            a => a,
            b => b,
            sel_op => sel_op,
            result => result,
            exceed => exceed
        );
    process
    begin
        -- SUM
        a <= "0000000000001000"; -- 08
        b <= "0000000000001000"; -- 08
        sel_op <= "000"; -- = 10
        wait for 10 ns; 
        a <= "1111111111111101"; -- FD (-03)
        b <= "0000000000001000"; -- 08
        sel_op <= "000"; -- = 05
        wait for 10 ns;
        a <= "1111111111111111"; -- FF (-1)
        b <= "1111111111111100"; -- FC (-4)
        sel_op <= "000"; -- = FB (-5)
        wait for 10 ns;

        -- SUBTRACTION
        a <= "0000000000001000"; -- 08
        b <= "0000000000001000"; -- 08
        sel_op <= "001"; -- = 00
        wait for 10 ns; 
        a <= "1000000000000000"; -- 
        b <= "1000000000000000"; -- 
        sel_op <= "001"; -- = 00
        wait for 10 ns;
        a <= "1000000000000011"; -- 
        b <= "1000000000000001"; -- 
        sel_op <= "001"; -- = 02
        wait for 10 ns;
        a <= "0000000000000111"; -- -07
        b <= "0000000000000001"; -- -01
        sel_op <= "001"; -- = 06
        wait for 10 ns;

        -- EQUAL
        a <= "0000000000001000"; 
        b <= "0000000000001000"; 
        sel_op <= "010"; -- 
        wait for 10 ns; 
        a <= "1000000000000000"; 
        b <= "0000001000000000"; 
        sel_op <= "010"; -- 
        wait for 10 ns;
        a <= "1101110000000000";  
        b <= "1101110100000000"; 
        sel_op <= "010";
        wait for 10 ns;
        a <= "1101110100000000";  
        b <= "1101110100000000"; -- = FF
        sel_op <= "010";
        wait for 10 ns;

        -- GREATER
        a <= "0000000000001000";
        b <= "0000000000001000";
        sel_op <= "011"; -- = 00
        wait for 10 ns; 
        a <= "1000000000000000"; 
        b <= "0000001000000000";
        sel_op <= "011"; -- = 00
        wait for 10 ns;
        a <= "1000001100000000";
        b <= "1000000100000000"; -- = 00
        sel_op <= "011";
        wait for 10 ns;
        a <= "0000000000000011";
        b <= "0000000000000001"; -- = FF
        sel_op <= "011";
        wait for 10 ns;
        a <= "1000000100000000";
        b <= "1111111111111111"; -- = FF
        sel_op <= "011";
        wait for 10 ns;
        wait;

        -- EXCEED   
        a <= "0111111111111111";
        b <= "0000000000000001";
        sel_op <= "000"; -- SUM = FF (-1)
        wait for 10 ns; 
        a <= "0111111111111111"; -- negative 
        b <= "1111111111111111";
        sel_op <= "001"; -- SUB = 00
        wait for 10 ns;
      
        wait;

    end process;
end architecture;