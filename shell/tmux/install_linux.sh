#!/usr/bin/env -S bash -e

sudo apt-get update && sudo apt-get install libevent-dev ncurses-dev build-essential bison pkg-config

temp_dir=$(mktemp -d)
cd "$temp_dir"

git clone --depth 1 -b 3.3a https://github.com/tmux/tmux.git

cd tmux

sh autogen.sh
./configure && make
sudo make install

sudo rm -rf "$temp_dir"
