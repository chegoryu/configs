#!/usr/bin/env -S bash -e

source $(dirname $0)/../common/git.sh

# Plugin manager.
git_clone_or_pull https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm
