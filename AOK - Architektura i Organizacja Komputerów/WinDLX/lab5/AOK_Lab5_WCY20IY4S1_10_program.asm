; Rozaz 1 - LW
.data
l1: .word 5
l2: .word 2500000000

.text
lw r1, l1
lw r2, l2


; Rozaz 2 - ADD
.data
l2: .word 5
l3: .word 10
l5: .word 1234567890
l6: .word 1987654320

.text
lw r2, l2
lw r3, l3
lw r5, l5
lw r6, l6
add r1, r2, r3
add r4, r5, r6


; Rozaz 3 - BNEZ
.data
false: .word 0
true: .word 1
l: .word 3
.text

lw r1, false
lw r2, true
bnez r1, next
lw r3, l

next:
 bnez r2, finish
 lw r4, l

finish:
 trap 0


; Rozaz 4 - LEF
.data
l1: .float 5
l2: .float 8
l3: .float 3

.text
lf f1, l1
lf f2, l2

check:
lef f1, f2
bfpt finish1
lf f3, l3

finish1:
lf f4, l3
check2:

 lef f2, f1
bfpt finish2
lf f5, l3

finish2:
 lf f6, l3
