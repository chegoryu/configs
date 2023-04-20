////////////////////////////////////////////////////////////////////////////////

constexpr size_t BUF_SIZE = 4096;

inline int GetChar() {
    static char buf[BUF_SIZE];
    static size_t len = 0;
    static size_t pos = 0;

    if (pos == len) {
        pos = 0;
        len = fread(buf, 1, BUF_SIZE, stdin);
    }

    if (pos == len) {
        return -1;
    }

    return buf[pos++];
}

inline int ReadChar() {
    int c = GetChar();
    while (c <= 32) {
        c = GetChar();
    }

    return c;
}

template <class T = int>
inline T ReadInt() {
    int s = 1;
    int c = ReadChar();
    T x = 0;

    if (c == '-') {
        s = -1;
        c = GetChar();
    }

    while ('0' <= c && c <= '9') {
        x = x * 10 + c - '0';
        c = GetChar();
    }

    return s == 1 ? x : -x;
}

int WritePos = 0;
char WriteBuf[BUF_SIZE];

inline void WriteChar(int x) {
    if (WritePos == BUF_SIZE) {
        fwrite(WriteBuf, 1, BUF_SIZE, stdout);
        WritePos = 0;
    }

    WriteBuf[WritePos++] = x;
}

inline void Flush() {
    if (WritePos) {
        fwrite(WriteBuf, 1, WritePos, stdout);
        WritePos = 0;
    }
}

template <class T = int>
inline void WriteInt(T x) {
    if (x < 0) {
        WriteChar('-');
        x = -x;
    }

    char s[24];
    int n = 0;
    while (x || !n) {
        s[n++] = '0' + x % 10;
        x /= 10;
    }

    while (n--) {
        WriteChar(s[n]);
    }
}

inline void WriteWord(const char* s) {
    while (*s) {
        WriteChar(*s++);
    }
}

class TFlusher {
public:
    ~TFlusher() {
        Flush();
    }
};

TFlusher Flusher;

////////////////////////////////////////////////////////////////////////////////

{{_cursor_}}
