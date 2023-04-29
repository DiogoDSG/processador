library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(
        clk: in std_logic;
        rst: in std_logic;
        data: out unsigned(13 downto 0);
        current_state: out unsigned(0 downto 0)
    );
end entity;

architecture a_control_unit of control_unit is
    component program_counter
        port(
            clk: in std_logic;
            wr_en: in std_logic;
            address_in: in unsigned(6 downto 0);
            address_out: out unsigned(6 downto 0)
        ); 
    end component;

    component rom
    port(
        clk: in std_logic;         
        address: in unsigned(6 downto 0);         
        data: out unsigned(13 downto 0)
    ); 
    end component;

    component state_machine
        port(
            clk: in std_logic;
            rst: in std_logic;
            current_state: out unsigned(0 downto 0)
        ); 
    end component;

    signal pc_address_in : unsigned(6 downto 0) := "0000000";
    signal pc_address_out: unsigned(6 downto 0);
    signal pc_count: unsigned(6 downto 0) := "0000000";

    signal state: unsigned(0 downto 0);
    signal wr_en: std_logic;
    signal rom_clk: std_logic := '0';
begin
    pc_instance: program_counter port map(clk => clk, wr_en => wr_en, address_in => pc_address_in, address_out => pc_address_out);

    state_machine_instance: state_machine port map(clk => clk, rst => rst, current_state => state);

    rom_instance: rom port map(clk => rom_clk, address => pc_address_out, data => data);

    current_state <= state;
    pc_count <= pc_count + 1 when state = "1" else pc_count;
    wr_en <= '1' when state="1" else '0';
    rom_clk <= '1' when state= "0" else '0';
    pc_address_in <= pc_count;

end architecture;


