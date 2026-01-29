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
restumeu: .space 4
helloWorld: .asciz "Hello, world!\n"
.text
.global main
main:
mov $4, %eax
mov $1, %ebx
mov $helloWorld, %ecx
mov $15, %edx
int $0x80
mov $1, %eax
mov $0, %ebx
int $0x80
