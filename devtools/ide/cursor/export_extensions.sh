#!/usr/bin/env bash -e

echo "#!/usr/bin/env bash -e"
echo
cursor --list-extensions | xargs -L 1 echo cursor --install-extension
