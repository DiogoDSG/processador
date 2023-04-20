library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_bank is
    port (
        clk: in std_logic;
        rst: in std_logic;
        read_reg1: in unsigned(2 downto 0);
        read_reg2: in unsigned(2 downto 0);
        wr_en: in std_logic;
        wr_data: in unsigned(15 downto 0);
        wr_reg: in unsigned(2 downto 0);
        read_data1: out unsigned(15 downto 0);
        read_data2: out unsigned(15 downto 0)
    );
end entity;

architecture a_register_bank of register_bank is
    component reg16bits
        port(
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0);
            wr_en: in std_logic;
            clk: in std_logic;
            rst: in std_logic

        ); 
    end component;

    signal data_in: unsigned(15 downto 0);
    signal wr_en_0, wr_en_1, wr_en_2, wr_en_3, wr_en_4, wr_en_5, wr_en_6, wr_en_7: std_logic;
    signal data_out_0, data_out_1, data_out_2, data_out_3, data_out_4, data_out_5, data_out_6, data_out_7: unsigned(15 downto 0);

begin
    
    zero: reg16bits port map(clk=>clk, rst=>'1', wr_en=>wr_en_0, data_in=>data_in, data_out=>data_out_0);
    reg1: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en_1, data_in=>data_in, data_out=>data_out_1);
    reg2: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en_2, data_in=>data_in, data_out=>data_out_2);
    reg3: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en_3, data_in=>data_in, data_out=>data_out_3);
    reg4: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en_4, data_in=>data_in, data_out=>data_out_4);
    reg5: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en_5, data_in=>data_in, data_out=>data_out_5);
    reg6: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en_6, data_in=>data_in, data_out=>data_out_6);
    reg7: reg16bits port map(clk=>clk, rst=>rst, wr_en=>wr_en_7, data_in=>data_in, data_out=>data_out_7);

    process(clk, rst, wr_en,read_reg1,read_reg2,wr_reg)
    begin   
        if rising_edge(clk) then
            data_in <= wr_data;
            
            if wr_en='1' then
                if wr_reg = "001" then
                    wr_en_1 <= wr_en;
                    data_in <= wr_data;
                elsif wr_reg = "010" then
                    wr_en_2 <= wr_en;
                    data_in <= wr_data;
                elsif wr_reg = "011" then
                    wr_en_3 <= wr_en;
                    data_in <= wr_data;
                elsif wr_reg = "100" then
                    wr_en_4 <= wr_en;
                    data_in <= wr_data;
                elsif wr_reg = "101" then
                    wr_en_5 <= wr_en;
                    data_in <= wr_data;
                elsif wr_reg = "110" then
                    wr_en_6 <= wr_en;
                    data_in <= wr_data;
                elsif wr_reg = "111" then
                    wr_en_7 <= wr_en;
                    data_in <= wr_data; 
                end if;
            end if;

            if read_reg1 = "000" then
                read_data1 <= data_out_0;
            elsif read_reg1 = "001" then
                read_data1 <= data_out_1;
            elsif read_reg1 = "010" then
                read_data1 <= data_out_2;
            elsif read_reg1 = "011" then
                read_data1 <= data_out_3;
            elsif read_reg1 = "100" then
                read_data1 <= data_out_4;
            elsif read_reg1 = "101" then
                read_data1 <= data_out_5;
            elsif read_reg1 = "110" then
                read_data1 <= data_out_6;
            elsif read_reg1 = "111" then
                read_data1 <= data_out_7;   
            end if;

            if read_reg1 = "000" then
                read_data2 <= data_out_0;
            elsif read_reg2 = "001" then
                read_data2 <= data_out_1;
            elsif read_reg2 = "010" then
                read_data2 <= data_out_2;
            elsif read_reg2 = "011" then
                read_data2 <= data_out_3;
            elsif read_reg2 = "100" then
                read_data2 <= data_out_4;
            elsif read_reg2 = "101" then
                read_data2 <= data_out_5;
            elsif read_reg2 = "110" then
                read_data2 <= data_out_6;
            elsif read_reg2 = "111" then
                read_data2 <= data_out_7;   
            end if;    
        end if;
    end process;
end architecture;


