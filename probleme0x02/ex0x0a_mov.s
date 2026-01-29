.data
and_table: .incbin "bin/and.bin"
or_table: .incbin "bin/or.bin"
xor_table: .incbin "bin/xor.bin"
not_table: .incbin "bin/not.bin"
inc_table: .incbin "bin/inc.bin"
dec_table: .incbin "bin/dec.bin"
add_table: .incbin "bin/add.bin"
carry_table: .incbin "bin/carry.bin"
sub_table: .incbin "bin/sub.bin"
carry_sub_table: .incbin "bin/carry_sub.bin"
shl_table: .incbin "bin/shl.bin"
shr_table: .incbin "bin/shr.bin"
addp: .long add_table, add_table+65536
carryp: .long carry_table, carry_table+65536
carryval: .space 4
subp: .long sub_table, sub_table+65536
carry_subp: .long carry_sub_table, carry_sub_table+65536
save_eax: .space 4
save_ebx: .space 4
save_ecx: .space 4
save_edx: .space 4
save_esi: .space 4
save_edi: .space 4
tmp_src: .space 4
tmp_dest: .space 4
tmp_ans: .space 4
tmp_cnt: .space 4
mul_ans1: .space 4
mul_ans2: .space 4
curr1: .space 4
curr2: .space 4
auxx: .space 4
aux: .space 4
tmp_cnt2: .space 4
tmp_src2: .space 4
tmp_div: .space 4
rest: .space 4
x: .long 77
.text
.global main
main:
movl x, %eax
movl $1, %ebx
et_loop:
cmpl %eax, %ebx
ja et_exit
movl %esi, save_esi
movl $1, %esi
movl %esi, tmp_cnt
movl save_esi, %esi
for_shl0:
cmpl $0, tmp_cnt
je fin_shl0
movl %esi, save_esi
movl %ebx, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl %edi, save_edi
movl %ecx, save_ecx
movl %eax, save_eax
movl $shl_table, %edi
movl $0, %ecx
movl $0, %eax
movl $0, tmp_ans
movb tmp_dest+0, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movb tmp_dest+1, %ch
movb tmp_dest+0, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movb tmp_dest+2, %ch
movb tmp_dest+1, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movb tmp_dest+3, %ch
movb tmp_dest+2, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movl save_eax, %eax
movl save_ecx, %ecx
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %ebx
movl save_esi, %esi
movl %edi, save_edi
movl %eax, save_eax
movl $dec_table, %edi
movl %esi, save_esi
movl tmp_cnt, %esi
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
movl %esi, tmp_cnt
movl save_esi, %esi
jmp for_shl0
fin_shl0:
jmp et_loop
et_exit:
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
