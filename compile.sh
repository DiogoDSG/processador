ghdl -a reg16bits.vhd && ghdl -e reg16bits && ghdl -a reg16bits_tb.vhd && ghdl -e reg16bits_tb && ghdl -r reg16bits_tb --wave=reg16bits_tb.ghw

ghdl -a rom.vhd && ghdl -e rom && ghdl -a rom_tb.vhd && ghdl -e rom_tb && ghdl -r rom_tb --wave=rom_tb.ghw

ghdl -a state_machine.vhd && ghdl -e state_machine && ghdl -a state_machine_tb.vhd && ghdl -e state_machine_tb && ghdl -r state_machine_tb --wave=state_machine_tb.ghw

ghdl -a program_counter.vhd && ghdl -e program_counter && ghdl -a program_counter_tb.vhd && ghdl -e program_counter_tb && ghdl -r program_counter_tb --wave=program_counter_tb.ghw

ghdl -a control_unit.vhd && ghdl -e control_unit && ghdl -a control_unit_tb.vhd && ghdl -e control_unit_tb && ghdl -r control_unit_tb --wave=control_unit_tb.ghw

ghdl -a ula.vhd && ghdl -e ula && ghdl -a ula_tb.vhd && ghdl -e ula_tb && ghdl -r ula_tb --wave=ula_tb.ghw

ghdl -a register_bank.vhd && ghdl -e register_bank

ghdl -a pc_adder.vhd && ghdl -e pc_adder

ghdl -a processor.vhd && ghdl -e processor  && ghdl -a processor_tb.vhd && ghdl -e processor_tb && ghdl -r processor_tb --wave=processor_tb.ghw