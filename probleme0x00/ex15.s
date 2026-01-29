.data 
    n: .long 7
    v: .long 1245,342,543523,342,4234,1245,543523
    fspr: .asciz "%ld\n"
.text 
.global main
main:
    xorl %ecx, %ecx 
    xorl %eax, %eax
    lea v, %edi 
    et_for:
        cmpl n, %ecx 
        je et_final
        movl (%edi, %ecx, 4), %ebx 
        xorl %ebx, %eax   
        incl %ecx
        jmp et_for 
    et_final:
        pushl %eax 
        pushl $fspr
        call printf 
        addl $8, %esp 

        movl $1, %eax 
        xorl %ebx, %ebx 
        int $0x80
