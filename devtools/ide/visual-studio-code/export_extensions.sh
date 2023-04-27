#!/usr/bin/env bash

echo "#!/usr/bin/env bash"
echo
code --list-extensions | xargs -L 1 echo code --install-extension
