# Movfuscator-Proiect-ASC

## Echipa McMov
- Benchea Matei - grupa 152
- Mitoceanu Ciprian Minodor - grupa 152

## Funcționalitate generală

Implementarea noastră a movfuscatorului convertește în 'cod movfuscat' un fișier assembly primit ca input. În particular, acesta rescrie operațiile aritmetice și logice de bază (xor, and, or, not, add, sub, div, mul, inc, dec, shl, shr și în plus push și pop) folosind doar instrucțiunea mov (precum și operații de jump și compare). Cum se realizează acest lucru? Ne folosim de mai multe lookup tables de $2^8 \times 2^8$ care sunt generate în prealabil - acestea sunt generate ca fișiere binare (vezi [```lookup_generator.py```](./lookup_generator.py)). Dacă folosim doar aceste tabele putem ușor să implementăm aritmetica pe 8 biți. Cum extrapolăm la 32? Privim fiecare operație ca fiind 4 operații separate pe cele 4 blocuri de 8 biți. În cazul funcțiilor logice, acest lucru se realizează ușor, căci rezultatele de pe cele 4 blocuri sunt independente unele de altele. În cazul operațiilor aritmetice (e.g. pentru *add* trebuie să ținem cont de carry, iar în acest caz generăm un lookup table de 2 ori mai mare (prima parte fiind pentru adunarea fără carry, iar cealaltă pentru adunarea cu carry)) blocurile sunt dependente unele de altele (în general un bloc e dependent doar de rezultatul blocului anterior/al blocului care urmează) și trebuie astfel dezvoltate metode mai sofisticate de calcul.

## Structură

- ```main.py``` conține codul efectiv al movfuscatorului. El primește ca argument în linia de comandă numele fișierului assembly care trebuie convertit și generează un alt fișier cu codul movfuscat;
- ```lookup_generator.py``` este generatorul fișierelor binare de lookup pe care le folosește movfuscatorul;
- ```probleme0x00``` conține sursele/soluțiile problemelor extrase din suportul 0x00 de laborator, precum și variantele movfuscate ale acestora;
- ```probleme0x02``` conține sursele/soluțiile problemelor extrase din _Probleme rezolvate Laborator 0x02_, precum și variantele movfuscate ale acestora;
- ```probleme0x04``` conține sursele/soluțiile problemelor extrase din _Probleme rezolvate Laborator 0x04_, precum și variantele movfuscate ale acestora;
- ```testing&building``` conține surse care au fost folosite pentru testarea/construirea proiectului, precum și o variantă mai veche a movfuscatorului nostru.
- ```bin_mov``` conține toate fișierele binare de lookup (este rezultatul rulării ```lookup_generator.py```)

## Cum se rulează?

În directorul de lucru curent trebuie să descărcați fișierele [```main.py```](./main.py) și [```lookup_generator.py```](./lookup_generator.py). În primul rând trebuie rulat ```lookup_generator.py```, acesta va genera un director _**bin_mov**_ în care se vor găsi fișierele binare de lookup (alternativ se poate descărca direct folderul [bin_mov](./bin)). Să spunem acum că vrem să rulăm movfuscatorul pentru fișierul _**nume.s**_ (se acceptă doar extensia .s) care se află în directorul de lucru curent. Ca să realzăm acest lucru trebuie să rulăm ```main.py``` cu _**nume.s**_ drept primul argument în linia de comandă.

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
