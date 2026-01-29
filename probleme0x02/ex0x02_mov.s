.data
and_table: .incbin "bin_mov/and.bin"
or_table: .incbin "bin_mov/or.bin"
xor_table: .incbin "bin_mov/xor.bin"
not_table: .incbin "bin_mov/not.bin"
inc_table: .incbin "bin_mov/inc.bin"
dec_table: .incbin "bin_mov/dec.bin"
add_table: .incbin "bin_mov/add.bin"
carry_table: .incbin "bin_mov/carry.bin"
sub_table: .incbin "bin_mov/sub.bin"
carry_sub_table: .incbin "bin_mov/carry_sub.bin"
shl_table: .incbin "bin_mov/shl.bin"
shr_table: .incbin "bin_mov/shr.bin"
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
restumeu: .space 4
.text
.global main
main:
movl $0, %ecx
movl $3, %eax
movl $5, %ebx
cmp %ebx, %eax
jge greater_or_equal
movl $1, %ecx
jmp end
greater_or_equal:
movl $2, %ecx
end:
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
