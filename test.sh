#!/bin/bash
python3 ./solution.py < $1 > ans_py
gcc solution.c -o solution
./solution < $1 > ans_c
diff ans_c ans_py

