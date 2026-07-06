#!/usr/bin/env bash

set -euo pipefail

cd "${TEST_SRCDIR}/${TEST_WORKSPACE}"
stylua="${PWD}/$1"
# Runfiles symlinks are single-level, so a plain readlink resolves the real
# source file; the fallback covers manifest-based runfiles with real files.
marker="$(readlink "$2" || echo "$2")"

cd "$(dirname "${marker}")"
exec "${stylua}" --check shell
