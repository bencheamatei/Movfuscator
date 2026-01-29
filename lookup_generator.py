from pathlib import Path

pth=Path("bin_mov")
pth.mkdir(parents=True, exist_ok=True)

def genxor():
    a=bytearray()
    for x in range(256):
        for y in range(256):
            a.append((x^y)&0xFF)

    with open(str(pth)+"/xor.bin","wb") as fout:
        fout.write(a)

def genand():
    a=bytearray()
    for x in range(256):
        for y in range(256):
            a.append((x&y)&0xFF)

    with open(str(pth)+"/and.bin","wb") as fout:
        fout.write(a)

def genor():
    a=bytearray()
    for x in range(256):
        for y in range(256):
            a.append((x|y))

    with open(str(pth)+"/or.bin","wb") as fout:
        fout.write(a)

def gennot():
    a=bytearray()
    for x in range(256):
        a.append((~x)&0xFF)

    with open(str(pth)+"/not.bin","wb") as fout:
        fout.write(a)

def geninc():
    a=bytearray()
    for x in range(256):
        a.append((x+1)&0xFF)
    with open(str(pth)+"/inc.bin","wb") as fout:
        fout.write(a)

def gendec():
    a=bytearray()
    for x in range(256):
        a.append((x-1)&0xFF)
    with open(str(pth)+"/dec.bin","wb") as fout:
        fout.write(a)

def genadd():
    a=bytearray()
    b=bytearray()
    for x in range(256):
        for y in range(256):
            a.append((x+y)&0xFF)
            if x+y>255:
                b.append(1)
            else:
                b.append(0)

    for x in range(256):
        for y in range(256):
            a.append((x+y+1)&0xFF)
            if x+y+1>255:
                b.append(1)
            else:
                b.append(0)
    with open(str(pth)+"/add.bin","wb") as fout:
        fout.write(a)
    with open(str(pth)+"/carry.bin","wb") as fout:
        fout.write(b)

def gensub():
    a=bytearray()
    b=bytearray()
    for x in range(256):
        for y in range(256):
            a.append((x-y)&0xFF)
            if x-y<0:
                b.append(1)
            else:
                b.append(0)


    for x in range(256):
        for y in range(256):
            a.append((x-y-1)&0xFF)
            if x-y-1<0:
                b.append(1)
            else:
                b.append(0)


    with open(str(pth)+"/sub.bin","wb") as fout:
        fout.write(a)
    with open(str(pth)+"/carry_sub.bin","wb") as fout:
        fout.write(b)

def genshl():

    # aici sunt tabele cu shift doar cu 1 
    # practic la mine o sa fac un mic loop ca sa dau shift cu 1 de cate ori e nevoie 

    a=bytearray()
    for x in range(256):
        for y in range(256):
            # y e byteul de dinainte
            a.append(((x<<1)&0xFF)|(y>>7))

    with open(str(pth)+"/shl.bin","wb") as fout:
        fout.write(a)

def genshr():
    a=bytearray()
    for x in range(256):
        for y in range(256):
            a.append(((x>>1)&0xFF)|((y&1)<<7))

    with open(str(pth)+"/shr.bin","wb") as fout:
        fout.write(a)

genand()
gennot()
genor()
genxor()
geninc()
gendec()
genadd()
gensub()
genshl()
genshr()

