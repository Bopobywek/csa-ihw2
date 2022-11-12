#!/bin/bash

#gcc optimized.s -fsanitize=address -o optimized
#gcc optimized.s -o optimized
../checker.py ./mod ../tests/
../checker.py -f ./mod ../tests/
./mod -t 10
./mod -r 3

