library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port (
        clk: in std_logic;
        rst: in std_logic;
        wr_en: in std_logic;
        alu_src: in std_logic;
        reg1: in unsigned(2 downto 0);
        reg2: in unsigned(2 downto 0);
        ext_constant: in unsigned(15 downto 0);
        wr_reg: in unsigned(2 downto 0);
        sel_op: in unsigned(2 downto 0);
        alu_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_top_level of top_level is
    component register_bank
        port(
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
    end component;

    component ula
        port (
            a,b:    in unsigned(15 downto 0);
            sel_op: in unsigned(2 downto 0);
            result: out unsigned(15 downto 0);
            exceed: out std_logic
        );
    end component;

    signal alu_exceed: std_logic;
    signal alu_a, alu_b, mux_alu: unsigned(15 downto 0);
    signal wr_data_signal: unsigned(15 downto 0);

begin
    regbank: register_bank port map(clk => clk, rst => rst, wr_en => wr_en, read_reg1 => reg1, read_reg2 => reg2, wr_data=> wr_data_signal, wr_reg => wr_reg, read_data1 => alu_a, read_data2 => alu_b );
    
    ula_instance: ula port map(a => alu_a, b => mux_alu, sel_op => sel_op, result => wr_data_signal, exceed =>alu_exceed);


    process(clk, rst, wr_en)
    begin   
        if rising_edge(clk) then
            if alu_src = '1' then
                mux_alu <= ext_constant;
            elsif alu_src = '0' then
                mux_alu <= alu_b;
            end if;
            alu_out <= wr_data_signal;
        end if;
    end process;
end architecture;


