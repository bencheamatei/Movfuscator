.data 
    n: .long 10 
    v: .long 1,2,3,4,5,6,7,8,9,10
.text 
.global main 
main:
    xorl %ecx, %ecx 
    xorl %eax, %eax
    lea v, %edi 
    movl n, %ebx 
    et_for:
        cmpl %ecx, %ebx 
        je et_final 
        addl (%edi, %ecx ,4), %eax 
        incl %ecx 
        jmp et_for 
    et_final:
        xorl %edx, %edx 
        divl %ebx 
        movl $1, %eax 
        xorl %ebx, %ebx 
        int $0x80