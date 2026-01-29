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
x: .long 30
y: .long 7
sum: .space 4
dif: .space 4
prod: .space 4
cat: .space 4
rest: .space 4
.text
.global main
main:
mov x, %eax
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl y, %esi
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
mov %eax, sum
mov x, %eax
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl y, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl %eax, %esi
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
movl %esi, %eax
movl save_esi, %esi
mov %eax, dif
mov x, %eax
mov y, %ebx
imul %ebx
mov %eax, prod
mov x, %eax
mov y, %ebx
mov $0, %edx
idiv %ebx
mov %eax, cat
mov %edx, rest
mov $1, %eax
mov $0, %ebx
int $0x80
