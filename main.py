import sys 

if len(sys.argv)<2:
    print("Specificati fisierul")
    exit(0)

assembly_file=sys.argv[1]
fin=open(assembly_file,"r")
# o sa se accepte doar fisiere cu extensia .s sau .asm

sname=""
if assembly_file[-3:]=="asm":
    sname=assembly_file[:-3]+"_mov.asm"
elif assembly_file[-1:]=="s":
    sname=assembly_file[:-1]+"_mov.s"
else:
    print("Se accepta doar fisiere cu extensia .s sau .asm")
    exit(0)

fout=open(sname, "w")

cnt={} # counter de etichete (sa nu refolosesc)

def save_reg(reg):
    fout.write(f"movl %{reg}, save_{reg}"+"\n")

def get_reg(reg):
    fout.write(f"movl save_{reg}, %{reg}"+"\n")

def write_xor(src,dest):
    save_reg("eax")
    save_reg("ecx")
    save_reg("edi")

    save_reg("esi")
    fout.write(f"movl {src}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_src"+"\n")
    get_reg("esi")

    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")

    fout.write(f"movl $0, tmp_ans"+"\n")
    fout.write(f"movl $xor_table, %edi"+"\n")
    fout.write("movl $0, %ecx"+"\n")
    for i in range(4):
        fout.write(f"movb tmp_src+{i}, %ch"+"\n")
        fout.write(f"movb tmp_dest+{i}, %cl"+"\n")
        fout.write(f"movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")

    get_reg("edi")
    get_reg("ecx")  
    get_reg("eax")

    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_and(src,dest):
    save_reg("eax")
    save_reg("ecx")
    save_reg("edi")
    save_reg("esi")
    fout.write(f"movl {src}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_src"+"\n")
    get_reg("esi")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    fout.write(f"movl $0, tmp_ans"+"\n")
    fout.write(f"movl $and_table, %edi"+"\n")
    fout.write("movl $0, %ecx"+"\n")
    for i in range(4):
        fout.write(f"movb tmp_src+{i}, %ch"+"\n")
        fout.write(f"movb tmp_dest+{i}, %cl"+"\n")
        fout.write(f"movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")

    get_reg("edi")
    get_reg("ecx")  
    get_reg("eax")

    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_or(src,dest):
    save_reg("eax")
    save_reg("ecx")
    save_reg("edi")
    save_reg("esi")
    fout.write(f"movl {src}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_src"+"\n")
    get_reg("esi")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    fout.write(f"movl $0, tmp_ans"+"\n")
    fout.write(f"movl $or_table, %edi"+"\n")
    fout.write("movl $0, %ecx"+"\n")
    for i in range(4):
        fout.write(f"movb tmp_src+{i}, %ch"+"\n")
        fout.write(f"movb tmp_dest+{i}, %cl"+"\n")
        fout.write(f"movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")
    get_reg("edi")
    get_reg("ecx")  
    get_reg("eax")
    
    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_not(dest):
    save_reg("eax")
    save_reg("ecx")
    save_reg("edi")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    fout.write(f"movl $0, tmp_ans"+"\n")
    fout.write(f"movl $not_table, %edi"+"\n")
    fout.write("movl $0, %ecx"+"\n")
    for i in range(4):
        fout.write(f"movb tmp_dest+{i}, %cl"+"\n")
        fout.write(f"movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")

    get_reg("edi")
    get_reg("ecx")  
    get_reg("eax")
    save_reg("esi")

    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_inc(dest):
    # de aici incepe chestia sa nu fie kinda trivial
    # daca fac inc pe fiecare segment de 8 in parte nu imi da rezultatul bun 
    # ceea ce o sa fac e urm chestie
    # fac inc pe primul segment 
    # si DACA el devine 0 atunci trebuie sa dau inc la urmatorul si tot asa
    # in majoritatea cazurilor tho nu o sa se intample asta 
    save_reg("edi")
    save_reg("eax")
    fout.write("movl $inc_table, %edi"+"\n")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    fout.write("movl $0, tmp_ans"+"\n")
    fout.write("movl $0, %eax"+"\n")
    s="fin_inc"+str(cnt["inc"])

    for i in range(4):
        fout.write(f"movb tmp_dest+{i}, %al"+"\n")
        fout.write(f"movb (%edi, %eax), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")
        fout.write(f"cmpb $0, %al"+"\n")
        fout.write(f"jne {s}"+"\n")

    cnt["inc"]+=1
    fout.write(f"{s}:"+"\n")
    get_reg("eax")
    get_reg("edi")

    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_dec(dest):
    # e logica extrem de asemanatoare ca la inc 
    # aici trebuie sa merg mai departe doar daca scad din 0
    # adica daca cel de jos a devenit 255 
    save_reg("edi")
    save_reg("eax")
    fout.write("movl $dec_table, %edi"+"\n")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    fout.write("movl $0, tmp_ans"+"\n")
    fout.write("movl $0, %eax"+"\n")
    s="fin_dec"+str(cnt["dec"])

    for i in range(4):
        fout.write(f"movb tmp_dest+{i}, %al"+"\n")
        fout.write(f"movb (%edi, %eax), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")
        fout.write(f"cmpb $255, %al"+"\n")
        fout.write(f"jne {s}"+"\n")

    cnt["dec"]+=1
    fout.write(f"{s}:"+"\n")
    get_reg("eax")
    get_reg("edi")

    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_add(src, dest):
    save_reg("eax")
    save_reg("ebx")
    save_reg("ecx")
    save_reg("edi")
    fout.write("movl $0, carryval"+"\n")
    fout.write("movl $0, tmp_ans"+"\n")
    save_reg("esi")
    fout.write(f"movl {src}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_src"+"\n")
    get_reg("esi")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    for i in range(4):
        fout.write("movl carryval, %ebx"+"\n")
        fout.write("movl addp(, %ebx, 4), %edi"+"\n")
        fout.write("movl $0, %ecx"+"\n")
        fout.write(f"movb tmp_src+{i}, %cl"+"\n")
        fout.write(f"movb tmp_dest+{i}, %ch"+"\n")
        fout.write("movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")
        # acum trebuie sa vad daca am carry 
        fout.write("movl carryp(, %ebx, 4), %edi"+"\n")
        fout.write("movb (%edi, %ecx), %al"+"\n")
        fout.write("movb %al, carryval+0"+"\n")
    get_reg("eax")
    get_reg("ebx")
    get_reg("ecx")
    get_reg("edi")

    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_sub(src,dest):
    save_reg("eax")
    save_reg("ebx")
    save_reg("ecx")
    save_reg("edi")
    fout.write("movl $0, carryval"+"\n")
    fout.write("movl $0, tmp_ans"+"\n")
    save_reg("esi")
    fout.write(f"movl {src}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_src"+"\n")
    get_reg("esi")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    for i in range(4):
        fout.write("movl carryval, %ebx"+"\n")
        fout.write("movl subp(, %ebx, 4), %edi"+"\n")
        fout.write("movl $0, %ecx"+"\n")
        fout.write(f"movb tmp_src+{i}, %cl"+"\n")
        fout.write(f"movb tmp_dest+{i}, %ch"+"\n")
        fout.write("movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")
        fout.write("movl carry_subp(, %ebx, 4), %edi"+"\n")
        fout.write("movb (%edi, %ecx), %al"+"\n")
        fout.write("movb %al, carryval+0"+"\n")
    get_reg("eax")
    get_reg("ebx")
    get_reg("ecx")
    get_reg("edi")

    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_pop(dest):
    if dest=="%esi":
        fout.write(f"movl 0(%esp), %esi\n")
    else:
        save_reg("esi")
        fout.write(f"movl 0(%esp), %esi\n")
        fout.write(f"movl %esi, {dest}\n")
        get_reg("esi")
    write_add("$4", "%esp")

