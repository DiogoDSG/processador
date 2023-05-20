library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port (
        clk: in std_logic;
        rst: in std_logic
    );
end entity;

architecture a_processor of processor is

    -- IF STAGE ======================================================================================
    component program_counter
        port(
            clk: in std_logic;
            rst: in std_logic;
            address_in: in unsigned(6 downto 0);
            address_out: out unsigned(6 downto 0)
        ); 
    end component;

    component pc_adder
        port(
            current_address: in unsigned(6 downto 0);
            next_address: out unsigned(6 downto 0)
        ); 
    end component;


    component if_id
        port(
            clk: in std_logic;
            rst: in std_logic;
            instruction_in: in unsigned(13 downto 0);
            instruction_out: out unsigned(13 downto 0)
        ); 
    end component;

    component rom
    port(         
        address: in unsigned(6 downto 0);         
        data: out unsigned(13 downto 0)
    ); 
    end component;

    signal pc_address_out, pc_adder_next_address: unsigned(6 downto 0);
    signal current_address: unsigned(6 downto 0) := "0000000";
    signal rom_data, instruction: unsigned(13 downto 0);

    -- ID STAGE ======================================================================================
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

    component id_ex
        port(
            clk: in std_logic;
            rst: in std_logic;
            read_data_1_in: in unsigned(15 downto 0);
            read_data_2_in: in unsigned(15 downto 0);
            wr_reg_in: in unsigned(2 downto 0);
            immediate_in: in unsigned(15 downto 0);
            alu_src_in: in std_logic;
            reg_write_in: in std_logic;
            ram_address_in: in unsigned(6 downto 0);
            opcode_in: in unsigned(3 downto 0);
            mem_write_in: in std_logic;
            mem_to_reg_in: in std_logic;
            reg_op1_in: in unsigned(2 downto 0);
            reg_op2_in: in unsigned(2 downto 0);
            read_data_1_out: out unsigned(15 downto 0);
            read_data_2_out: out unsigned(15 downto 0);
            wr_reg_out: out unsigned(2 downto 0);
            immediate_out: out unsigned(15 downto 0);
            alu_src_out: out std_logic;
            opcode_out: out unsigned(3 downto 0);
            reg_write_out: out std_logic;
            mem_write_out: out std_logic;
            mem_to_reg_out: out std_logic;
            reg_op1_out: out unsigned(2 downto 0);
            reg_op2_out: out unsigned(2 downto 0);
            ram_address_out: out unsigned(6 downto 0)
        );
    end component;

    component control_unit
        port(
            overflow: in std_logic;
            negative: in std_logic;
            zero: in std_logic;
            opcode: in unsigned(3 downto 0);
            immediate_id: in std_logic;
            jump_en: out std_logic;
            reg_write: out std_logic;
            alu_src: out std_logic;
            mem_write: out std_logic;
            mem_to_reg: out std_logic
        );
    end component;

    signal immediate_id, jump_en, alu_src, alu_src_id_ex_in,reg_write,mem_write,mem_to_reg: std_logic;
    signal sel_op_in_ex_in, opcode: unsigned(3 downto 0) := "0000";
    signal reg_dst, reg_op1, reg_op2: unsigned(2 downto 0);
    signal sign_extend: unsigned(9 downto 0);
    signal jump_address, ram_address_id_ex_in: unsigned(6 downto 0) := "0000000";
    signal read_data_1_id_ex_in, read_data_2_id_ex_in, immediate_id_ex_in: unsigned(15 downto 0);

    -- EX STAGE ======================================================================================
    component alu
        port (
            a,b:    in unsigned(15 downto 0);
            sel_op: in unsigned(3 downto 0);
            result: out unsigned(15 downto 0);
            overflow: out std_logic;
            negative: out std_logic;
            zero: out std_logic       
            );
    end component;

    component forwarding_unit
        port(
            alu_src: in std_logic;
            mem_wb_reg_write: in std_logic;
            ex_mem_reg_write: in std_logic;
            reg_op1: in unsigned(2 downto 0);
            reg_op2: in unsigned(2 downto 0);
            ex_mem_reg_dst: in unsigned(2 downto 0);
            mem_wb_reg_dst: in unsigned(2 downto 0);
            reg_op1_fw_en: out unsigned (1 downto 0);
            reg_op2_fw_en: out unsigned (1 downto 0)
        );
    end component;

    component ex_mem
        port(
            clk: in std_logic;
            rst: in std_logic;
            mem_write_in: in std_logic;
            alu_result_in: in unsigned(15 downto 0);
            address_in: in unsigned(6 downto 0);
            reg_write_in: in std_logic;
            mem_to_reg_in: in std_logic;
            reg_dst_in: in unsigned(2 downto 0);
            write_data_in: in unsigned(15 downto 0);
            mem_write_out: out std_logic;
            alu_result_out: out unsigned(15 downto 0);
            write_data_out: out unsigned(15 downto 0);
            address_out: out unsigned(6 downto 0);
            reg_write_out: out std_logic;
            mem_to_reg_out: out std_logic;
            reg_dst_out: out unsigned(2 downto 0)
        );
    end component;

    signal overflow,negative,zero,alu_src_id_ex_out,mem_to_reg_id_ex_out,mem_write_id_ex_out, reg_write_id_ex_out: std_logic;
    signal read_data_1_id_ex_out, read_data_2_id_ex_out, immediate_id_ex_out, mux_alu_a, mux_alu_b, alu_result, mux_alu_src_b, mux_alu_ram: unsigned(15 downto 0);
    signal sel_op_id_ex_out: unsigned(3 downto 0) := "0000";
    signal reg_op1_id_ex_out, reg_op2_id_ex_out,reg_dst_id_ex_out: unsigned(2 downto 0);
    signal reg_op1_fw_en, reg_op2_fw_en: unsigned(1 downto 0);
    signal ram_address_id_ex_out: unsigned(6 downto 0);

    -- MEM STAGE ======================================================================================

    component ram
    port(         
        clk : in std_logic;
        address : in unsigned(6 downto 0);
        wr_en : in std_logic;
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    ); 
    end component;

    component mem_wb
        port(
            clk: in std_logic;
            rst: in std_logic;
            mem_to_reg_in: in std_logic;
            reg_write_in: in std_logic;
            reg_dst_in: in unsigned(2 downto 0);
            ram_data_in: in unsigned(15 downto 0);
            alu_result_in: in unsigned(15 downto 0);
            mem_to_reg_out: out std_logic;
            reg_write_out: out std_logic;
            reg_dst_out: out unsigned(2 downto 0);
            ram_data_out: out unsigned(15 downto 0);
            alu_result_out: out unsigned(15 downto 0)
        );
    end component;

    signal reg_write_ex_mem_out, mem_write_ex_mem_out,mem_to_reg_ex_mem_out: std_logic;
    signal reg_dst_ex_mem_out: unsigned(2 downto 0);
    signal address_ex_mem_out: unsigned(6 downto 0);
    signal alu_result_ex_mem_out, write_data_ex_mem_out,ram_data_out: unsigned(15 downto 0);

    -- WB STAGE ======================================================================================
    signal reg_write_mem_wb_out, mem_to_reg_mem_wb_out: std_logic;
    signal wr_data_mem_wb_out,ram_data_mem_wb_out, alu_result_mem_wb_out: unsigned(15 downto 0);
    signal reg_dst_mem_wb_out: unsigned(2 downto 0);

