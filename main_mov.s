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
fs: .asciz "%ld\n"
n: .long 10
.text
.global main
main:
movl $5, %eax
movl $4, %ebx
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %eax, tmp_src
movl %ebx, tmp_dest
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
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl tmp_ans, %ebx

pushl %ebx
pushl $fs
call printf
popl %eax
popl %eax

movl $1, %eax
movl %eax, save_eax
movl %ecx, save_ecx
movl %edi, save_edi
movl %ebx, tmp_src
movl %ebx, tmp_dest
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
movl tmp_ans, %ebx
int $0x80
