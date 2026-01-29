.data
	n: .space 4
	fstring: .asciz "%ld\n"
	fs: .asciz "%ld"
.text

fib:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %eax
	cmp $2, %eax
	jbe base_case

	movl 8(%ebp), %ecx
	decl %ecx

	pushl %ecx
	call fib
	addl $4, %esp

	pushl %eax
	movl 8(%ebp), %ecx
	subl $2, %ecx

	pushl %ecx
	call fib
	addl $4, %esp

	popl %ebx
	addl %ebx, %eax
	jmp fibr
	base_case:
		movl $1, %eax
		jmp fibr
	fibr:
		movl %ebp, %esp
		popl %ebp
		ret
.global main
main:
	pushl $n
	pushl $fs
	call scanf
	popl %eax
	popl %eax

	pushl n
	call fib
	popl %ebx

	pushl %eax
	pushl $fstring
	call printf
	popl %eax
	popl %eax

	pushl $0
	call fflush
	popl %eax

	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80