def write_push(src):
    # ca sa nu am vreo problema legata de mem-mem
    # pun intermediar in esi 
    if src=="%esi":
        write_sub("$4","%esp")
        fout.write(f"movl {src}, 0(%esp)"+"\n")
    else:
        write_sub("$4","%esp")
        save_reg("esi")
        fout.write(f"movl {src}, %esi\n")
        fout.write("movl %esi, 0(%esp)\n")
        get_reg("esi")

def write_loop(label):
    write_dec("%ecx")
    fout.write("cmpl $0, %ecx"+"\n")
    fout.write(f"jne {label}"+"\n")

def write_shl(nr,dest):
    def shiftl_by_1(dest):
        save_reg("esi")
        fout.write(f"movl {dest}, %esi"+"\n")
        fout.write("movl %esi, tmp_dest"+"\n")
        get_reg("esi")

        save_reg("edi")
        save_reg("ecx")
        save_reg("eax")
        fout.write("movl $shl_table, %edi\n")
        fout.write("movl $0, %ecx\n")
        fout.write("movl $0, %eax\n")
        fout.write("movl $0, tmp_ans\n")
        fout.write("movb tmp_dest+0, %ch\n")
        fout.write("movb (%edi, %ecx), %al\n")
        fout.write("movb %al, tmp_ans+0\n")

        for i in range(1,4):
            fout.write(f"movb tmp_dest+{i}, %ch\n")
            fout.write(f"movb tmp_dest+{i-1}, %cl\n")
            fout.write("movb (%edi, %ecx), %al\n")
            fout.write(f"movb %al, tmp_ans+{i}\n")
        
        get_reg("eax")
        get_reg("ecx")
        get_reg("edi")

        save_reg("esi")
        fout.write("movl tmp_ans, %esi\n")
        fout.write(f"movl %esi, {dest}\n")
        if dest!="%esi":
            get_reg("esi")


    save_reg("esi")
    fout.write(f"movl {nr}, %esi"+"\n")
    fout.write("movl %esi, tmp_cnt"+"\n")
    get_reg("esi")

    s="for_shl"+str(cnt["shl"])
    fout.write(s+":\n")
    fout.write("cmpl $0, tmp_cnt\n")
    fout.write("je fin_shl"+str(cnt["shl"])+"\n")

    #logica aici
    shiftl_by_1(dest)

    write_dec("tmp_cnt")
    fout.write(f"jmp {s}\n")
    
    fout.write("fin_shl"+str(cnt["shl"])+":\n")
    cnt["shl"]+=1

