import os

instruction_map = {
    "nop": "00000000000000",
    "add": "0001",
    "sub": "0010",
    "mov": "0101",
    "jmp": "1111000",
    "blt": "1110000",
    "lda": "0110000",
    "sta": "0111000",
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


def parseInstruction(instruction):
    if not instruction:
        return
    inst = instruction.split(" ")[0]
    params = instruction.split(" ")[1].split(",") if inst != "nop" else []

    if inst == "nop":
        return instruction_map[inst]
    elif inst == "mov":
        if "$" not in params[1]:
            const = str(bin(int(params[1]))).replace("b", "")
            fullConst = "0" * (6 - len(const)) + const
            instruction = (
                f"{instruction_map[inst]}{register_map[params[0]]}{fullConst}1"
            )
        else:
            instruction = f"{instruction_map[inst]}{register_map[params[0]]}{register_map[params[1]]}"
            instruction += "0" * (14 - len(instruction))

        return instruction

    elif inst == "jmp" or inst == "blt" or inst == "lda" or inst == "sta":
        const = str(bin(int(params[0]))).replace("b", "")
        fullConst = "0" * (7 - len(const)) + const
        return f"{instruction_map[inst]}{fullConst}"
    else:
        if "$" not in params[0]:
            const = str(bin(int(params[0]))).replace("b", "")
            fullConst = "0" * (6 - len(const)) + const
            instruction = f"{instruction_map[inst]}000{fullConst}1"
        else:
            instruction = f"{instruction_map[inst]}{register_map[params[0]]}"
            instruction += "0" * (14 - len(instruction))

        return instruction


instruction_set = None
with open("./instructions.asm", "r") as arquivo:
    instruction_set = arquivo.read()

index = 0
os.remove("rom.vhd")
f = open("rom.vhd", "w")
instructions = ""
for instruction in instruction_set.split("\n"):
    # print(instruction)

    instructions += f'{index} => "{parseInstruction(instruction)}",\n\t'
    # print(parseInstruction(instruction))
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
