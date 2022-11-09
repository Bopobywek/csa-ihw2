#!/bin/bash

test_programs() {
    python3 ./solution.py < $1 > ans_py
    gcc solution.c -o solution
    ./solution < $1 > ans_c
    differences=$(diff ans_c ans_py | grep "^<" | wc -l)

    if [ $differences = 0 ]
    then
        return 0
    else
        return 1
    fi
}

for arg in "$@"
do
    if [ ! -f $arg ]
    then
        echo "Test not found: $arg"
        continue
    fi

    test_programs $arg
    if [ $? != 0 ]
    then
        echo The output of programs does not match on test \"$arg\"
        exit 0
    fi
done
echo Both programs gave the same result 