def write_shr(nr,dest):
    def shiftr_by_1(dest):
        save_reg("esi")
        fout.write(f"movl {dest}, %esi"+"\n")
        fout.write("movl %esi, tmp_dest"+"\n")
        get_reg("esi")

        save_reg("edi")
        save_reg("ecx")
        save_reg("eax")
        fout.write("movl $shr_table, %edi\n")
        fout.write("movl $0, %ecx\n")
        fout.write("movl $0, %eax\n")
        fout.write("movl $0, tmp_ans\n")
        fout.write("movb tmp_dest+3, %ch\n")
        fout.write("movb (%edi, %ecx), %al\n")
        fout.write("movb %al, tmp_ans+3\n")

        for i in range(2,-1,-1):
            fout.write(f"movb tmp_dest+{i}, %ch\n")
            fout.write(f"movb tmp_dest+{i+1}, %cl\n")
            fout.write("movb (%edi, %ecx), %al\n")
            fout.write(f"movb %al, tmp_ans+{i}\n")
        
        get_reg("eax")
        get_reg("ecx")
        get_reg("edi")

        save_reg("esi")
        fout.write("movl tmp_ans, %esi\n")
        fout.write(f"movl %esi, {dest}\n")
        if dest!="%esi":
            get_reg("esi")


    save_reg("esi")
    fout.write(f"movl {nr}, %esi"+"\n")
    fout.write("movl %esi, tmp_cnt"+"\n")
    get_reg("esi")

    s="for_shr"+str(cnt["shr"])
    fout.write(s+":\n")
    fout.write("cmpl $0, tmp_cnt\n")
    fout.write("je fin_shr"+str(cnt["shr"])+"\n")

    shiftr_by_1(dest)

    write_dec("tmp_cnt")
    fout.write(f"jmp {s}\n")
    
    fout.write("fin_shr"+str(cnt["shr"])+":\n")
    cnt["shr"]+=1

def write_add_spec(src, dest):
    # e hard copy la write_add, doar ca carry-ul e global
    # facut special pentru mul

    save_reg("eax")
    save_reg("ebx")
    save_reg("ecx")
    save_reg("edi")

    fout.write("movl $0, tmp_ans"+"\n")
    save_reg("esi")
    fout.write(f"movl {src}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_src"+"\n")
    get_reg("esi")
    save_reg("esi")
    fout.write(f"movl {dest}, %esi"+"\n")
    fout.write(f"movl %esi, tmp_dest"+"\n")
    get_reg("esi")
    for i in range(4):
        fout.write("movl carryval, %ebx"+"\n")
        fout.write("movl addp(, %ebx, 4), %edi"+"\n")
        fout.write("movl $0, %ecx"+"\n")
        fout.write(f"movb tmp_src+{i}, %cl"+"\n")
        fout.write(f"movb tmp_dest+{i}, %ch"+"\n")
        fout.write("movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")
        # acum trebuie sa vad daca am carry 
        fout.write("movl carryp(, %ebx, 4), %edi"+"\n")
        fout.write("movb (%edi, %ecx), %al"+"\n")
        fout.write("movb %al, carryval+0"+"\n")
    get_reg("eax")
    get_reg("ebx")
    get_reg("ecx")
    get_reg("edi")

    save_reg("esi")
    fout.write(f"movl tmp_ans, %esi"+"\n")
    fout.write(f"movl %esi, {dest}"+"\n")
    if dest!="%esi":
        get_reg("esi")

