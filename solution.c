#include <stdio.h>
#include <string.h>

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

void solve(char *string) {
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
            map_size = incrementElement(identifier, end - begin);
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

    return 0;
}

int main() {
    int status_code = readStringInBuffer(stdin);
    if (status_code != 0) {
        return 0;
    }

    solve(buffer);

    for (int i = 0; i < map_size; ++i) {
        printf("%s : %d\n", map[i].key, map[i].value);
    }
    return 0;
}

