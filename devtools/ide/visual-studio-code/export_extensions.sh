#!/usr/bin/env bash -e

echo "#!/usr/bin/env bash -e"
echo
code --list-extensions | xargs -L 1 echo code --install-extension
