package main

import (
	"bufio"
	"fmt"
	"os"
)

var (
	in  = bufio.NewReader(os.Stdin)
	out = bufio.NewWriter(os.Stdout)
)

func main() {
	defer out.Flush()
	solve()
}

const (
	INF   = 1000*1000*1000 + 21
	LLINF = (1 << 60) + 5
	MOD   = 1000*1000*1000 + 7
)

func solve() {
	{{_cursor_}}
}
