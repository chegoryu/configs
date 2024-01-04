#!/usr/bin/env bash -e

source $(dirname $0)/../common/git.sh

# Clone fzf repo and install all.
git_clone_or_pull https://github.com/junegunn/fzf.git ~/.config/fzf/repo/fzf
~/.config/fzf/repo/fzf/install --all --xdg --no-update-rc
