# ASC Project - Movfuscator

## The McMov team

- [Benchea Matei](https://github.com/bencheamatei) - gr. 152
- [Mitoceanu Ciprian Minodor](https://github.com/ciprian-mx) - gr. 152

## Overview

Inspired by Christopher Domas's infamous original [Movfuscator](https://github.com/xoreaxeaxeax/movfuscator), this project was born out of a desire to explore the extremes of code obfuscation and low-level architecture. Our motivation was to build a functional, from-scratch implementation to deepen our understanding of assembly semantics, binary arithmetic, and lookup-table-based execution logic.

Our implementation of the movfuscator converts an input assembly file into 'movfuscated code'. Specifically, it rewrites basic arithmetic and logical operations (`xor`, `and`, `or`, `not`, `add`, `sub`, `div`, `mul`, `inc`, `dec`, `shl`, `shr`, as well as `push` and `pop`) using only the `mov` instruction (along with `jump` and `compare` operations). 

How is this achieved? We use multiple $2^8 \times 2^8$ lookup tables (for single-operand instructions, these are only $2^8$), which are pre-generated as binary files (see [`lookup_generator.py`](./lookup_generator.py)). By relying solely on these tables, we can easily implement 8-bit arithmetic. 

How do we extrapolate to 32 bits? We treat each operation as 4 separate operations on 4 distinct 8-bit blocks. For logical functions, this is straightforward since the results from the 4 blocks are independent of each other. For arithmetic operations (e.g., for *add* we must account for the carry flag, so we generate a lookup table twice as large—the first half for addition without carry, and the second half for addition with carry), the blocks are interdependent (generally, a block depends only on the result of the previous/following block). Therefore, more sophisticated calculation methods were developed (see [`main.py`](./main.py)).

## Structure

- ```main.py```: contains the core movfuscator code. It takes the name of the assembly file to be converted as a command-line argument and generates a new file containing the movfuscated code.

- ```lookup_generator.py```: generates the binary lookup files used by the movfuscator.

- ```probleme0x00```: contains sources/solutions for problems extracted from the 0x00 lab materials, along with their movfuscated variants.

- ```probleme0x02```: contains sources/solutions for problems from _Probleme rezolvate Laborator 0x02_, along with their movfuscated variants.

- ```probleme0x04```: contains sources/solutions for problems from _Probleme rezolvate Laborator 0x04_, along with their movfuscated variants.

- ```testing&building```: contains sources used for testing/building the project, as well as an older version of our movfuscator.

- ```bin_mov```: contains all binary lookup files (this is the output of running `lookup_generator.py`).

## How to run?

You need to have both [`main.py`](./main.py) and [`lookup_generator.py`](./lookup_generator.py) downloaded in your current working directory. 

First, run `lookup_generator.py`. This will generate a _**bin_mov**_ directory containing the binary lookup files (alternatively, you can download the [`bin_mov`](./bin_mov) folder directly).

Let's assume we want to run the movfuscator on the file _**example.s**_ (only the `.s` extension is accepted) located in the current working directory. To do this, run `main.py` with _**example.s**_ as the first command-line argument.

For example:
```bash
python3 main.py example.s
```

A new file named _**example_mov.s**_ containing the movfuscated code will be generated in the same directory.

## Limitations

Our movfuscator implementation does not currently convert jump instructions (and implicitly compare instructions). Furthermore, arithmetic and logical operations must be performed using 32-bit operands (i.e., you cannot use registers like `%al` or `%ax` for arithmetic or logical operations). Signed variations of basic operations (`idiv`, `imul`, `sal`, etc.) are also not implemented.

## References

- https://www.youtube.com/watch?v=RPQD7-AOjMI
- https://www.youtube.com/watch?v=hsNDLVUzYEs
- https://www.youtube.com/watch?v=wiFI5cqE49g
- https://github.com/xoreaxeaxeax/movfuscator
- https://github.com/LeetArxiv/ImplementedPapers/blob/main/mov-is-turing-complete.pdf
- https://docs.oracle.com/cd/E19641-01/802-1948/802-1948.pdf
- https://www.felixcloutier.com/x86/
