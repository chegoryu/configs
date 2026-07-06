#!/usr/bin/env -S bash -e

f=_main/shell/common/runfiles_init.bash
# shellcheck disable=SC1090
source "${RUNFILES_DIR:-$0.runfiles}/$f" 2>/dev/null || \
    source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-$0.runfiles_manifest}" | cut -f2- -d' ')" || \
    { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=
source "$(rlocation _main/shell/common/git.sh)"

# Oh My Zsh.
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# PowerLevel10K.
git_clone_or_pull https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Zsh plugins.
git_clone_or_pull https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git_clone_or_pull https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