def write_mul(op):
    # ok debugging session, am uitat ca daca apelez alte functii stric valorile pe care le am in memorie 
    # deci ca sa fac aici trebuie sa am propriile mele valori care nu se intercaleaza cu cele din alte functii
    # deja am rezolvat cnt 

    save_reg("esi")
    fout.write(f"movl {op}, %esi\n")
    fout.write(f"movl %esi, tmp_src2\n")
    get_reg("esi")

    fout.write("movl $0, mul_ans1\n") #partea inferioara de rezultat
    fout.write("movl $0, mul_ans2\n")
    fout.write("movl %eax, curr1\n") #partea inferioara din primul termen
    fout.write("movl $0, curr2\n")

    fout.write("movl $0, tmp_cnt2\n")
    s="for_mul"+str(cnt["mul"])
    fout.write(s+":\n")
    fout.write("cmpl $32, tmp_cnt2\n")
    fout.write("je fin_mul"+str(cnt["mul"])+"\n")

    fout.write("movl tmp_src2, %eax\n")
    write_and("$1", "%eax") # verific daca trebuie sa adun
    fout.write("cmpl $0, %eax\n")
    fout.write("je fara_add"+str(cnt["mul"])+"\n")

    fout.write("movl $0, carryval\n")
    write_add_spec("curr1","mul_ans1")
    write_add_spec("curr2","mul_ans2")

    fout.write("fara_add"+str(cnt["mul"])+":\n")
    fout.write("movl $0, %eax\n")
    fout.write("movb curr1+3, %al\n")
    write_shr("$7", "%eax")
    fout.write("movl $0, auxx\n")
    fout.write("movl %eax, auxx\n")

    write_shl("$1", "curr1")
    write_shl("$1", "curr2")
    write_or("auxx","curr2")
    write_shr("$1", "tmp_src2")

    write_inc("tmp_cnt2")
    fout.write("jmp "+s+"\n")
    fout.write("fin_mul"+str(cnt["mul"])+":\n")
    fout.write("movl mul_ans1, %eax\n")
    fout.write("movl mul_ans2, %edx\n")
    cnt["mul"]+=1

def write_div(op):
    # deci e 3 dimineata cand scriu functia asta
    # daca merge i might actually be him 

    save_reg("esi")
    fout.write(f"movl {op}, %esi\n")
    fout.write("movl %esi, tmp_src2\n")
    get_reg("esi")

    fout.write("movl %eax, curr1\n")
    fout.write("movl %edx, curr2\n")
    fout.write("movl $0, rest\n")
    fout.write("movl $0, tmp_cnt2\n")
    fout.write("for_div"+str(cnt["div"])+":\n")
    fout.write("cmpl $64, tmp_cnt2\n")
    fout.write("je fin_div"+str(cnt["div"])+"\n")

    fout.write("movl $0, %eax\n")
    fout.write("movb curr2+3, %al\n")
    write_shr("$7", "%eax")
    fout.write("movb %al, aux\n")

    fout.write("movl $0, %eax\n")
    fout.write("movb curr1+3, %al\n")
    write_shr("$7", "%eax")
    fout.write("movb %al, auxx\n")

    write_shl("$1", "rest")
    write_or("aux", "rest")

    write_shl("$1", "curr2")
    write_or("auxx", "curr2")

    write_shl("$1", "curr1")

    fout.write("movl rest, %eax\n")
    fout.write("cmpl tmp_src2, %eax\n")
    fout.write("jb fara_sub"+str(cnt["div"])+"\n")

    write_sub("tmp_src2", "rest")
    write_or("$1", "curr1")

    fout.write("fara_sub"+str(cnt["div"])+":\n")
    write_inc("tmp_cnt2")
    fout.write("jmp for_div"+str(cnt["div"])+"\n")
    fout.write("fin_div"+str(cnt["div"])+":\n")
    fout.write("movl curr1, %eax\n")
    fout.write("movl rest, %edx\n")
    cnt["div"]+=1

