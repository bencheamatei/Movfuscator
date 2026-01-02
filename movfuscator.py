import sys 

if len(sys.argv)<2:
    print("Specificati fisierul")
    exit(0)

assembly_file=sys.argv[1]
fin=open(assembly_file,"r")
fout=open(assembly_file[:-2]+"_mov.s","w")
cnt={} # counter de etichete

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
        # acum trebuie sa vad daca am carry 
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
    fout.write(f"movl 0(%esp), {dest}"+"\n")
    write_add("$4", "%esp")

def write_push(src):
    write_sub("$4", "%esp")
    fout.write(f"movl {src}, 0(%esp)"+"\n")

def write_lea(src, dest):
    fout.write(f"movl ${src}, {dest}"+"\n")

def write_loop(label):
    write_dec("%ecx")
    fout.write("cmpl $0, %ecx"+"\n")
    fout.write(f"jne {label}"+"\n")

def main():
    for line in fin:
        line=line.strip()
        line=line.rstrip()
        if line==".data":
            fout.write(line+"\n")
            for x in ["and", "or", "xor", "not", "inc", "dec", "add", "carry", "sub", "carry_sub"]:
                fout.write(f"{x}_table: .incbin "+'"'+f"bin/{x}.bin"+'"'+"\n")
                if x!="carry" and x!="carry_sub":
                    cnt[x]=0
            fout.write("addp: .long add_table, add_table+65536"+"\n")
            fout.write("carryp: .long carry_table, carry_table+65536"+"\n")
            fout.write("carryval: .space 4"+"\n")

            fout.write("subp: .long sub_table, sub_table+65536"+"\n")
            fout.write("carry_subp: .long carry_sub_table, carry_sub_table+65536"+"\n")

            for x in ["eax", "ebx", "ecx", "edx", "esi", "edi"]:
                fout.write(f"save_{x}: .space 4"+"\n")
            fout.write("tmp_src: .space 4"+"\n")
            fout.write("tmp_dest: .space 4"+"\n")
            fout.write("tmp_ans: .space 4"+"\n")
        else:
            if line[:3]=="xor" or line[:4]=="xorl":
                if line[:4]=="xorl":
                    line=line[5:]
                else:
                    line=line[4:]
                a,b=list(line.split(","))
                a=a.strip()
                a=a.lstrip()
                b=b.strip()
                b=b.lstrip()
                write_xor(a,b)
            elif line[:3]=="and" or line[:4]=="andl":
                if line[:4]=="andl":
                    line=line[5:]
                else:
                    line=line[4:]
                a,b=list(line.split(","))
                a=a.strip()
                a=a.lstrip()
                b=b.strip()
                b=b.lstrip()
                write_and(a,b)
            elif line[:2]=="or" or line[:3]=="orl":
                if line[:3]=="orl":
                    line=line[4:]
                else:
                    line=line[3:]
                a,b=list(line.split(","))
                a=a.strip()
                a=a.lstrip()
                b=b.strip()
                b=b.lstrip()
                write_or(a,b)
            elif line[:3]=="not" or line[:4]=="notl":
                if line[:4]=="notl":
                    line=line[5:]
                else:
                    line=line[4:]
                a=line
                a=a.strip()
                a=a.lstrip()
                write_not(a)
            elif line[:3]=="inc" or line[:4]=="incl":
                if line[:4]=="incl":
                    line=line[5:]
                else:
                    line=line[4:]
                a=line 
                a=a.strip()
                a=a.lstrip()
                write_inc(a)
            elif line[:3]=="dec" or line[:4]=="decl":
                if line[:4]=="decl":
                    line=line[5:]
                else:
                    line=line[4:]
                a=line 
                a=a.strip()
                a=a.lstrip()
                write_dec(a)
            elif line[:3]=="add" or line[:4]=="addl":
                if line[:4]=="addl":
                    line=line[5:]
                else:
                    line=line[4:]
                a,b=list(line.split(","))
                a=a.strip()
                a=a.lstrip()
                b=b.strip()
                b=b.lstrip()
                write_add(a,b)
            elif line[:3]=="sub" or line[:4]=="subl":
                if line[:4]=="subl":
                    line=line[5:]
                else:
                    line=line[4:]
                a,b=list(line.split(","))
                a=a.strip()
                a=a.lstrip()
                b=b.strip()
                b=b.lstrip()
                write_sub(a,b)
            elif line[:3]=="pop" or line[:4]=="popl":
                if line[:4]=="popl":
                    line=line[5:]
                else:
                    line=line[4:]
                a=line 
                a=a.strip()
                a=a.lstrip()
                write_pop(a)
            elif line[:4]=="push" or line[:5]=="pushl":
                if line[:5]=="pushl":
                    line=line[6:]
                else:
                    line=line[5:]
                a=line 
                a=a.strip()
                a=a.lstrip()
                write_push(a)
            elif line[:3]=="lea":
                line=line[4:]
                a,b=line.split(",") 
                a=a.strip()
                a=a.lstrip()
                b=b.strip()
                b=b.lstrip()
                write_lea(a,b)
            elif line[:4]=="loop":
                line=line[4:]
                label=line.strip().lstrip()
                write_loop(label)
            else:
                fout.write(line+"\n")

main()
fin.close()
fout.close()
