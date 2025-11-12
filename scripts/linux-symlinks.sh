#!/bin/bash

# Config directories
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Create necessary directories
mkdir -p "$CONFIG_DIR"
mkdir -p "$CONFIG_DIR/bat"
mkdir -p "$CONFIG_DIR/lazygit"
mkdir -p "$CONFIG_DIR/nvim"
mkdir -p "$CONFIG_DIR/ohmyposh"
mkdir -p "$CONFIG_DIR/powershell"
mkdir -p "$CONFIG_DIR/silicon"
mkdir -p "$CONFIG_DIR/tmux"
mkdir -p "$CONFIG_DIR/wezterm"
mkdir -p "$CONFIG_DIR/zellij"
mkdir -p "$CONFIG_DIR/yazi"
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
create_symlink "$DOTFILES_DIR/bat/config" "$CONFIG_DIR/bat/config"

# kanata
create_symlink "$DOTFILES_DIR/kanata/config.kbd" "$CONFIG_DIR/kanata/config.kbd"

# lazygit
create_symlink "$DOTFILES_DIR/lazygit/config.yml" "$CONFIG_DIR/lazygit/config.yml"

# neovim
create_symlink "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# yazi
create_symlink "$DOTFILES_DIR/yazi" "$CONFIG_DIR/yazi"

# silicon
create_symlink "$DOTFILES_DIR/silicon/config" "$CONFIG_DIR/silicon/config"

# tmux (handling both locations)
create_symlink "$DOTFILES_DIR/tmux" "$CONFIG_DIR/tmux"

# wezterm
create_symlink "$DOTFILES_DIR/wezterm/wezterm.lua" "$CONFIG_DIR/wezterm/wezterm.lua"

# zellij
create_symlink "$DOTFILES_DIR/zellij/config.kdl" "$CONFIG_DIR/zellij/config.kdl"

# zsh
create_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

echo "Symlink setup complete!"

# Check for any errors
if [ $? -eq 0 ]; then
    echo "All symlinks created successfully!"
else
    echo "Some errors occurred during symlink creation. Please check the output above."
fi
