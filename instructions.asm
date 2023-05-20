main:   
    mov $1, -2
    cmp $1
    blt tag3
label1:
    cmp -1
    bgt main
tag3:
    cmp 0
    beq label1

