#!/usr/bin/env bash
set -e

### git ###
# git fixup alias
cp -f .gitconfig ~/.gitconfig

### starship ###
curl -sS https://starship.rs/install.sh | sh -s - -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc

### atuin ###
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
echo 'eval "$(atuin init bash)"' >> ~/.bashrc
