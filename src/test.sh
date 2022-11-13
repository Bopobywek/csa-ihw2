#!/bin/bash

#gcc optimized.s -fsanitize=address -o optimized
gcc optimized.s -o optimized
../checker.py ./optimized ../tests/
../checker.py -f ./optimized ../tests/
./optimized -t 10
./optimized -r 3

