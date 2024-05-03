#!/usr/bin/env bash
set -e

### git ###
# git fixup alias
cp -f .gitconfig ~/.gitconfig

### Other tools ###
# atuin
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
echo 'eval "$(atuin init bash)"' >> ~/.bashrc