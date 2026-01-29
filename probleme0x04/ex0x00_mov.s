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
n: .long 6
v: .word 10, 20, 40, 60, 100, 5
.text
.global main
main:
lea v, %edi
mov $1, %ecx
mov (%edi, %ecx, 4), %edx
etexit:
mov $1, %eax
mov $0, %ebx
int $0x80
