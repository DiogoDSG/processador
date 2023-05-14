
## OPCODES 
| OPCODE   |      FN       |
|----------|:-------------:|
|   0000   |      nop      |
|   0001   |      sum      |
|   0010   |      sub      |
|   0101   |      mov      |
|   1110   |      blt      |
|   1111   |      jmp      |

## TYPE 1
# Structure  
[(opcode)(reg_dst)(reg_op)(000)(id)]
opcode - 4 bits
reg_dst - 3 bits
reg_op - 3 bits
id - 1 bit (0)

# Instructions
mov $2, $4

# TYPE 2  
# Structure  
[(opcode)(reg_dst)(immediate)(id)]
opcode - 4 bits
reg_dst - 3 bits
immediate - 6 bits
id - 1 bit (1)

# Instructions
mov $1, 2


# TYPE 3   
# Structure  
[(opcode)(reg_op)(000000)(id)]
opcode - 4 bits
reg_op - 3 bits
id - 1 bit (0)

# Instructions
add $3
sub $2

# TYPE 4
# Structure  
[(opcode)(000)(immediate)(id)]
opcode - 4 bits
immediate - 6 bits
id - 1 bit (1)

# Instructions
add 7
sub 8

# TYPE 5
# Structure  
[(opcode)(000)(immediate)]
opcode - 4 bits
immediate - 7 bits

# Instructions
blt 15
jmp 0

