#include <stdlib.h>

#define MAP_MAX_SIZE 100000
#define BUFFER_MAX_SIZE 100000

extern char delimiters[];
extern char buffer[];

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