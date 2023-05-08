instruction_map = {
    "nop": "00000000000000",
    "add": "0001",
    "sub": "0010",
    "equal": "0011",
    "greater": "0100",
    "mov": "0101",
    "movi": "0110",
    "jump": "1111000",
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
    inst = instruction.split(" ")[0]
    params = instruction.split(" ")[1].split(",") if inst != "nop" else []
    if inst == "nop":
        return instruction_map[inst]
    elif inst == "mov":
        instruction = (
            f"{instruction_map[inst]}{register_map[params[0]]}{register_map[params[1]]}"
        )
        return instruction + "0" * (14 - len(instruction))
    elif inst == "movi":
        const = str(bin(int(params[1]))).replace("b", "")
        fullConst = "0" * (7 - len(const)) + const
        instruction = f"{instruction_map[inst]}{register_map[params[0]]}{fullConst}"
        return instruction
    elif inst == "jump":
        const = str(bin(int(params[0]))).replace("b", "")
        fullConst = "0" * (7 - len(const)) + const
        return f"{instruction_map[inst]}{fullConst}"
    else:
        instruction = f"{instruction_map[inst]}{register_map[params[0]]}{register_map[params[1]]}{register_map[params[2]]}"
        return instruction + "0" * (14 - len(instruction))


instruction_set = None
with open("./instructions.txt", "r") as arquivo:
    instruction_set = arquivo.read()

index = 0
f = open("parsed_instructions.txt", "w")
for instruction in instruction_set.split("\n"):
    # print(instruction)
    f.write(f'{index} => "{parseInstruction(instruction)}",\n')
    # print(parseInstruction(instruction))
    index += 1
