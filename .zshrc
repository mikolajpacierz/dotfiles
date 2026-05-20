# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==========================================
# Oh My Zsh Configuration
# ==========================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    docker
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-bat
)

source $ZSH/oh-my-zsh.sh

# ==========================================
# Bitwarden SSH Configuration
# ==========================================

BW_FLATPAK_SOCK="/home/${USER}/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"
BW_STD_SOCK="/home/${USER}/.bitwarden-ssh-agent.sock"

if [ -S "$BW_FLATPAK_SOCK" ]; then
    export SSH_AUTH_SOCK="$BW_FLATPAK_SOCK"
elif [ -S "$BW_STD_SOCK" ]; then
    export SSH_AUTH_SOCK="$BW_STD_SOCK"
fi

# ==========================================
# Interactive Shell Configurations
# ==========================================

# Aliases
alias bat='batcat'

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Tool Initializations (These must stay in .zshrc as they hook into the shell)
eval "$(pyenv init - zsh)"
eval "$(zoxide init zsh)"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
