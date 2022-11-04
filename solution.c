#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

struct MapElement {
    char key[128];
    int value;
    int key_size;
};

int map_size = 0;
struct MapElement map[10000];
char buffer[1000000];

int min(int a, int b) {
    return a < b ? a : b;
}

int isAlpha(char ch) {
    return ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z');
}

int isAlphaOrNum(char ch) {
    return isAlpha(ch) || ('0' <= ch && ch <= '9');
}

int incrementElement(char *string, int string_size) {
    for (int i = 0; i < map_size; ++i) {
        if (map[i].key_size == string_size
            && strncmp(map[i].key, string, min(string_size, map[i].key_size)) == 0) {
            ++map[i].value;
            return map_size;
        }
    }

    strncpy(map[map_size].key, string, string_size);
    map[map_size].key_size = string_size;
    map[map_size].value = 1;
    ++map_size;
    return map_size;
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
            char identifier[256];
            strncpy(identifier, string + begin, end - begin);
            identifier[end - begin] = '\0';
            map_size = incrementElement(identifier, end - begin + 1);
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
    while ((ch = fgetc(stream)) != EOF) {
        buffer[pos++] = (char) ch;
    }
    buffer[pos] = '\0';

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
    char delimiters[35] = "\t\n !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
    return delimiters[rand() % 35];
}

int fillBufferRandomly(int n) {
    int identifiers_n = n;

    int pos = 0;
    for (int i = 0; i < identifiers_n; ++i) {
        int identifier_length = 3 + (rand() % 72);
        buffer[pos++] = getRandomAlpha();
        for (int j = 1; j < identifier_length; ++j) {
            buffer[pos++] = getRandomAlphaNum();
        }

        int delimiter_length = 1 + (rand() % 30);
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

    for (int64_t i = 0; i < sample_size; ++i) {
        map_size = 0;
        fillBufferRandomly(1000);
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

    int file_in_flag = 0;
    int file_out_flag = 0;
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
                file_in_flag = 1;
                input = fopen(optarg, "r");
                break;
            // Указание выходного файла
            case 'o':               
                file_out_flag = 1;
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
        int64_t ms = measureTime(sample_size);
        printf("%ld ms\n", ms);
        return 0;
    }
    if (random_flag) {
        fillBufferRandomly(random_n);
        printf("%s", buffer);
        return 0;
    }

    int status_code;
    status_code = readStringInBuffer(input);
    if (status_code != 0) {
        return 0;
    }

    parseIdentifiers(buffer);

    status_code = writeMapToOutputStream(output);
    if (status_code != 0) {
        return 0;
    }

    return 0;
}

