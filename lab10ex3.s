.data
n: .word 6
k: .word 3
v: .word 1, 2, 3, 4, 5, 6

.text
.global main
main:
    la a0, v
    lw a1, n
    lw a2, k
    call k_div

    li a7, 1
    ecall

    li a7, 93
    li a0, 0
    ecall

divizori:
    li a0, 0
    li t0, 1

vezi_div:
    bgt t0, a1, exit_div
    rem t1, a1, t0
    bnez t1, next_div
    addi a0, a0, 1
next_div:
    addi t0, t0, 1
    j vezi_div

exit_div:
    ret

k_div:
    addi sp, sp, -4
    sw ra, 0(sp)

    mv s0, a0
    mv s1, a1
    mv s2, a2
    li s3, 0

loop_vec:
    beqz s1, end_loop
    lw a1, 0(s0)
    call divizori
    bne a0, s2, skip
    addi s3, s3, 1

skip:
    addi s0, s0, 4
    addi s1, s1, -1
    j loop_vec

end_loop:
    mv a0, s3
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
