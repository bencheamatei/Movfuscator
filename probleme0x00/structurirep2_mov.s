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
n: .long 5
s: .space 4
.text
.global main
main:
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl $1, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl n, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl carryval, %ebx
movl subp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+0, %cl
movb tmp_dest+0, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movl carry_subp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl subp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+1, %cl
movb tmp_dest+1, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movl carry_subp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl subp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+2, %cl
movb tmp_dest+2, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movl carry_subp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl carryval, %ebx
movl subp(, %ebx, 4), %edi
movl $0, %ecx
movb tmp_src+3, %cl
movb tmp_dest+3, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movl carry_subp(, %ebx, 4), %edi
movb (%edi, %ecx), %al
movb %al, carryval+0
movl save_eax, %eax
movl save_ebx, %ebx
movl save_ecx, %ecx
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, n
movl save_esi, %esi
mov n, %ecx
etloop:
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl %ecx, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl s, %esi
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
movl %esi, s
movl save_esi, %esi
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
cmpl $0, %ecx
jne etloop
jmp etexit
etexit:
mov $1, %eax
mov $0, %ebx
int $0x80
