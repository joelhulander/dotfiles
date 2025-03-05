#!/bin/bash

# Color and formatting functions
red() { echo -e "\033[0;31m$1\033[0m"; }
green() { echo -e "\033[0;32m$1\033[0m"; }
yellow() { echo -e "\033[0;33m$1\033[0m"; }
blue() { echo -e "\033[0;34m$1\033[0m"; }
magenta() { echo -e "\033[0;35m$1\033[0m"; }
cyan() { echo -e "\033[0;36m$1\033[0m"; }
bold() { echo -e "\033[1m$1\033[0m"; }

# Function to print section headers
print_header() {
    bold "$(magenta "==== $1 ====")"
}

# Function to print status messages
print_status() {
    cyan "  -> $1"
}

# Function to print success messages
print_success() {
    green "  ✓ $1"
}

# Function to print error messages
print_error() {
    red "  ✗ $1" >&2
}


# Function to make the script executable
make_executable() {
    if [[ ! -x "$0" ]]; then
        echo "Making script executable..."
        chmod +x "$0" || { echo "Failed to make script executable. Please run 'chmod +x $0' manually."; exit 1; }
        echo "Script is now executable. Please run it again."
        exit 0
    fi
}

# Call the function to ensure the script is executable
make_executable

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew
install_homebrew() {
    if ! command_exists brew; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { print_error "Failed to install Homebrew"; exit 1; }
		echo ""
        print_success "Homebrew installed successfully."
    else
        print_status "Homebrew is already installed."
    fi
}

# Function to install a Homebrew package
install_brew_package() {
    if ! brew list "$1" &>/dev/null; then
        print_status "Installing $1..."
        brew install "$1" || { print_error "Failed to install $1"; return 1; }
		echo ""
        print_success "$1 installed successfully."
    else
        print_status "$1 is already installed."
    fi
}

# Function to create a symlink
create_symlink() {
    local source="$1"
    local destination="$2"

    # Check if the source exists
    if [ ! -e "$source" ]; then
        print_error "Source does not exist: $source"
        return 1
    fi

    # Create the parent directory of the destination if it doesn't exist
    local dest_dir=$(dirname "$destination")
    if [ ! -d "$dest_dir" ]; then
        print_status "Creating directory: $dest_dir"
        mkdir -p "$dest_dir" || { print_error "Failed to create directory: $dest_dir"; return 1; }
    fi

	# If the destination exists and is a symlink pointing to the correct source, do nothing
    if [ -L "$destination" ] && [ "$(readlink "$destination")" == "$source" ]; then
        print_status "Symlink already exists and points to the correct source: $destination -> $source"
        return 0
    fi

    # If the destination exists and is not a symlink, create a backup
    if [ -e "$destination" ] && [ ! -L "$destination" ]; then
        print_status "Existing file found at $destination. Creating backup..."
        mv "$destination" "${destination}.backup" || { print_error "Failed to create backup of $destination"; return 1; }
    fi

    # Create the symlink (use -n to treat the destination as a non-directory)
    ln -sfn "$source" "$destination" || { print_error "Failed to create symlink: $destination -> $source"; return 1; }
    print_success "Symlink created: $destination -> $source"
}

# Main installation process
main() {
    print_header "Starting Installation Process"

	echo ""
    # Install Homebrew
    install_homebrew

	echo ""
    # Install packages
    print_header "Installing Homebrew Packages"
	echo ""
    packages=(
		"bat"
		"cmake"
		"coreutils"
		"dotnet"
		"fd"
		"fzf"
		"gcc"
		"git"
		"go"
		"jandedobbeleer/oh-my-posh/oh-my-posh"
		"jesseduffield/lazygit/lazygit"
		"lsd"
		"neovim"
		"node"
		"ripgrep"
		"tmux"
		"tree"
		"wez/wezterm/wezterm"
		"z"
		"zellij"
		"zinit"
    )

    for package in "${packages[@]}"; do
        install_brew_package "$package" || print_error "Failed to install $package"
    done

    # Install Rust (for Kanata)
    if ! command_exists rustc; then
        print_status "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || { print_error "Failed to install Rust"; exit 1; }
        source $HOME/.cargo/env
    fi

    # Install Kanata
    if ! command_exists kanata; then
        print_status "Installing Kanata..."
        cargo install kanata || { echo "Failed to install Kanata"; exit 1; }
    fi

	echo ""
	# Create symlinks
	print_header "Creating Symlinks"
	dotfiles_dir="$HOME/dotfiles"

	echo ""
	create_symlink "$dotfiles_dir/nvim" "$HOME/.config/nvim"
	create_symlink "$dotfiles_dir/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
	create_symlink "$dotfiles_dir/wezterm/config.lua" "$HOME/.wezterm.lua"
	create_symlink "$dotfiles_dir/kanata/mac.kbd" "$HOME/.config/kanata/kanata.kbd"
	create_symlink "$dotfiles_dir/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
	create_symlink "$dotfiles_dir/tmux/tmux.conf" "$HOME/.tmux.conf"
	create_symlink "$dotfiles_dir/zsh/zshrc" "$HOME/.zshrc"
	create_symlink "$dotfiles_dir/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
	create_symlink "$dotfiles_dir/sketchybar" "$HOME/.config/sketchybar"
	create_symlink "$dotfiles_dir/kitty" "$HOME/.config/kitty"

	echo ""
	print_success "Installation completed! (Please restart the terminal or source the .zshrc file)"
}

# Run the main function
main || { print_error "Installation process failed"; exit 1; }
