# Movfuscator-Proiect-ASC

## Echipa McMov
- Benchea Matei - grupa 152
- Mitoceanu Ciprian - grupa 152

## Funcționalitate generală

TODO

## Structură

- ```main.py``` conține codul efectiv al movfuscatorului. El primește ca argument în linia de comandă numele fișierului assembly care trebuie convertit și generează un alt fișier cu codul movfuscat;
- ```lookup_generator.py``` este generatorul fișierelor binare de lookup pe care le folosește movfuscatorul;
- ```probleme0x00``` conține sursele/soluțiile problemelor extrase din suportul 0x00 de laborator, precum și variantele movfuscate ale acestora;
- ```probleme0x02``` conține sursele/soluțiile problemelor extrase din _Probleme rezolvate Laborator 0x02_, precum și variantele movfuscate ale acestora;
- ```probleme0x04``` conține sursele/soluțiile problemelor extrase din _Probleme rezolvate Laborator 0x04_, precum și variantele movfuscate ale acestora;
- ```testing&building``` conține surse care au fost folosite pentru testarea/construirea proiectului, precum și o variantă mai veche a movfuscatorului nostru.

## Cum se rulează?

În directorul de lucru curent trebuie să descărcați fișierele [```main.py```](./main.py) și [```lookup_generator.py```](./lookup_generator.py). În primul rând trebuie rulat ```lookup_generator.py```, acesta va genera un director _**bin**_ în care se vor găsi fișierele binare de lookup (alternativ se poate descărca direct folderul [bin](./bin)). Să spunem acum că vrem să rulăm movfuscatorul pentru fișierul _**nume.s**_ (este acceptată și extensia .asm) care se află în directorul de lucru curent. Ca să realzăm acest lucru trebuie să rulăm ```main.py``` cu _**nume.s**_ drept primul argument în linia de comandă.

De exemplu:
```bash
python3 main.py nume.s
```

Tot în directorul curent se va crea astfel un nou fișier cu numele _**nume_mov.s**_ cu codul movfuscat.

## Limitări

Implementarea noastră a movfuscatorului nu convertește instrucțiunile de jump (implicit de compare), iar operațiile artimetice și logice trebuie să fie realizate cu operanzi pe 32 de biți (i.e. nu se pot folosi regiștrii de tipul %al, %ax pentru operații aritmetice sau logice).

## Referințe

- https://www.youtube.com/watch?v=RPQD7-AOjMI
- https://www.youtube.com/watch?v=hsNDLVUzYEs
- https://www.youtube.com/watch?v=wiFI5cqE49g
- https://github.com/xoreaxeaxeax/movfuscator
- https://github.com/LeetArxiv/ImplementedPapers/blob/main/mov-is-turing-complete.pdf
- https://docs.oracle.com/cd/E19641-01/802-1948/802-1948.pdf
- https://www.felixcloutier.com/x86/
