.data
	n: .space 4
	k: .space 4
	fstring: .asciz "%ld\n"
	fsc: .asciz "%ld %ld"
.text

comb:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ecx
	movl 12(%ebp), %edx

	cmp $0, %ecx
	je base_case

	cmp %ecx, %edx
	je base_case

	cmp $0, %edx
	je base_case

    cmp %ecx, %edx
    jg bad_case

	decl %ecx
	pushl %edx
	pushl %ecx
	call comb
	popl %ecx
	popl %edx

	pushl %eax
	decl %edx
	pushl %edx
	pushl %ecx
	call comb
	popl %ecx
	popl %edx

	addl 0(%esp), %eax
	jmp combr

	bad_case:
		xorl %eax, %eax
		jmp combr
	base_case:
		movl $1, %eax
		jmp combr
	combr:
		movl %ebp, %esp
		popl %ebp
		ret
.global main
main:
	pushl $k
	pushl $n
	pushl $fsc
	call scanf
	popl %eax
	popl %eax

	pushl k
	pushl n
	call comb
	addl $4, %esp
	addl $4, %esp

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