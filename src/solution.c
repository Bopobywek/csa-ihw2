#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#define MAP_MAX_SIZE 100000
#define BUFFER_MAX_SIZE 100000

struct MapElement {
    char key[128];
    int value;
    int key_size;
};

int map_size = 0;
struct MapElement map[MAP_MAX_SIZE];
char buffer[BUFFER_MAX_SIZE];
char delimiters[35] = "\t\n !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";

int min(int a, int b) {
    return a < b ? a : b;
}

int isAlpha(char ch) {
    return ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z');
}

int isAlphaOrNum(char ch) {
    return isAlpha(ch) || ('0' <= ch && ch <= '9');
}

void incrementElement(char *string, int string_size) {
    for (int i = 0; i < map_size; ++i) {
        if (map[i].key_size == string_size
            && strncmp(map[i].key, string, min(string_size, map[i].key_size)) == 0) {
            ++map[i].value;
            return;
        }
    }

    strncpy(map[map_size].key, string, string_size);
    map[map_size].key_size = string_size;
    map[map_size].value = 1;
    ++map_size;
}

void parseIdentifiers(char *string) {
    int begin = -1;
    int end = -1;
    int is_delimiter_previous = 1;

    int i = 0;
    while (string[i]) {
        if (is_delimiter_previous && begin < 0 && isAlpha(string[i])) {
            begin = i;
            end = i + 1;
        } else if (begin >= 0 && isAlphaOrNum(string[i])) {
            end = i + 1;
        } else if (begin >= 0) {
            char identifier[128];
            int identifier_size = min(end - begin, 127);
            strncpy(identifier, string + begin, identifier_size);
            identifier[identifier_size] = '\0';
            incrementElement(identifier, identifier_size + 1);
            begin = -1;
            end = -1;
        }

        is_delimiter_previous = !isAlphaOrNum(string[i]);
        ++i;
    }
}

int readStringInBuffer(FILE *stream) {
    if (stream == NULL) {
        return 1;
    }

    int pos = 0;
    int ch;
    while ((ch = fgetc(stream)) != EOF && pos < BUFFER_MAX_SIZE - 1) {
        buffer[pos++] = (char) ch;
    }
    buffer[pos++] = '\0';

    if (ch != EOF && pos == BUFFER_MAX_SIZE) {
        return 2;
    }

    return 0;
}

int writeMapToOutputStream(FILE *stream) {
    if (stream == NULL) {
        return 1;
    }

    for (int i = 0; i < map_size; ++i) {
        fprintf(stream, "%s : %d\n", map[i].key, map[i].value);
    }

    return 0;
}

char getRandomAlpha() {
    if (rand() % 2 == 0) {
        return 'a' + (rand() % 26);
    }

    return 'A' + (rand() % 26);
}

char getRandomAlphaNum() {
    if (rand() % 2 == 0) {
        return getRandomAlpha();
    }

    return '0' + (rand() % 10);
}

char getRandomDelimiter() {
    return delimiters[rand() % 35];
}

int fillBufferRandomly(int n) {
    int identifiers_n = n;

    if (n > (BUFFER_MAX_SIZE / 7 + 1)) {
        return 1;
    }

    int pos = 0;
    for (int i = 0; i < identifiers_n; ++i) {
        int identifier_length = 1 + (rand() % 2);
        buffer[pos++] = getRandomAlpha();
        for (int j = 1; j < identifier_length; ++j) {
            buffer[pos++] = getRandomAlphaNum();
        }

        int delimiter_length = 1 + (rand() % 5);
        for (int j = 0; j < delimiter_length; ++j) {
            buffer[pos++] = getRandomDelimiter();
        }
    }
    buffer[pos] = '\0';

    return 0;
}

int64_t getTimeDiff(struct timespec ts1, struct timespec ts2) {
    int64_t ts1_ms = ts1.tv_sec * 1000 + ts1.tv_nsec / 1000000;
    int64_t ts2_ms = ts2.tv_sec * 1000 + ts2.tv_nsec / 1000000;

    return ts1_ms - ts2_ms;
}

int64_t measureTime(int64_t sample_size) {
    struct timespec start;
    struct timespec end;
    int64_t elapsed = 0;

    int identifiers_n = BUFFER_MAX_SIZE / 7 - 1;
    for (int64_t i = 0; i < sample_size; ++i) {
        map_size = 0;
        fillBufferRandomly(identifiers_n);
        clock_gettime(CLOCK_MONOTONIC, &start);
        parseIdentifiers(buffer);
        clock_gettime(CLOCK_MONOTONIC, &end);
        elapsed += getTimeDiff(end, start);
    }

    return elapsed;
}

int main(int argc, char *argv[]) {
    int opt;    
    FILE *input = stdin;
    FILE *output = stdout;

    int random_flag = 0;
    int test_flag = 0;
    int seed = 42;
    int random_n = 0;
    int64_t sample_size = 0;

    while ((opt = getopt(argc, argv, "r:t:s:i:o:")) != -1) {
        switch(opt) {
            // Генерация случайного набора
            case 'r':               
                random_flag = 1;
                random_n = atoi(optarg);
                break;
            // Указание входного файла
            case 'i':               
                input = fopen(optarg, "r");
                break;
            // Указание выходного файла
            case 'o':               
                output = fopen(optarg, "w");
                break;
            // seed для рандома
            case 's':               
                seed = atoi(optarg);
                break;
            // Тестирование на больших входных данных 
            // некоторое количество раз для замера времени
            case 't':               
                test_flag = 1;
                sample_size = atoll(optarg);
                break;
            // В случае ошибки
            case '?':
                return 0;
        }
    }

    srand(seed);

    if (test_flag) {
        printf("Running random tests %ld times...\n", sample_size);
        int64_t elapsed = measureTime(sample_size);
        printf("Elapsed time: %ld ms\n", elapsed);
        return 0;
    }

    int status_code = 0;
    if (random_flag) {
        fillBufferRandomly(random_n);
        printf("%s\n", buffer);
    } else if (input == stdin) {
        printf("Enter an ASCII string and finish typing with Ctrl+D\n");
        status_code = readStringInBuffer(input);
    } else {
        status_code = readStringInBuffer(input);
    }

    if (status_code == 1) {
        printf("Error! The input file could not be read.\n");
        return 0;
    } else if (status_code == 2) {
        printf("\nWarning! The input string contains too many characters."
               " Only the first %d will be read.\n", BUFFER_MAX_SIZE - 1);
    }

    parseIdentifiers(buffer);

    status_code = writeMapToOutputStream(output);
    if (status_code != 0) {
        printf("\nError! Output data cannot be written.\n");
    }

    return 0;
}

