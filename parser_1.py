import os
import re

instruction_map = {
    "nop": "00000000000000",
    "add": "0001",
    "sub": "0010",
    "cmp": "0011",
    "mul": "0100",
    "mov": "0101",
    "lda": "0110000",
    "sta": "0111000",
    "bmi": "1001000",
    "bpl": "1010000",
    "bne": "1011000",
    "beq": "1100000",
    "bgt": "1101000",
    "blt": "1110000",
    "jmp": "1111000",
}

register_map = {
    "zero": "000",
    "$0": "000",
    "$1": "001",
    "$2": "010",
    "$3": "011",
    "$4": "100",
    "$5": "101",
    "$6": "110",
    "$7": "111",
    "$acc": "111",
}


def int_to_twos_complement_string(num, num_bits):
    num = int(num)
    if num < 0:
        num = (1 << num_bits) + num

    binary_string = bin(num)[2 if num >= 0 else 3 :]
    binary_string = binary_string.zfill(num_bits)

    return binary_string


def parseInstruction(instruction):
    instruction = re.sub(" +", " ", instruction).strip()
    if not instruction:
        return
    inst = instruction.split(" ")[0]
    params = instruction.replace(inst, "").strip().split(",") if inst != "nop" else []
    params = [param.strip() for param in params]
    if inst == "nop":
        return instruction_map[inst]
    elif inst == "mov":
        if "$" not in params[1]:
            fullConst = int_to_twos_complement_string(params[1], 6)
            instruction = (
                f"{instruction_map[inst]}{register_map[params[0]]}{fullConst}1"
            )
        else:
            instruction = f"{instruction_map[inst]}{register_map[params[0]]}{register_map[params[1]]}"
            instruction += "0" * (14 - len(instruction))

        return instruction

    elif inst in ["jmp", "blt", "lda", "sta", "beq", "bne", "bgt", "bpl", "bmi"]:
        print(params)
        const = str(bin(int(params[0]))).replace("b", "")
        fullConst = "0" * (7 - len(const)) + const
        return f"{instruction_map[inst]}{fullConst}"
    else:
        if "$" not in params[0]:
            fullConst = int_to_twos_complement_string(params[0], 6)
            instruction = f"{instruction_map[inst]}000{fullConst}1"
        else:
            instruction = f"{instruction_map[inst]}{register_map[params[0]]}"
            instruction += "0" * (14 - len(instruction))

        return instruction


instruction_set = None
with open("./instructions.asm", "r") as arquivo:
    instruction_set = arquivo.read()

index = 0
os.remove("instruction_fetch/rom.vhd")
f = open("instruction_fetch/rom.vhd", "w")
instructions = ""
cleaned_instructions = []
labels = {}
instruction_set = [
    instruction for instruction in instruction_set.split("\n") if instruction
]
counter = 0
for i, instruction in enumerate(instruction_set):
    if not instruction:
        continue
    if ":" in instruction:
        parts = instruction.split(":")
        label = parts[0].strip()
        labels[label] = i - counter
        if len(parts) > 1 and parts[1].strip():
            cleaned_instructions.append(parts[1].strip())
        else:
            counter += 1

    else:
        cleaned_instructions.append(instruction)

label_list = list(labels.keys())
for instruction in cleaned_instructions:
    if not instruction:
        continue
    for label in label_list:
        instruction = instruction.replace(label, str(labels[label]))
    print(instruction)
    print(f'{index} => "{parseInstruction(instruction)}",\n\t')
    instructions += f'{index} => "{parseInstruction(instruction)}",\n\t'
    index += 1

f.write(
    f"""
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
entity rom is   
    port(         
    address: in unsigned(6 downto 0);         
    data: out unsigned(13 downto 0)); 
end entity; 
architecture a_rom of rom is type mem is array (0 to 127) of unsigned(13 downto 0);   
constant rom_content : mem := (
    {instructions}
    others => (others=>'0'));    
    begin
    data <= rom_content(to_integer(address));      
 
end architecture;
"""
)
