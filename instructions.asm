mov $acc, 1
mov $1, 1
fillRam:
    sta $acc
    add 1
    cmp 33
    blt fillRam
moveToNextNonZero:
    mov $acc, $1
    add 1
    cmp $0
    beq moveToNextNonZero
mov $1, $acc
removeMultiple:
    add $1
    mov $2, $acc
    mov $acc, 0
    sta $2
    mov $acc, $2
    cmp 33
    blt removeMultiple
mov $acc, $1
cmp 33
blt moveToNextNonZero
mov $3, 1
readRam:
    lda $3
    mov $4, $acc
    mov $acc, $3
    add 1
    mov $3, $acc
    cmp 33
    blt readRam




