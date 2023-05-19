python parser_1.py

ghdl -a reg16bits.vhd && ghdl -e reg16bits && ghdl -a reg16bits_tb.vhd && ghdl -e reg16bits_tb && ghdl -r reg16bits_tb --wave=reg16bits_tb.ghw

ghdl -a rom.vhd && ghdl -e rom && ghdl -a rom_tb.vhd && ghdl -e rom_tb && ghdl -r rom_tb --wave=rom_tb.ghw

ghdl -a program_counter.vhd && ghdl -e program_counter && ghdl -a program_counter_tb.vhd && ghdl -e program_counter_tb && ghdl -r program_counter_tb --wave=program_counter_tb.ghw

ghdl -a pc_adder.vhd && ghdl -e pc_adder

ghdl -a control_unit.vhd && ghdl -e control_unit && ghdl -a control_unit_tb.vhd && ghdl -e control_unit_tb && ghdl -r control_unit_tb --wave=control_unit_tb.ghw

ghdl -a mem_wb.vhd && ghdl -e mem_wb && ghdl -a mem_wb_tb.vhd && ghdl -e mem_wb_tb && ghdl -r mem_wb_tb --wave=mem_wb_tb.ghw

ghdl -a alu.vhd && ghdl -e alu && ghdl -a alu_tb.vhd && ghdl -e alu_tb && ghdl -r alu_tb --wave=alu_tb.ghw

ghdl -a register_bank.vhd && ghdl -e register_bank && ghdl -a register_bank_tb.vhd && ghdl -e register_bank_tb && ghdl -r register_bank_tb --wave=register_bank_tb.ghw

ghdl -a if_id.vhd && ghdl -e if_id  && ghdl -a if_id_tb.vhd && ghdl -e if_id_tb && ghdl -r if_id_tb --wave=if_id_tb.

ghdl -a id_ex.vhd && ghdl -e id_ex  && ghdl -a id_ex_tb.vhd && ghdl -e id_ex_tb && ghdl -r id_ex_tb --wave=id_ex_tb.ghw

ghdl -a ram.vhd && ghdl -e ram && ghdl -a ram_tb.vhd && ghdl -e ram_tb && ghdl -r ram_tb --wave=ram_tb.ghw

ghdl -a ex_mem.vhd && ghdl -e ex_mem && ghdl -a ex_mem_tb.vhd && ghdl -e ex_mem_tb && ghdl -r ex_mem_tb --wave=ex_mem_tb.ghw

ghdl -a forwarding_unit.vhd && ghdl -e forwarding_unit 

ghdl -a processor.vhd && ghdl -e processor  && ghdl -a processor_tb.vhd && ghdl -e processor_tb && ghdl -r processor_tb --wave=processor_tb.ghw