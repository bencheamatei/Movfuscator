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
tmp_cnt2: .space 4
tmp_src2: .space 4
fs: .asciz "%ld\n"
.text
.global main
main:
movl $1, %eax
movl %esi, save_esi
movl $31, %esi
movl %esi, tmp_cnt
movl save_esi, %esi
for_shl0:
cmpl $0, tmp_cnt
je fin_shl0
movl %esi, save_esi
movl %eax, %esi
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
movl %esi, %eax
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

movl $2, %ecx
movl %esi, save_esi
movl %ecx, %esi
movl %esi, tmp_src2
movl save_esi, %esi
movl $0, mul_ans1
movl $0, mul_ans2
movl %eax, curr1
movl $0, curr2
movl $0, tmp_cnt2
for_mul0:
cmpl $32, tmp_cnt2
je fin_mul0
movl tmp_src2, %eax
movl %eax, save_eax
movl %ecx, save_ecx
movl %edi, save_edi
movl %esi, save_esi
movl $1, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl %eax, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl $0, tmp_ans
movl $and_table, %edi
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
cmpl $0, %eax
je fara_add0
movl $0, carryval
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, tmp_ans
movl %esi, save_esi
movl curr1, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl mul_ans1, %esi
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
movl %esi, mul_ans1
movl save_esi, %esi
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, tmp_ans
movl %esi, save_esi
movl curr2, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl mul_ans2, %esi
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
movl %esi, mul_ans2
movl save_esi, %esi
fara_add0:
movl $0, %eax
movb curr1+3, %al
movl %esi, save_esi
movl $7, %esi
movl %esi, tmp_cnt
movl save_esi, %esi
for_shr0:
cmpl $0, tmp_cnt
je fin_shr0
movl %esi, save_esi
movl %eax, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl %edi, save_edi
movl %ecx, save_ecx
movl %eax, save_eax
movl $shr_table, %edi
movl $0, %ecx
movl $0, %eax
movl $0, tmp_ans
movb tmp_dest+3, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movb tmp_dest+2, %ch
movb tmp_dest+3, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movb tmp_dest+1, %ch
movb tmp_dest+2, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movb tmp_dest+0, %ch
movb tmp_dest+1, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movl save_eax, %eax
movl save_ecx, %ecx
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, %eax
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
movl %esi, tmp_cnt
movl save_esi, %esi
jmp for_shr0
fin_shr0:
movl %eax, auxx
movl %esi, save_esi
movl $1, %esi
movl %esi, tmp_cnt
movl save_esi, %esi
for_shl1:
cmpl $0, tmp_cnt
je fin_shl1
movl %esi, save_esi
movl curr1, %esi
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
movl %esi, curr1
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
movl %esi, tmp_cnt
movl save_esi, %esi
jmp for_shl1
fin_shl1:
movl %esi, save_esi
movl $1, %esi
movl %esi, tmp_cnt
movl save_esi, %esi
for_shl2:
cmpl $0, tmp_cnt
je fin_shl2
movl %esi, save_esi
movl curr2, %esi
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
movl %esi, curr2
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
movl %esi, tmp_cnt
movl save_esi, %esi
jmp for_shl2
fin_shl2:
movl %eax, save_eax
movl %ecx, save_ecx
movl %edi, save_edi
movl %esi, save_esi
movl auxx, %esi
movl %esi, tmp_src
movl save_esi, %esi
movl %esi, save_esi
movl curr2, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl $0, tmp_ans
movl $or_table, %edi
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
movl %esi, curr2
movl save_esi, %esi
movl %esi, save_esi
movl $1, %esi
movl %esi, tmp_cnt
movl save_esi, %esi
for_shr1:
cmpl $0, tmp_cnt
je fin_shr1
movl %esi, save_esi
movl tmp_src2, %esi
movl %esi, tmp_dest
movl save_esi, %esi
movl %edi, save_edi
movl %ecx, save_ecx
movl %eax, save_eax
movl $shr_table, %edi
movl $0, %ecx
movl $0, %eax
movl $0, tmp_ans
movb tmp_dest+3, %ch
movb (%edi, %ecx), %al
movb %al, tmp_ans+3
movb tmp_dest+2, %ch
movb tmp_dest+3, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+2
movb tmp_dest+1, %ch
movb tmp_dest+2, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+1
movb tmp_dest+0, %ch
movb tmp_dest+1, %cl
movb (%edi, %ecx), %al
movb %al, tmp_ans+0
movl save_eax, %eax
movl save_ecx, %ecx
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, tmp_src2
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
jne fin_dec4
movb tmp_dest+1, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+1
cmpb $255, %al
jne fin_dec4
movb tmp_dest+2, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+2
cmpb $255, %al
jne fin_dec4
movb tmp_dest+3, %al
movb (%edi, %eax), %al
movb %al, tmp_ans+3
cmpb $255, %al
jne fin_dec4
fin_dec4:
movl save_eax, %eax
movl save_edi, %edi
movl %esi, save_esi
movl tmp_ans, %esi
movl %esi, tmp_cnt
movl save_esi, %esi
jmp for_shr1
fin_shr1:
movl %edi, save_edi
movl %eax, save_eax
movl $inc_table, %edi
movl %esi, save_esi
movl tmp_cnt2, %esi
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
movl %esi, tmp_cnt2
movl save_esi, %esi
jmp for_mul0
fin_mul0:
movl mul_ans1, %eax
movl mul_ans2, %edx

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
movl %esi, %esp
movl save_esi, %esi
movl %edx, 0(%esp)
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
movl %esi, %esp
movl save_esi, %esi
movl $fs, 0(%esp)
call printf
movl %eax, save_eax
movl %ebx, save_ebx
movl %ecx, save_ecx
movl %edi, save_edi
movl $0, carryval
movl $0, tmp_ans
movl %esi, save_esi
movl $8, %esi
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
