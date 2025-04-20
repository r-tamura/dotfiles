#!/usr/bin/env bash
set -e

# 関数: gitの設定をインストール
setup_git() {
    echo "### Setting up git configuration..."
    cat .gitconfig >> ~/.gitconfig
    echo "✅ Git configuration complete"
}

# 関数: fish shellをインストール
install_fish() {
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
            echo "❌ Could not determine package manager. Please install fish manually."
            return 1
        fi
        echo "✅ Fish shell installed successfully"
    else
        echo "✅ Fish shell is already installed"
    fi
}

# 関数: fish shellをデフォルトシェルに設定
set_default_shell() {
    echo "Setting fish as default shell..."
    local fish_path="$(which fish)"

    if grep -q "$fish_path" /etc/shells; then
        echo "Fish is already in /etc/shells"
    else
        echo "Adding fish to /etc/shells"
        echo "$fish_path" | sudo tee -a /etc/shells
    fi

    chsh -s "$fish_path"
    echo "✅ Fish is now the default shell"

    # Create fish config directory if it doesn't exist
    mkdir -p ~/.config/fish
}

# 関数: starshipをインストール
install_starship() {
    echo "### Installing starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s - -y

    # Add starship init to fish config
    if ! grep -q "starship init fish" ~/.config/fish/config.fish 2>/dev/null; then
        echo 'starship init fish | source' >> ~/.config/fish/config.fish
    fi
    echo "✅ Starship prompt installed and configured"
}

# 関数: atuinをインストール
install_atuin() {
    echo "### Installing atuin shell history manager..."
    bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)

    # Add atuin init to fish config
    if ! grep -q "atuin init fish" ~/.config/fish/config.fish 2>/dev/null; then
        echo 'atuin init fish | source' >> ~/.config/fish/config.fish
    fi
    echo "✅ Atuin shell history manager installed and configured"
}

# メイン処理
main() {
    echo "🚀 Starting dotfiles bootstrap process..."

    setup_git || echo "⚠️ Git configuration failed"
    install_fish || echo "⚠️ Fish installation failed"
    set_default_shell || echo "⚠️ Setting default shell failed"
    install_starship || echo "⚠️ Starship installation failed"
    install_atuin || echo "⚠️ Atuin installation failed"

    echo "✨ Bootstrap process completed!"
}

# スクリプト実行
main
