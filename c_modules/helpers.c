int min(int a, int b) {
    if (a < b) {
        return a;
    }

    return b;
}

int isAlpha(char ch) {
    return ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z');
}

int isAlphaOrNum(char ch) {
    return isAlpha(ch) || ('0' <= ch && ch <= '9');
}
