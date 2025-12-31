import sys 

fin=open("main.s","r")
fout=open("main_mov.s","w")

def save_reg(reg):
    fout.write(f"movl %{reg}, save_{reg}"+"\n")

def get_reg(reg):
    fout.write(f"movl save_{reg}, %{reg}"+"\n")

def write_xor(src,dest):
    save_reg("eax")
    save_reg("ecx")
    save_reg("edi")
    fout.write(f"movl {src}, tmp_src"+"\n")
    fout.write(f"movl {dest}, tmp_dest"+"\n")
    fout.write(f"movl $0, tmp_ans"+"\n")
    fout.write(f"movl $xor_table, %edi"+"\n")
    fout.write("movl $0, %ecx"+"\n")
    for i in range(4):
        fout.write(f"movb tmp_src+{i}, %ch"+"\n")
        fout.write(f"movb tmp_src+{i}, %cl"+"\n")
        fout.write(f"movb (%edi, %ecx), %al"+"\n")
        fout.write(f"movb %al, tmp_ans+{i}"+"\n")

    get_reg("edi")
    get_reg("ecx")  
    get_reg("eax")
    save_reg("edi")
    fout.write(f"movl tmp_ans, %edi"+"\n")
    fout.write(f"movl %edi, {dest}"+"\n")
    get_reg("edi")
def main():
    for line in fin:
        line=line.strip()
        line=line.rstrip()
        if line==".data":
            fout.write(line+"\n")
            for x in ["and", "or", "xor", "not"]:
                fout.write(f"{x}_table: .incbin "+'"'+f"{x}.bin"+'"'+"\n")
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
            else:
                fout.write(line+"\n")

main()
fin.close()
fout.close()