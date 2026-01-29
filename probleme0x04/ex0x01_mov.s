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
n: .long 9
v: .long 12, 15, 5, 15, 4, 1, 7, 15, 1
maxim: .long 0
ap: .long 0
.text
.global main
main:
movl n, %ecx
movl $v, %edi
et_loop:
movl n, %ebx
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
movl %ebx, %esi
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
movl %esi, %ebx
movl save_esi, %esi
movl (%edi, %ebx, 4), %edx
cmp maxim, %edx
jg et_max_nou
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
jne et_loop
jmp cont_max
et_max_nou:
movl %edx, maxim
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
movl %esi, %ecx
movl save_esi, %esi
cmpl $0, %ecx
jne et_loop
cont_max:
movl n, %ecx
movl $v, %edi
loop_ap:
movl n, %ebx
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
movl %ebx, %esi
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
movl %esi, %ebx
movl save_esi, %esi
movl (%edi, %ebx, 4), %edx
cmp maxim, %edx
je et_egale
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
jne fin_dec2
movb tmp_dest+1, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+1
cmpb $255, %al
jne fin_dec2
movb tmp_dest+2, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+2
cmpb $255, %al
jne fin_dec2
movb tmp_dest+3, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+3
cmpb $255, %al
jne fin_dec2
fin_dec2:
movl save_eax, %eax
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %ecx
movl save_esi, %esi
cmpl $0, %ecx
jne loop_ap
jmp et_exit
et_egale:
movl %edi, save_edi
movl %eax, save_eax
movl $inc_table, %edi
movl %esi, save_esi
movl ap, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl $0, tmp_ans
movl $0, %eax
movb tmp_dest+0, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+0
cmpb $0, %al
jne fin_inc0
movb tmp_dest+1, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+1
cmpb $0, %al
jne fin_inc0
movb tmp_dest+2, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+2
cmpb $0, %al
jne fin_inc0
movb tmp_dest+3, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+3
cmpb $0, %al
jne fin_inc0
fin_inc0:
movl save_eax, %eax
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, ap
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
jne fin_dec3
movb tmp_dest+1, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+1
cmpb $255, %al
jne fin_dec3
movb tmp_dest+2, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+2
cmpb $255, %al
jne fin_dec3
movb tmp_dest+3, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+3
cmpb $255, %al
jne fin_dec3
fin_dec3:
movl save_eax, %eax
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %ecx
movl save_esi, %esi
cmpl $0, %ecx
jne loop_ap
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
