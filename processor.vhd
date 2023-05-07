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
            result: out unsigned(15 downto 0);
            exceed: out std_logic
        );
    end component;

    component program_counter
        port(
            clk: in std_logic;
            rst: in std_logic;
            address_in: in unsigned(6 downto 0);
            address_out: out unsigned(6 downto 0)
        ); 
    end component;

    component if_id
        port(
            clk: in std_logic;
            instruction_in: in unsigned(13 downto 0);
            instruction_out: out unsigned(13 downto 0)
        ); 
    end component;

    component id_ex
        port(
            clk: in std_logic;
            read_data_1_in: in unsigned(15 downto 0);
            read_data_2_in: in unsigned(15 downto 0);
            wr_reg_in: in unsigned(2 downto 0);
            immediate_in: in unsigned(15 downto 0);
            alu_src_in: in std_logic;
            reg_write_in: in std_logic;
            opcode_in: in unsigned(3 downto 0);
            read_data_1_out: out unsigned(15 downto 0);
            read_data_2_out: out unsigned(15 downto 0);
            wr_reg_out: out unsigned(2 downto 0);
            immediate_out: out unsigned(15 downto 0);
            alu_src_out: out std_logic;
            opcode_out: out unsigned(3 downto 0);
            reg_write_out: out std_logic
        );
    end component;

    component pc_adder
        port(
            current_address: in unsigned(6 downto 0);
            next_address: out unsigned(6 downto 0)
        ); 
    end component;

    component rom
    port(         
        address: in unsigned(6 downto 0);         
        data: out unsigned(13 downto 0)
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

    signal reg_write, jump_en, alu_src, alu_src_id_ex_in, alu_src_id_ex_out, reg_write_id_ex_out: std_logic;
    signal alu_exceed: std_logic;
    signal mux_alu_src_b: unsigned(15 downto 0);
    signal wr_data_signal: unsigned(15 downto 0);
    signal pc_address_in : unsigned(6 downto 0) := "0000000";
    signal pc_address_out, pc_adder_next_address: unsigned(6 downto 0);
    signal jump_address: unsigned(6 downto 0) := "0000000";
    signal sel_op_in_ex_in, sel_op_id_ex_out, opcode: unsigned(3 downto 0) := "0000";
    signal rom_data, instruction: unsigned(13 downto 0);
    signal sign_extend: unsigned(8 downto 0);
    signal reg1, reg2, reg3, wr_reg_id_ex_out: unsigned(2 downto 0);
    signal read_data_1_id_ex_in, read_data_2_id_ex_in, immediate_id_ex_in: unsigned(15 downto 0);
    signal read_data_1_id_ex_out, read_data_2_id_ex_out, immediate_id_ex_out: unsigned(15 downto 0);

begin
    -- IF STAGE ======================================================================================
    -- COMPONENTS
    pc_instance: program_counter port map(
        clk => clk, 
        rst => rst, 
        address_in => pc_address_in, 
        address_out => pc_address_out
    );

    pc_adder_instance: pc_adder port map(
        current_address => pc_address_out, 
        next_address => pc_adder_next_address
    );

    if_id_instance: if_id port map(
        clk => clk, 
        instruction_in => rom_data, 
        instruction_out => instruction
    );

    -- LOGIC
    pc_address_in <= jump_address when jump_en = '1' else pc_adder_next_address;

    -- ID STAGE ======================================================================================
    -- COMPONENTS 
    rom_instance: rom port map(
        address => pc_address_out, 
        data => rom_data
    );

    control_unit_instance: control_unit port map(
        opcode => opcode, 
        reg_write => reg_write, 
        alu_src => alu_src, 
        jump_en => jump_en
    ); 

    regbank: register_bank port map(
        clk => clk, 
        rst => rst, 
        wr_en => reg_write_id_ex_out, 
        read_reg1 => reg2, 
        read_reg2 => reg3, 
        wr_data=> wr_data_signal, 
        wr_reg => wr_reg_id_ex_out, 
        read_data1 => read_data_1_id_ex_in, 
        read_data2 => read_data_2_id_ex_in 
    );

    id_ex_instance: id_ex port map(
        clk => clk, 
        read_data_1_in => read_data_1_id_ex_in, 
        read_data_2_in => read_data_2_id_ex_in, 
        wr_reg_in => reg1, 
        immediate_in => immediate_id_ex_in,
        alu_src_in => alu_src_id_ex_in,
        opcode_in => sel_op_in_ex_in,
        reg_write_in => reg_write,
        read_data_1_out => read_data_1_id_ex_out, 
        read_data_2_out => read_data_2_id_ex_out, 
        wr_reg_out => wr_reg_id_ex_out, 
        immediate_out => immediate_id_ex_out,
        alu_src_out => alu_src_id_ex_out,
        opcode_out => sel_op_id_ex_out,
        reg_write_out => reg_write_id_ex_out
    );

    -- LOGIC
    reg1 <= instruction(9 downto 7);
    reg2 <= instruction(6 downto 4);  
    reg3 <= instruction(3 downto 1);
    opcode <= instruction(13 downto 10);
    sel_op_in_ex_in <=instruction(13 downto 10);
    jump_address <= instruction(6 downto 0);
    alu_src_id_ex_in <= alu_src;
    sign_extend <= "000000000" when instruction(6) = '0' else "111111111";
    immediate_id_ex_in <= sign_extend & instruction(6 downto 0);

    -- EX STAGE =====================================================================================
    -- COMPONENTS
    ula_instance: ula port map(
        a => read_data_1_id_ex_out, 
        b => mux_alu_src_b, 
        sel_op => sel_op_id_ex_out, 
        result => wr_data_signal, 
        exceed =>alu_exceed
    );

    -- LOGIC    
    alu_out <= wr_data_signal;
    mux_alu_src_b <= immediate_id_ex_out when alu_src_id_ex_out='1' else read_data_2_id_ex_out; 
end architecture;


