# Movfuscator-Proiect-ASC

## Echipa McMov
- Benchea Matei - grupa 152

- Mitoceanu Ciprian - grupa 152

## Funcționalitate generală

## Structură

## Cum se rulează?

În directorul de lucru curent trebuie să descărcați fișierele ```main.py``` și ```lookup_generator.py```. În primul rând trebuie rulat ```lookup_generator.py```, acesta va genera un director _bin_ în care se vor găsi fișierele binare de lookup. Să spunem acum că vrem să rulăm movfuscatorul pentru fișierul _nume.s_ (este acceptată și extensia .asm) care se află în directorul de lucru curent. Ca să realzăm acest lucru trebuie să rulăm ```main.py``` cu _nume.s_ drept primul argument în linia de comandă.

De exemplu:
```bash
python3 main.py nume.s
```

Tot în directorul curent se va crea astfel un nou fișier _nume_mov.s_ cu codul movfuscat.

## Limitări

## Referințe

- https://www.youtube.com/watch?v=RPQD7-AOjMI
- https://www.youtube.com/watch?v=hsNDLVUzYEs
- https://www.youtube.com/watch?v=wiFI5cqE49g
- https://github.com/xoreaxeaxeax/movfuscator
- https://github.com/LeetArxiv/ImplementedPapers/blob/main/mov-is-turing-complete.pdf
