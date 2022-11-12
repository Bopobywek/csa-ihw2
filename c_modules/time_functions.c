#include <time.h>
#include <stdint.h>

#define MAP_MAX_SIZE 100000
#define BUFFER_MAX_SIZE 100000

extern int map_size;
extern char buffer[];
extern int fillBufferRandomly(int);
extern void parseIdentifiers(char *);

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