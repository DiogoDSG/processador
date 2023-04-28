entity program_counter is 
    port(
        clk: in std_logic;
        wr_en: in std_logic;
        address_in: in unsigned(13 downto 0)
    );
end entity;