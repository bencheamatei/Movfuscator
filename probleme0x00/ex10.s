.data
    fstr: .asciz "%ld\n"
.text 
.global main
main: 
    xorl %eax, %eax 
    addl $2317, %eax 
    incl %eax 

    pushl %eax 
    pushl $fstr 
    call printf 
    addl $8, %esp

    movl $1, %eax 
    xorl %ebx, %ebx 
    int $0x80

