.data
    fs: .asciz "%ld\n"
    fsc: "%ld"
    base: .space 4 
    expo: .space 4
.text
.global main
main:
    pushl $base 
    pushl $fsc 
    call scanf 
    addl $8, %esp    

    pushl $expo 
    pushl $fsc 
    call scanf 
    addl $8, %esp

    movl $1, %ecx 

    et_while:
        cmpl $0, expo 
        je et_final 

        movl expo, %edx 
        andl $1, %edx 
        cmpl $0, %edx 
        je inc_while 

        movl %ecx, %eax
        movl base, %ecx 
        mull %ecx 
        movl %eax, %ecx

        inc_while:
            shr $1, expo 
            movl base, %eax 
            movl base, %edx 
            mull %edx 
            movl %eax, base
            jmp et_while

    et_final:
        pushl %ecx 
        pushl $fs 
        call printf 
        addl $8, %esp 

        movl $1, %eax 
        xorl %ebx, %ebx 
        int $0x80
