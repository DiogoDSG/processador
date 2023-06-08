
#### ***OPCODES*** 
| OPCODE   |      FN       |
|----------|:-------------:|
|   0000   |      nop      |
|   0001   |      sum      |
|   0010   |      sub      |
|   0011   |      cmp      |
|   0101   |      mov      |
|   0110   |      lda      |
|   0111   |      sta      |
|   1001   |      bmi      |
|   1010   |      bpl      |
|   1011   |      bne      |
|   1100   |      beq      |
|   1101   |      bgt      |
|   1110   |      blt      |
|   1111   |      jmp      |
___
#### ***Type 1 - two registers***
##### ***Structure***  
| opcode  | reg_dst  | reg_op   | void   | id |
|---|---|---|---|---|
| 4 bits  | 3 bits  | 3 bits   | 000   | 0 |

+ id must be 0 to indicate it uses register instead of immediate.


##### ***Instructions***
```assembly  
    mov $2, $4
```
___
#### ***Type 2 - one register and immediate***
##### ***Structure***  
| opcode  | reg_dst  | immediate    | id |
|---|---|---|---|
| 4 bits  | 3 bits  | 6 bits      | 0 |

+ id must be 1 to indicate it uses immediate.

##### ***Instructions*** 
```assembly
    mov $1, 2
```
___
#### ***Type 3 - one register***
##### ***Structure***  
| opcode  | reg_op  | void    | id |
|---|---|---|---|
| 4 bits  | 3 bits  | 000000      | 0 |

+ id must be 0 to indicate it uses register instead of immediate.

##### ***Instructions*** 
```assembly
   add $3
   sub $2
```

___

#### ***Type 4 - one immediate***
##### ***Structure***  
| opcode  | void  | immediate    | id |
|---|---|---|---|
| 4 bits  | 000  | 6 bits      | 1 |

+ id must be 1 to indicate it uses immediate.

##### ***Instructions*** 
```assembly
   add 7
   sub 8
```
___

#### ***Type 5 - one immediate without id***
##### ***Structure***  
| opcode  | void  | immediate     |
|---|---|---|
| 4 bits  | 000  | 7 bits      |

##### ***Instructions*** 
```assembly
   blt 15
   jmp 0
```


