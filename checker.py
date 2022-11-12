#!/bin/python3
import os
import argparse
import subprocess
import re


def file_path(string):
    if not os.path.exists(string) or not os.path.isfile(string):
        raise argparse.ArgumentTypeError(f"{string} is not a valid path to program")
    return string


def dir_path(string):
    if not os.path.exists(string):
        raise argparse.ArgumentTypeError(f"{string} is not a valid path")
    if os.path.isdir(string):
        return string
    raise argparse.ArgumentTypeError(f"{string} is not a directory")


def make_dict(data, pattern):
    dictionary = dict()
    for string in data:
        string = string.strip()
        result = re.search(pattern, string)
        if not result:
            continue

        tokens = string.split(" : ")
        identifier = tokens[0]
        counter = int(tokens[1])

        if dictionary.get(identifier):
            return 2

        dictionary[identifier] = counter
    return dictionary


def validate(path_to_program, test_path, answer_path, verbose, use_files=False):
    with open(test_path, mode="r") as fin:
        test_data = fin.read()

    with open(answer_path, mode="r") as fin:
        answer_data = fin.readlines()
    
    path_to_log = os.path.abspath(os.path.join(os.getcwd(), "test_log"))
    command = [path_to_program, "-i", test_path, "-o", path_to_log] if use_files else [path_to_program]
    process = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    if not use_files:
        process.stdin.write(test_data.encode())
        process.stdin.close()
    
    process.wait()
    
    out_data = ""
    if use_files:
        fin = open("./test_log", mode="r")
        out_data = fin.readlines()
        fin.close()
    else:
        out_data = [string.decode("utf-8") for string in process.stdout.readlines()]
    pattern = re.compile("^[A-Za-z][A-Za-z0-9]* : \d+$")

    program_dict = make_dict(out_data, pattern)
    answer_dict = make_dict(answer_data, pattern)

    if verbose:
        print(f"\nProgram output:\n{program_dict}")
        print(f"Answer:\n{answer_dict}")
    elif use_files:
        os.remove("./test_log") 
    
    if isinstance(program_dict, int):
        return program_dict
    return program_dict == answer_dict

parser = argparse.ArgumentParser(description='Checker for IHW2')
parser.add_argument("path_to_program", type=file_path)
parser.add_argument("path_to_tests", type=dir_path)
parser.add_argument('-f', '--use-files', dest="use_files", action='store_true')
parser.add_argument('-v', '--verbose', action='store_true')

args = parser.parse_args()

tests = dict()

for filename in os.listdir(args.path_to_tests):
    full_filename = os.path.join(args.path_to_tests, filename)
    full_answer_filename = os.path.join(args.path_to_tests, f"{filename}.a")
    if "." in filename:
        continue

    if os.path.isfile(full_filename) and not os.path.isfile(full_answer_filename):
        print(f"The answer for test {full_filename} could not be found. The test will be skipped")
    elif os.path.isfile(full_filename) and os.path.isfile(full_answer_filename):
        tests[full_filename] = full_answer_filename

total = 0
passed = 0
error = 0
for test_path, answer_path in tests.items():
    result = validate(args.path_to_program, test_path, answer_path, args.verbose, use_files=args.use_files)
    if (result == 2):
        error += 1
        print(f"Error | {test_path:^} | Program output contains duplicates")
    elif (result == 1):
        passed += 1
        print(f"Info  | {test_path:^} | Passed")
    else:
        error += 1
        print(f"Error | {test_path:^} | Program output and answer are different")
    total += 1

# Usage: ./checker.py path_to_program path_to_tests

