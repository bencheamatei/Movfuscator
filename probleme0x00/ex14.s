.data
    v: .long 26, 112, 3, 56, 31, 18, 27, 35, 1
    n: .long 9
    min1: .long 1000000000
    min2: .long 1000000000
    formatAf: .asciz "Cele mai mici 2 sunt: %ld %ld\n"
.text
.global main
main:
    xorl %ecx, %ecx
    lea v, %edi
et_parcurgere:
    cmp n, %ecx
    je et_afisare
    movl (%edi,%ecx,4), %edx
    movl min1, %ebx
    cmp %ebx, %edx
    jge verifica_min2
    movl %ebx, min2
    movl %edx, min1
    jmp et_cont_parcurgere
verifica_min2:
    movl min2, %ebx
    cmp %ebx, %edx
    jge et_cont_parcurgere
    movl %edx, min2
et_cont_parcurgere:
    incl %ecx
    jmp et_parcurgere
et_afisare:
    pushl min2 
    pushl min1
    pushl $formatAf
    call printf 
    addl $12, %esp 
et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80