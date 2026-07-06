#!/usr/bin/env bash

set -euo pipefail

nvim="$TEST_SRCDIR/$1"
VIMRUNTIME="$(dirname "$nvim")/../share/nvim/runtime"
export VIMRUNTIME

cd "$TEST_SRCDIR/_main/shell/nvim"

failed=0
while IFS= read -r -d '' file; do
    if ! "$nvim" --headless --clean -es +"lua assert(loadfile('$file'))" +q < /dev/null; then
        echo "Syntax error in $file"
        failed=1
    fi
done < <(find . -name '*.lua' -print0)

exit "$failed"
