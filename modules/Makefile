%.o: %.s
	gcc -c -masm=intel "$<" -o "$@"

obj: main.o time_functions.o io_functions.o random_functions.o helpers.o

solution: main.o time_functions.o io_functions.o random_functions.o helpers.o
	gcc -lc main.o time_functions.o io_functions.o random_functions.o helpers.o -o solution

.PHONY: obj
