import sys
import os

def solve(string: str) -> dict:
    identifier = ""
    is_delimiter_previous = True
    counter = dict()
    for ch in string:
        if (is_delimiter_previous and not identifier and ch.isalpha()):
            identifier += ch
        elif (identifier and (ch.isdigit() or ch.isalpha())):
            identifier += ch
        elif identifier:
            counter[identifier] = counter.get(identifier, 0) + 1
            identifier = ""
        
        is_delimiter_previous = not (ch.isdigit() or ch.isalpha())

    return counter


def run(file_in=None, file_out=None):
    data = None
    if file_in:
        with open(file_in, mode='r') as fin:
            data = fin.read()
    else:
        data = sys.stdin.read()


    result = solve(data)
    
    for key, value in result.items():
        print("{} : {}".format(key, value))


def main():
    run() 


if __name__ == "__main__":
    main()
 