begin
    -- IF STAGE ======================================================================================
    pc_instance: program_counter port map(
        clk => clk, 
        rst => rst, 
        address_in => pc_adder_next_address, 
        address_out => pc_address_out
    );

    pc_adder_instance: pc_adder port map(
        current_address => current_address, 
        next_address => pc_adder_next_address
    );

    if_id_instance: if_id port map(
        rst => rst,
        clk => clk, 
        instruction_in => rom_data, 
        instruction_out => instruction
    );

    rom_instance: rom port map(
        address => current_address, 
        data => rom_data
    );

    current_address <= jump_address when jump_en = '1' else pc_address_out;

    -- ID STAGE ======================================================================================
    control_unit_instance: control_unit port map(
        overflow => overflow,
        negative => negative,
        zero => zero,
        immediate_id => immediate_id,
        opcode => opcode, 
        reg_write => reg_write, 
        alu_src => alu_src, 
        jump_en => jump_en,
        mem_write => mem_write,
        mem_to_reg => mem_to_reg
    ); 

    regbank: register_bank port map(
        clk => clk, 
        rst => rst, 
        wr_en => reg_write_mem_wb_out, 
        read_reg1 => reg_op1, 
        read_reg2 => reg_op2, 
        wr_data=> wr_data_mem_wb_out, 
        wr_reg => reg_dst_mem_wb_out, 
        read_data1 => read_data_1_id_ex_in, 
        read_data2 => read_data_2_id_ex_in 
    );

    id_ex_instance: id_ex port map(
        clk => clk, 
        rst => rst,
        read_data_1_in => read_data_1_id_ex_in, 
        read_data_2_in => read_data_2_id_ex_in, 
        wr_reg_in => reg_dst, 
        immediate_in => immediate_id_ex_in,
        alu_src_in => alu_src_id_ex_in,
        opcode_in => sel_op_in_ex_in,
        reg_write_in => reg_write,
        mem_write_in => mem_write,
        mem_to_reg_in => mem_to_reg,
        mem_to_reg_out => mem_to_reg_id_ex_out,
        ram_address_in => ram_address_id_ex_in,
        ram_address_out => ram_address_id_ex_out,
        read_data_1_out => read_data_1_id_ex_out, 
        read_data_2_out => read_data_2_id_ex_out, 
        wr_reg_out => reg_dst_id_ex_out, 
        immediate_out => immediate_id_ex_out,
        alu_src_out => alu_src_id_ex_out,
        opcode_out => sel_op_id_ex_out,
        mem_write_out => mem_write_id_ex_out,
        reg_write_out => reg_write_id_ex_out,
        reg_op1_in => reg_op1,
        reg_op2_in => reg_op2,
        reg_op1_out => reg_op1_id_ex_out,
        reg_op2_out => reg_op2_id_ex_out
    );

    opcode <= instruction(13 downto 10);
    reg_dst <= instruction(9 downto 7) when opcode = "0101" else "000" when opcode="0000" else "111";
    reg_op2 <= instruction(9 downto 7) when opcode = "0001" or opcode= "0010" or opcode = "0011" or opcode = "0100" else "000" when opcode="0000" else instruction (6 downto 4);
      
    reg_op1 <= "000" when opcode="0101" or opcode="0000" else "111";
    sel_op_in_ex_in <= instruction(13 downto 10);
    jump_address <= instruction(6 downto 0);
    alu_src_id_ex_in <= alu_src;
    sign_extend <= "0000000000" when instruction(6) = '0' else "1111111111";
    immediate_id_ex_in <= sign_extend & instruction(6 downto 1);
    immediate_id <= instruction(0);
    ram_address_id_ex_in <= instruction(6 downto 0);

    -- EX STAGE =====================================================================================
    alu_instance: alu port map(
        a => mux_alu_a, 
        b => mux_alu_b, 
        sel_op => sel_op_id_ex_out, 
        result => alu_result, 
        overflow => overflow,
        negative => negative,
        zero => zero
    );

    forwarding_unit_instance: forwarding_unit port map(
        reg_op1 => reg_op1_id_ex_out,
        reg_op2 => reg_op2_id_ex_out,
        alu_src => alu_src_id_ex_out,
        mem_wb_reg_write => reg_write_mem_wb_out,
        ex_mem_reg_write => reg_write_ex_mem_out,
        ex_mem_reg_dst => reg_dst_ex_mem_out,
        mem_wb_reg_dst => reg_dst_mem_wb_out,
        reg_op1_fw_en => reg_op1_fw_en,
        reg_op2_fw_en => reg_op2_fw_en
    );
    
    ex_mem_instance: ex_mem port map(
        clk => clk,
        rst => rst,
        alu_result_in => alu_result,
        alu_result_out => alu_result_ex_mem_out,
        write_data_in => alu_result,
        write_data_out => write_data_ex_mem_out,
        mem_write_in => mem_write_id_ex_out,
        mem_write_out => mem_write_ex_mem_out,
        address_in => ram_address_id_ex_out,
        address_out => address_ex_mem_out,
        reg_write_in => reg_write_id_ex_out,
        mem_to_reg_in => mem_to_reg_id_ex_out,
        reg_dst_in => reg_dst_id_ex_out,
        reg_write_out => reg_write_ex_mem_out,
        mem_to_reg_out => mem_to_reg_ex_mem_out,
        reg_dst_out => reg_dst_ex_mem_out
    );

    mux_alu_src_b <= immediate_id_ex_out when alu_src_id_ex_out='1' else read_data_2_id_ex_out; 
    mux_alu_a <= read_data_1_id_ex_out when reg_op1_fw_en = "00" else mux_alu_ram when reg_op1_fw_en = "01" else wr_data_mem_wb_out;
    mux_alu_b <= mux_alu_src_b when reg_op2_fw_en = "00" else mux_alu_ram when reg_op2_fw_en = "01" else wr_data_mem_wb_out;
    mux_alu_ram <= ram_data_out when mem_to_reg_ex_mem_out='1' else alu_result_ex_mem_out;

    -- MEM STAGE ==================================================================================
    ram_instance: ram port map(
        clk => clk,
        address => address_ex_mem_out,
        wr_en => mem_write_ex_mem_out,
        data_in => write_data_ex_mem_out,
        data_out => ram_data_out
    );

    mem_wb_instance: mem_wb port map(
        clk => clk,
        rst => rst,
        ram_data_in => ram_data_out,
        alu_result_in => alu_result_ex_mem_out,
        reg_write_in => reg_write_ex_mem_out,
        mem_to_reg_in => mem_to_reg_ex_mem_out,
        reg_dst_in => reg_dst_ex_mem_out,
        ram_data_out => ram_data_mem_wb_out,
        alu_result_out => alu_result_mem_wb_out,
        reg_write_out => reg_write_mem_wb_out,
        mem_to_reg_out => mem_to_reg_mem_wb_out,
        reg_dst_out => reg_dst_mem_wb_out
    );
    
    wr_data_mem_wb_out <= ram_data_mem_wb_out when mem_to_reg_mem_wb_out='1' else alu_result_mem_wb_out;
end architecture;


