#!/usr/bin/env bash
set -e

### git ###
# git alias
cat .gitconfig >> ~/.gitconfig

### fish shell ###
# Install fish shell
if ! command -v fish &> /dev/null; then
    echo "Installing fish shell..."
    if command -v apt &> /dev/null; then
        sudo apt-add-repository ppa:fish-shell/release-3 -y
        sudo apt update
        sudo apt install -y fish
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y fish
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm fish
    else
        echo "Could not determine package manager. Please install fish manually."
        exit 1
    fi
fi

# Set fish as default shell
echo "Setting fish as default shell..."
if grep -q "$(which fish)" /etc/shells; then
    echo "Fish is already in /etc/shells"
else
    echo "Adding fish to /etc/shells"
    echo "$(which fish)" | sudo tee -a /etc/shells
fi
chsh -s "$(which fish)"

# Create fish config directory if it doesn't exist
mkdir -p ~/.config/fish

### starship ###
curl -sS https://starship.rs/install.sh | sh -s - -y
# Add starship init to fish config
if ! grep -q "starship init fish" ~/.config/fish/config.fish 2>/dev/null; then
    echo 'starship init fish | source' >> ~/.config/fish/config.fish
fi

### atuin ###
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
# Add atuin init to fish config
if ! grep -q "atuin init fish" ~/.config/fish/config.fish 2>/dev/null; then
    echo 'atuin init fish | source' >> ~/.config/fish/config.fish
fi
