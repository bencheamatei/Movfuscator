.data
	fsc: .asciz "%ld"
	n: .space 4
	fstring: .asciz "%ld\n"
.text

fact:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %eax
	cmp $1, %eax
	je ret_fact

	pushl %eax
	decl %eax
	pushl %eax
	call fact
	addl $4, %esp

	mull 0(%esp)
	addl $4, %esp

	ret_fact:
		movl %ebp, %esp
		popl %ebp
		ret

.global main
main:
	pushl $n
	pushl $fsc
	call scanf
	popl %eax
	popl %eax

	pushl n
	call fact
	addl $4, %esp

	pushl %eax
	pushl $fstring
	call printf
	addl $4, %esp
	addl $4, %esp

	pushl $0
	call fflush
	popl %eax

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80