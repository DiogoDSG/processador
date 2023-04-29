library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(
        clk: in std_logic;
        rst: in std_logic;
        data: out unsigned(13 downto 0);
        current_state: out std_logic
    );
end entity;

architecture a_control_unit of control_unit is
    component program_counter
        port(
            clk: in std_logic;
            wr_en: in std_logic;
            rst: in std_logic;
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
            current_state: out std_logic
        ); 
    end component;

    signal pc_address_in : unsigned(6 downto 0) := "0000000";
    signal pc_address_out: unsigned(6 downto 0);
    signal state: std_logic := '0';
    signal wr_en: std_logic := '0';
    -- signal jump_en: std_logic := '0';
    -- signal jump_address: unsigned(6 downto 0) := "0000000";
    -- signal opcode: unsigned(3 downto 0) := "0000";
    -- signal rom_data: unsigned(13 downto 0) := "00000000000000";
begin
    pc_instance: program_counter port map(clk => clk, wr_en => wr_en, rst => rst, address_in => pc_address_in, address_out => pc_address_out);

    state_machine_instance: state_machine port map(clk => clk, rst => rst, current_state => state);

    rom_instance: rom port map(clk => clk, address => pc_address_out, data => data);

    -- data <= rom_data;
    wr_en <= '1' when state = '1' else '0';
    -- opcode <= rom_data(13 downto 10);
    -- jump_en <= '1' when opcode = "1111" else '0';
    -- jump_address <= rom_data(6 downto 0);
    pc_address_in <= pc_address_out + 1 when state = '1' else pc_address_out + 0;
    current_state <= state;                
end architecture;


