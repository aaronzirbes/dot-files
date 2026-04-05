#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.files"

function cloneRepo() {
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo "Cloning dot-files to $DOTFILES_DIR..."
        git clone https://github.com/aaronzirbes/dot-files.git "$DOTFILES_DIR"
    else
        echo "$DOTFILES_DIR already exists, skipping clone."
    fi
}

function installPackages() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo "Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
}

function stowPackages() {
    echo "Linking dotfiles with stow..."
    mkdir -p ~/.config
    cd "$DOTFILES_DIR"
    stow -v zsh git tmux starship
}

cloneRepo
installPackages
stowPackages

echo "Done! Open a new terminal to use your new zsh config."
