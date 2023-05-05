library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is
    component ula
        port(
            a,b:    in unsigned(15 downto 0);
            sel_op: in unsigned(3 downto 0);
            result: out unsigned(15 downto 0);
            exceed: out std_logic

        ); 
    end component;

    signal a,b,result: unsigned(15 downto 0);
    signal exceed: std_logic;
    signal sel_op: unsigned(3 downto 0);

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
        sel_op <= "0000"; -- = 10
        wait for 10 ns; 
        a <= "1111111111111101"; -- FD (-03)
        b <= "0000000000001000"; -- 08
        sel_op <= "0000"; -- = 05
        wait for 10 ns;
        a <= "1111111111111111"; -- FF (-1)
        b <= "1111111111111100"; -- FC (-4)
        sel_op <= "0000"; -- = FB (-5)
        wait for 10 ns;
        a <= "0000000000000101"; -- FF (5)
        b <= "1111111111111011"; -- FC (-5)
        sel_op <= "0000"; -- = FB (0)
        wait for 10 ns;
        a <= "0111111111111111"; -- FF (32767)
        b <= "0111111111111111"; -- FC (32767)
        sel_op <= "0000"; -- = FB (65534)
        wait for 10 ns;

        -- SUBTRACTION
        a <= "0000000000001010"; -- 10
        b <= "0000000000001000"; -- 08
        sel_op <= "0001"; -- = 02
        wait for 10 ns; 
        a <= "1111111111111100"; -- -4
        b <= "1111111111111011"; -- -5
        sel_op <= "0001"; -- = 1
        wait for 10 ns;
        a <= "0000000000000101"; -- 5
        b <= "1111111111111101"; -- -3
        sel_op <= "0001"; -- = 8
        wait for 10 ns;
        a <= "1000000000000001"; -- -32767
        b <= "0111111111111111"; -- 32767
        sel_op <= "0001"; -- = -63534
        wait for 10 ns;
        a <= "0000000000001000"; -- 08
        b <= "0000000000001000"; -- 08
        sel_op <= "0001"; -- = 0
        wait for 10 ns; 
        a <= "1111111111111111"; -- -1
        b <= "1111111111111111"; -- -1
        sel_op <= "0001"; -- = 0
        wait for 10 ns;
        a <= "0000000000000000"; -- 0
        b <= "0000000000000000"; -- 0
        sel_op <= "0001"; -- = 0
        wait for 10 ns; 

        -- EQUAL (TRUE = 1, FALSE = 0)
        a <= "0000000000000000"; -- 0
        b <= "0000000000000000"; -- 0
        sel_op <= "0010"; -- TRUE
        wait for 10 ns; 
        a <= "0000000000000001"; -- 1
        b <= "0000000000000000"; -- 0
        sel_op <= "0010"; -- FALSE
        wait for 10 ns;
        a <= "1111111111111111"; -- -1  
        b <= "1000000000000001"; -- 1
        sel_op <= "0010"; -- FALSE
        wait for 10 ns;
        a <= "1111111111111111"; -- -1
        b <= "1111111111111111"; -- -1
        sel_op <= "0010"; -- TRUE
        wait for 10 ns;
        a <= "0111111111111111"; -- 32767
        b <= "0111111111111111"; -- 32767
        sel_op <= "0010"; -- TRUE
        wait for 10 ns;
        a <= "1000000000000001"; -- -32767
        b <= "1000000000000001"; -- -32767
        sel_op <= "0010"; -- TRUE
        wait for 10 ns;

        -- GREATER
        a <= "0000000000000000"; -- 0
        b <= "0000000000000001"; -- 1
        sel_op <= "0011"; -- FALSE
        wait for 10 ns; 
        a <= "0000000000001000"; -- 8 
        b <= "0000000000000001"; -- 1
        sel_op <= "0011"; -- TRUE
        wait for 10 ns;
        a <= "0000000000001000"; -- 8
        b <= "0000000000001000"; -- 8
        sel_op <= "0011"; -- FALSE
        wait for 10 ns;
        a <= "1111111111111000"; -- -8
        b <= "0000000000000001"; -- 1
        sel_op <= "0011"; -- FALSE
        wait for 10 ns;
        a <= "1111111111111000"; -- -8
        b <= "1111111111110111"; -- -9
        sel_op <= "0011"; -- TRUE
        wait for 10 ns;
        a <= "0111111111111111"; -- 32767
        b <= "0111111111111110"; -- 32766
        sel_op <= "0011"; -- TRUE
        wait for 10 ns;
        a <= "1000000000000010"; -- -32766
        b <= "1000000000000001"; -- -32767
        sel_op <= "0011"; -- TRUE
        wait for 10 ns;
        wait;

        -- EXCEED   
        a <= "0111111111111111";
        b <= "0000000000000001";
        sel_op <= "0000"; -- SUM = FF (-1)
        wait for 10 ns; 
        a <= "0111111111111111"; -- negative 
        b <= "1111111111111111";
        sel_op <= "0001"; -- SUB = 00
        wait for 10 ns;
      
        wait;

    end process;
end architecture;