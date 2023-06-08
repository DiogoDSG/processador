main:
    mov $3, 3
    mov $4, 0

leap:
    mov $acc, 0
    add $3
    add $4
    mov $4, $acc
    mov $acc, $3
    add 1
    mov $3, $acc
    cmp 30
    blt leap

finish:
    mov $5, $4 

