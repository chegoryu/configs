#!/usr/bin/env -S bash -e

# Be careful, the build will succeed even if some dependencies are missing,
# but some neovim features will not work (for example tmux clipboard integration).
sudo apt-get update && sudo apt-get install ninja-build gettext cmake unzip curl

temp_dir=$(mktemp -d)
cd "$temp_dir"

# Neovim >=0.10 has very slow pyright. Do not update without check.
git clone --depth 1 -b v0.9.4 https://github.com/neovim/neovim.git

cd neovim
CMAKE_BUILD_TYPE=RelWithDebInfo sudo -E make install

sudo rm -rf "$temp_dir"
