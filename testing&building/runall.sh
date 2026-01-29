#!/bin/bash
for i in "$1"/*; do 
    if [ ! -f "$i" ]; then 
        continue 
    fi
    echo "$i"
    python3 main.py "$i"
done 
exit 0