.data
and_table: .incbin "and.bin"
or_table: .incbin "or.bin"
xor_table: .incbin "xor.bin"
not_table: .incbin "not.bin"
inc_table: .incbin "inc.bin"
dec_table: .incbin "dec.bin"
add_table: .incbin "add.bin"
carry_table: .incbin "carry.bin"
addp: .long add_table, add_table+65536
carryp: .long carry_table, carry_table+65536
carryval: .space 4
save_eax: .space 4
save_ebx: .space 4
save_ecx: .space 4
save_edx: .space 4
save_esi: .space 4
save_edi: .space 4
tmp_src: .space 4
tmp_dest: .space 4
tmp_ans: .space 4
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

movl %edi, save_edi
movl %eax, save_eax
movl $dec_table, %edi
movl %esi, save_esi
movl %ecx, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl $0, tmp_ans
movl $0, %eax
movb tmp_dest+0, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+0
cmpb $255, %al
jne fin_dec0
movb tmp_dest+1, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+1
cmpb $255, %al
jne fin_dec0
movb tmp_dest+2, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+2
cmpb $255, %al
jne fin_dec0
movb tmp_dest+3, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+3
cmpb $255, %al
jne fin_dec0
fin_dec0:
movl save_eax, %eax
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %ecx
movl save_esi, %esi
pushl %edx
pushl %ecx
call comb
popl %ecx
popl %edx

pushl %eax
movl %edi, save_edi
movl %eax, save_eax
movl $dec_table, %edi
movl %esi, save_esi
movl %edx, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl $0, tmp_ans
movl $0, %eax
movb tmp_dest+0, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+0
cmpb $255, %al
jne fin_dec1
movb tmp_dest+1, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+1
cmpb $255, %al
jne fin_dec1
movb tmp_dest+2, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+2
cmpb $255, %al
jne fin_dec1
movb tmp_dest+3, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+3
cmpb $255, %al
jne fin_dec1
fin_dec1:
movl save_eax, %eax
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %edx
movl save_esi, %esi
pushl %edx
pushl %ecx
call comb
popl %ecx
popl %edx

movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl 0(%esp), %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl %eax, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+0, %cl
movb tmp_dest+0, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+1, %cl
movb tmp_dest+1, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+2, %cl
movb tmp_dest+2, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+3, %cl
movb tmp_dest+3, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl save_eax, %eax
movl save_ebx, %ebx
movl save_ecx, %ecx
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %eax
movl save_esi, %esi
jmp combr

bad_case:
movl %eax, save_eax
movl %ecx, save_ecx
movl %edi, save_edi
movl %esi, save_esi
movl %eax, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl %eax, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl $0, tmp_ans
movl $xor_table, %edi
movl $0, %ecx
movb tmp_src+0, %ch
movb tmp_dest+0, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movb tmp_src+1, %ch
movb tmp_dest+1, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movb tmp_src+2, %ch
movb tmp_dest+2, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movb tmp_src+3, %ch
movb tmp_dest+3, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movl save_edi, %edi
movl save_ecx, %ecx
movl save_eax, %eax
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %eax
movl save_esi, %esi
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
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl $4, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl %esp, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+0, %cl
movb tmp_dest+0, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+1, %cl
movb tmp_dest+1, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+2, %cl
movb tmp_dest+2, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+3, %cl
movb tmp_dest+3, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl save_eax, %eax
movl save_ebx, %ebx
movl save_ecx, %ecx
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %esp
movl save_esi, %esi
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl $4, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl %esp, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+0, %cl
movb tmp_dest+0, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+1, %cl
movb tmp_dest+1, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+2, %cl
movb tmp_dest+2, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl addp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+3, %cl
movb tmp_dest+3, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movl carryp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl save_eax, %eax
movl save_ebx, %ebx
movl save_ecx, %ecx
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %esp
movl save_esi, %esi

pushl %eax
pushl $fstring
call printf
popl %eax
popl %eax

pushl $0
call fflush
popl %eax

movl $1, %eax
movl %eax, save_eax
movl %ecx, save_ecx
movl %edi, save_edi
movl %esi, save_esi
movl %ebx, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl %ebx, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl $0, tmp_ans
movl $xor_table, %edi
movl $0, %ecx
movb tmp_src+0, %ch
movb tmp_dest+0, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movb tmp_src+1, %ch
movb tmp_dest+1, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movb tmp_src+2, %ch
movb tmp_dest+2, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movb tmp_src+3, %ch
movb tmp_dest+3, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movl save_edi, %edi
movl save_ecx, %ecx
movl save_eax, %eax
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %ebx
movl save_esi, %esi
int $0x80
