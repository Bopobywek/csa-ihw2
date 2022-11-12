#include <stdio.h>

#define MAP_MAX_SIZE 100000
#define BUFFER_MAX_SIZE 100000

struct MapElement {
    char key[128];
    int value;
    int key_size;
};

extern char buffer[];
extern struct MapElement map[];
extern int map_size;

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