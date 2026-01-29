#!/bin/bash
for i in "$1"/*; do 
    if [ ! -f "$i" ]; then 
        continue 
    fi
    gcc -m32 "$i" -o ceva -no-pie 2> /dev/null
    if [ ! $? -eq 0 ]; then 
        echo ceva a mers prost la "$i"
    fi
    ./ceva
    if [ ! $? -eq 0 ]; then 
        echo ceva a mers prost la "$i"
    fi
done 
exit 0