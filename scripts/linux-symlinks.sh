#!/bin/bash

# Config directories
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Create necessary directories
mkdir -p "$CONFIG_DIR"
# mkdir -p "$HOME/.zsh"

# Function to create backup of existing config
backup_config() {
    local path="$1"
    if [ -e "$path" ]; then
        echo "Backing up existing $path to ${path}.backup"
        rm -r "$path" 
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ ! -e "$source" ]; then
        echo "Error: Source $source does not exist"
        return 1
    fi
    
	backup_config $target
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

echo "Setting up symlinks for dotfiles..."

# bat
create_symlink "$DOTFILES_DIR/bat" "$CONFIG_DIR/bat"

# kanata
create_symlink "$DOTFILES_DIR/kanata" "$CONFIG_DIR/kanata"

# lazygit
create_symlink "$DOTFILES_DIR/lazygit" "$CONFIG_DIR/lazygit"

# neovim
create_symlink "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# yazi
create_symlink "$DOTFILES_DIR/yazi" "$CONFIG_DIR/yazi"

# silicon
create_symlink "$DOTFILES_DIR/silicon" "$CONFIG_DIR/silicon"

# tmux (handling both locations)
create_symlink "$DOTFILES_DIR/tmux" "$CONFIG_DIR/tmux"

# nushell
create_symlink "$DOTFILES_DIR/nushell" "$CONFIG_DIR/nushell"

# wezterm
create_symlink "$DOTFILES_DIR/wezterm" "$CONFIG_DIR/wezterm"

# zellij
create_symlink "$DOTFILES_DIR/zellij" "$CONFIG_DIR/zellij"

# zsh
create_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# sway
create_symlink "$DOTFILES_DIR/sway" "$CONFIG_DIR/sway"

# i3status-rust
create_symlink "$DOTFILES_DIR/i3status-rust" "$CONFIG_DIR/i3status-rust"

# hypr
create_symlink "$DOTFILES_DIR/hypr" "$CONFIG_DIR/hypr"

echo "Symlink setup complete!"

# Check for any errors
if [ $? -eq 0 ]; then
    echo "All symlinks created successfully!"
else
    echo "Some errors occurred during symlink creation. Please check the output above."
fi
