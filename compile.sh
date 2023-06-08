python parser_1.py

ghdl -a write_back/reg16bits.vhd && ghdl -e reg16bits && ghdl -a write_back/reg16bits_tb.vhd && ghdl -e reg16bits_tb && ghdl -r reg16bits_tb --wave=write_back/reg16bits_tb.ghw

ghdl -a instruction_fetch/rom.vhd && ghdl -e rom && ghdl -a instruction_fetch/rom_tb.vhd && ghdl -e rom_tb && ghdl -r rom_tb --wave=instruction_fetch/rom_tb.ghw

ghdl -a instruction_fetch/program_counter.vhd && ghdl -e program_counter && ghdl -a instruction_fetch/program_counter_tb.vhd && ghdl -e program_counter_tb && ghdl -r program_counter_tb --wave=instruction_fetch/program_counter_tb.ghw

ghdl -a instruction_fetch/pc_adder.vhd && ghdl -e pc_adder

ghdl -a instruction_decode/control_unit.vhd && ghdl -e control_unit && ghdl -a instruction_decode/control_unit_tb.vhd && ghdl -e control_unit_tb && ghdl -r control_unit_tb --wave=instruction_decode/control_unit_tb.ghw

ghdl -a memory/mem_wb.vhd && ghdl -e mem_wb && ghdl -a memory/mem_wb_tb.vhd && ghdl -e mem_wb_tb && ghdl -r mem_wb_tb --wave=memory/mem_wb_tb.ghw

ghdl -a execute/alu.vhd && ghdl -e alu && ghdl -a execute/alu_tb.vhd && ghdl -e alu_tb && ghdl -r alu_tb --wave=execute/alu_tb.ghw

ghdl -a execute/branch_control.vhd && ghdl -e branch_control && ghdl -a execute/branch_control_tb.vhd && ghdl -e branch_control_tb && ghdl -r branch_control_tb --wave=execute/branch_control_tb.ghw

ghdl -a write_back/register_bank.vhd && ghdl -e register_bank && ghdl -a write_back/register_bank_tb.vhd && ghdl -e register_bank_tb && ghdl -r register_bank_tb --wave=write_back/register_bank_tb.ghw

ghdl -a instruction_fetch/if_id.vhd && ghdl -e if_id  && ghdl -a instruction_fetch/if_id_tb.vhd && ghdl -e if_id_tb && ghdl -r if_id_tb --wave=instruction_fetch/if_id_tb.

ghdl -a instruction_decode/id_ex.vhd && ghdl -e id_ex  && ghdl -a instruction_decode/id_ex_tb.vhd && ghdl -e id_ex_tb && ghdl -r id_ex_tb --wave=instruction_decode/id_ex_tb.ghw

ghdl -a memory/ram.vhd && ghdl -e ram && ghdl -a memory/ram_tb.vhd && ghdl -e ram_tb && ghdl -r ram_tb --wave=memory/ram_tb.ghw

ghdl -a execute/ex_mem.vhd && ghdl -e ex_mem && ghdl -a execute/ex_mem_tb.vhd && ghdl -e ex_mem_tb && ghdl -r ex_mem_tb --wave=execute/ex_mem_tb.ghw

ghdl -a execute/forwarding_unit.vhd && ghdl -e forwarding_unit && ghdl -a execute/forwarding_unit_tb.vhd && ghdl -e forwarding_unit_tb && ghdl -r forwarding_unit_tb --wave=execute/forwarding_unit_tb.ghw

ghdl -a processor.vhd && ghdl -e processor  && ghdl -a processor_tb.vhd && ghdl -e processor_tb && ghdl -r processor_tb --wave=processor_tb.ghw