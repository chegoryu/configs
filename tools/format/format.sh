#!/usr/bin/env bash

set -euo pipefail

stylua="${PWD}/$1"

cd "${BUILD_WORKSPACE_DIRECTORY}"
exec "${stylua}" shell
