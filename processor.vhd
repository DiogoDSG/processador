library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port (
        clk: in std_logic;
        rst: in std_logic;
        alu_out: out unsigned(15 downto 0)
    );
end entity;

architecture a_processor of processor is
    component register_bank
        port(
            clk: in std_logic;
            rst: in std_logic;
            read_reg1: in unsigned(2 downto 0);
            read_reg2: in unsigned(2 downto 0);
            wr_en: in std_logic;
            state: in unsigned(2 downto 0);
            wr_data: in unsigned(15 downto 0);
            wr_reg: in unsigned(2 downto 0);
            read_data1: out unsigned(15 downto 0);
            read_data2: out unsigned(15 downto 0)
        ); 
    end component;

    component ula
        port (
            a,b:    in unsigned(15 downto 0);
            sel_op: in unsigned(3 downto 0);
            state: in unsigned(2 downto 0);
            result: out unsigned(15 downto 0);
            exceed: out std_logic
        );
    end component;

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
            current_state: out unsigned(2 downto 0)
        ); 
    end component;

    component control_unit
        port(
            opcode: in unsigned(3 downto 0);
            jump_en: out std_logic;
            reg_write: out std_logic;
            alu_src: out std_logic
        );
    end component;

    component pc_adder
        port(
            state: unsigned (2 downto 0);
            current_address: in unsigned(6 downto 0);
            next_address: out unsigned(6 downto 0)
        );
    end component;

    -- control
    signal pc_wr_en: std_logic := '1';
    signal jump_en, alu_src: std_logic := '0';
    signal reg_write, rst_state_machine: std_logic;

    -- ula
    signal alu_exceed: std_logic;
    signal alu_a, alu_b, mux_alu: unsigned(15 downto 0);

    signal wr_data_signal: unsigned(15 downto 0);
    signal pc_address_in : unsigned(6 downto 0) := "0000000";
    signal pc_address_out: unsigned(6 downto 0);
    signal state: unsigned(2 downto 0) := "000";
    signal jump_address: unsigned(6 downto 0) := "0000000";
    signal opcode: unsigned(3 downto 0) := "0000";
    signal rom_data: unsigned(13 downto 0) := "00000000000000";
    signal pc_adder_next_address: unsigned(6 downto 0);
    signal const: unsigned(8 downto 0);
    signal reg1, reg2, reg3: unsigned(2 downto 0);

begin
    reg1 <= rom_data(9 downto 7);
    reg2 <= rom_data(6 downto 4);  
    reg3 <= rom_data(3 downto 1);
    opcode <= rom_data(13 downto 10);

    state_machine_instance: state_machine port map(clk => clk, rst => rst_state_machine, current_state => state);

    pc_instance: program_counter port map(clk => clk, wr_en => pc_wr_en, rst => rst, address_in => pc_address_in, address_out => pc_address_out);

    rom_instance: rom port map(clk => clk, address => pc_address_out, data => rom_data);

    control_unit_instance: control_unit port map(opcode => opcode, reg_write => reg_write, alu_src => alu_src, jump_en => jump_en); 

    regbank: register_bank port map(clk => clk, rst => rst, wr_en => reg_write, read_reg1 => reg1, read_reg2 => reg2, wr_data=> wr_data_signal, state => state, wr_reg => reg3, read_data1 => alu_a, read_data2 => alu_b );

    pc_adder_instance: pc_adder port map(state => state, current_address => pc_address_out, next_address => pc_adder_next_address);

    ula_instance: ula port map(a => alu_a, b => mux_alu, sel_op => opcode, state => state, result => wr_data_signal, exceed =>alu_exceed);

    -- data <= rom_data;

    jump_address <= rom_data(6 downto 0);
    
    pc_address_in <= jump_address when jump_en = '1' else pc_adder_next_address;
    rst_state_machine <= '1' when jump_en='1' else '0';
    -- current_state <= state;
    const <= "000000000" when rom_data(6) = '0' else "111111111";
    
    mux_alu <= const & rom_data(6 downto 0) when alu_src='1' else alu_b;
    alu_out <= wr_data_signal;
end architecture;


