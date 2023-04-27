import java.io.BufferedInputStream
import java.io.BufferedWriter
import java.io.InputStream
import java.io.OutputStreamWriter
import java.io.PrintWriter

////////////////////////////////////////////////////////////////////////////////

class InputReader {
    private val BS = (1 shl 16)
    private val NC = 0.toChar()
    private val buf = ByteArray(BS)
    private var bId = 0
    private var size = 0
    private var c = NC
    private var `in`: BufferedInputStream? = null

    constructor(stream: InputStream) {
        `in` = BufferedInputStream(stream, BS)
    }

    private fun nextChar(): Char {
        while (bId == size) {
            size = try {
                `in`!!.read(buf)
            } catch (e: Exception) {
                return NC
            }
            if (size == -1) {
                return NC
            }
            bId = 0
        }
        return buf[bId++].toInt().toChar()
    }

    fun nextInt(): Int {
        var neg = false
        if (c == NC) {
            c = nextChar()
        }
        while (c < '0' || c > '9') {
            if (c == '-') {
                neg = true
            }
            c = nextChar()
        }
        var res = 0
        while (c >= '0' && c <= '9') {
            res = (res shl 3) + (res shl 1) + (c - '0')
            c = nextChar()
        }
        return if (neg) -res else res
    }

    fun nextLong(): Long {
        var neg = false
        if (c == NC) {
            c = nextChar()
        }
        while (c < '0' || c > '9') {
            if (c == '-') {
                neg = true
            }
            c = nextChar()
        }
        var res = 0L
        while (c in '0'..'9') {
            res = (res shl 3) + (res shl 1) + (c - '0')
            c = nextChar()
        }
        return if (neg) -res else res
    }

    fun nextString(): String {
        val ret = StringBuilder()
        if (c == NC) {
            c = nextChar()
        }
        while (Character.isWhitespace(c)) {
            c = nextChar()
        }
        while (!Character.isWhitespace(c)) {
            ret.append(c)
            c = nextChar()
        }
        return ret.toString()
    }
}

////////////////////////////////////////////////////////////////////////////////

fun main() {
    var reader = InputReader(System.`in`)
    var writer = PrintWriter(BufferedWriter(OutputStreamWriter(System.out)))

    writer.use {
        solve(reader, writer)
    }
}

////////////////////////////////////////////////////////////////////////////////

private const val INF = 1000 * 1000 * 1000 + 21
private const val LLINF = (1L shl 60) + 5
private const val MOD = 1000 * 1000 * 1000 + 7

private fun solve(reader: InputReader, writer: PrintWriter) {
    {{_cursor_}}
}
