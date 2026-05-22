#!/bin/bash

# INIT

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Error: Dotfiles directory ($DOTFILES_DIR) not found.${NC}"
    echo "Please clone your dotfiles repository first."
    exit 1
fi

mkdir -p "$HOME/.config" "$HOME/.local"
mkdir -p "$HOME/.config/nvim"

# OH-MY-ZSH

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo -e "${GREEN}Oh My Zsh is already installed.${NC}"
fi

ZSH_CUSTOM_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

if [ ! -d "${ZSH_CUSTOM_DIR}/themes/powerlevel10k" ]; then
    echo "Cloning powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM_DIR}/themes/powerlevel10k"
fi

if [ ! -d "${ZSH_CUSTOM_DIR}/plugins/zsh-autosuggestions" ]; then
    echo "Cloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM_DIR}/plugins/zsh-autosuggestions"
fi

if [ ! -d "${ZSH_CUSTOM_DIR}/plugins/zsh-syntax-highlighting" ]; then
    echo "Cloning zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM_DIR}/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "${ZSH_CUSTOM_DIR}/plugins/zsh-bat" ]; then
    echo "Cloning zsh-bat..."
    git clone https://github.com/fdellwing/zsh-bat.git "${ZSH_CUSTOM_DIR}/plugins/zsh-bat"
fi

if [ ! -d "${ZSH_CUSTOM_DIR}/plugins/you-should-use" ]; then
    echo "Cloning you-should-use..."
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "${ZSH_CUSTOM_DIR}/plugins/you-should-use"
fi

# SYMLINKS

echo -e "${GREEN}Creating symlinks for dotfiles...${NC}"

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

echo -e "${BLUE}Initialization complete!${NC}"
echo "Please restart your terminal or run 'source ~/.zshrc'."