def write_data_additionals():
    for x in ["and", "or", "xor", "not", "inc", "dec", "add", "carry", "sub", "carry_sub", "shl", "shr", "mul", "div"]:
        if x!="mul" and x!="div":
            fout.write(f"{x}_table: .incbin "+'"'+f"bin/{x}.bin"+'"'+"\n")
        if x!="carry" and x!="carry_sub":
            cnt[x]=0

    # tabelele cu carry 
    # carryp imi zice la care tabela trebuie sa merg
    # (same la scaderi)
    fout.write("addp: .long add_table, add_table+65536"+"\n")
    fout.write("carryp: .long carry_table, carry_table+65536"+"\n")
    fout.write("carryval: .space 4"+"\n")

    fout.write("subp: .long sub_table, sub_table+65536"+"\n")
    fout.write("carry_subp: .long carry_sub_table, carry_sub_table+65536"+"\n")

    for x in ["eax", "ebx", "ecx", "edx", "esi", "edi"]:
        fout.write(f"save_{x}: .space 4"+"\n")

    # variabile de uz specific si general pentru operatii 
    # src dest ans cnt sunt generale 
    # restul pentru mul si div (pentru ca aveam declaratii conflictind ca apelam operaii in funciile mele 
    # si se suprascriau)

    fout.write("tmp_src: .space 4"+"\n")
    fout.write("tmp_dest: .space 4"+"\n")
    fout.write("tmp_ans: .space 4"+"\n")
    fout.write("tmp_cnt: .space 4"+"\n")
    fout.write("mul_ans1: .space 4\n")
    fout.write("mul_ans2: .space 4\n")
    fout.write("curr1: .space 4\n")
    fout.write("curr2: .space 4\n")
    fout.write("auxx: .space 4\n")
    fout.write("aux: .space 4\n")
    fout.write("tmp_cnt2: .space 4\n")
    fout.write("tmp_src2: .space 4\n")
    fout.write("tmp_div: .space 4\n")
    fout.write("rest: .space 4\n")

def parse_line(line):
    # first of all vreau sa scot comentariile 
    # o sa fac presupunerea ca incep ori cu # ori cu ; si ca nu se extind pe mai multe linii
    # adk sa am ceva structura gen /* */ ca n cpp

    line=line.strip()
    for comm in "#;":
        u=line.find(comm)
        if u!=-1:
            line=line[:u]
    line=line.strip()

    if line=="":
        return
    
    if line[-1]==":": #lin cu eticheta 
        fout.write(line+"\n")
        return 

    op=line.split()[0].strip()
    ce=line[len(op):]

    if op[:3]=="xor":
        a,b=ce.split(",")
        a=a.strip()
        b=b.strip()
        write_xor(a,b)
    elif op[:3]=="and":
        a,b=ce.split(",")
        a=a.strip()
        b=b.strip()
        write_and(a,b)
    elif op[:2]=="or":
        a,b=ce.split(",")
        a=a.strip()
        b=b.strip()
        write_or(a,b)
    elif op[:3]=="not":
        a=ce.strip()
        write_not(a)
    elif op[:3]=="inc":
        a=ce.strip()
        write_inc(a)
    elif op[:3]=="dec":
        a=ce.strip()
        write_dec(a)
    elif op[:3]=="add":
        a,b=ce.split(",")
        a=a.strip()
        b=b.strip()
        write_add(a,b)
    elif op[:3]=="sub":
        a,b=ce.split(",")
        a=a.strip()
        b=b.strip()
        write_sub(a,b)
    elif op[:3]=="pop":
        a=ce.strip()
        write_pop(a)
    elif op[:4]=="push":
        a=ce.strip()
        write_push(a)
    elif op[:4]=="loop":
        label=ce.strip()
        write_loop(label)
    elif op[:3]=="shl":
        a,b=ce.split(",")
        a=a.strip()
        b=b.strip()
        write_shl(a,b) 
    elif op[:3]=="shr":
        a,b=ce.split(",")
        a=a.strip()
        b=b.strip()
        write_shr(a,b) 
    elif op[:3]=="mul":
        a=ce.strip()
        write_mul(a)
    elif op[:3]=="div":
        a=ce.strip()
        write_div(a)
    else:
        fout.write(line+"\n") # :(
 
def main():
    inData=True
    for line in fin: 
        line=line.strip()
        if line==".data":
            fout.write(".data\n")
            write_data_additionals()
        else:
            if line==".text":
                inData=False 
                fout.write(".text\n")
            else:
                if inData:
                    if not(line[0]=="#" or line[0]==";"): # nu scriu inutil comentariile
                        fout.write(line+"\n")
                else:
                    parse_line(line)
main()
fin.close()
fout.close()
