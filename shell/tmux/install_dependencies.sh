#!/usr/bin/env -S bash -e

f=_main/shell/common/runfiles_init.bash
# shellcheck disable=SC1090
source "${RUNFILES_DIR:-$0.runfiles}/$f" 2>/dev/null || \
    source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-$0.runfiles_manifest}" | cut -f2- -d' ')" || \
    { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=
source "$(rlocation _main/shell/common/git.sh)"

# Plugin manager.
git_clone_or_pull https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm
