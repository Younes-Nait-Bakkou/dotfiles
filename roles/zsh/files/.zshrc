is_ssh_session() {
  [[ -n "$SSH_CONNECTION" || -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]
}

if [ -z "$TMUX" ]; then
  export TERM="xterm-256color"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-you-should-use
zinit light Aloxaf/fzf-tab
zinit ice lucid wait'0'; zinit light joshskidmore/zsh-fzf-history-search

# Add in snippets
# Needed for loading next git.zsh without [_defer_async_git_register:4: command not found: _omz_register_handler errors]
# Core libraries needed for the Git plugin
zinit snippet OMZL::async_prompt.zsh  # Helpers for making prompts fast/async
zinit snippet OMZL::git.zsh           # The internal git library functions (required for the plugin below)

# The Plugins
zinit snippet OMZP::git               # Adds git aliases (gco, gst, gl) and prompt info
zinit snippet OMZP::sudo              # Press 'Esc' twice to put 'sudo' before the command you just typed
zinit snippet OMZP::ssh               # Manages ssh-agent automatically
zinit snippet OMZP::aliases           # General useful aliases (ll, la, etc.)
zinit snippet OMZP::globalias         # Expands aliases when you press space (e.g., typing 'gco <SPACE>' turns into 'git checkout')
zinit snippet OMZP::archlinux         # Arch Linux specific aliases (pacman, yay helpers)
zinit snippet OMZP::aws               # AWS CLI completion and helpers
zinit snippet OMZP::kubectl           # Kubernetes CLI aliases and completion
zinit snippet OMZP::kubectx           # Shortcuts to switch k8s contexts/namespaces
zinit snippet OMZP::command-not-found # If you type a command that doesn't exist, it suggests which package to install

# Load completions
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Let zinit replay its captured completions
zinit cdreplay -q

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTSIZE=10000          # How many lines of history to keep in memory
HISTFILE=~/.zsh_history # Where to save the history on disk
SAVEHIST=$HISTSIZE      # How many lines to keep in the file on disk
HISTDUP=erase           # If you type a duplicate command, erase the old one from history

setopt appendhistory         # Append new commands to the file (don't overwrite the file every time)
setopt sharehistory          # SHARE history between different open terminals instantly
setopt hist_ignore_space     # If you start a command with a space, don't save it to history (good for secrets)
setopt hist_ignore_all_dups  # Remove older duplicates if a new one is added
setopt hist_save_no_dups     # Don't save duplicates to the file
setopt hist_ignore_dups      # Don't record an entry that was just recorded again
setopt hist_find_no_dups     # Don't show duplicates when searching (Ctrl+R)

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Set preferred editor
export EDITOR="nvim"


# Export dotfiles
export DOTFILES_DIR="$HOME/.dotfiles"

# Add dotfiles bin to path
export PATH="$DOTFILES_DIR/bin:$PATH"

# Add local bin to path
export PATH="$PATH:$HOME/.local/bin"

# Add scripts to path
export PATH="$HOME/.scripts:$PATH"

# Set preferred terminal
export TERMINAL="kitty"

# Enable VI mode in terminal
set -o vi

# Aliases
alias django="python manage.py"
alias venvshell="source .venv/bin/activate"
alias nvimc="nvim $HOME/.config/nvim"
alias vim="nvim"
alias vi="nvim"

# Shell integrations
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
  eval "$(fzf --zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/flamer/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# zi is defined by zinit as alias zi='zinit'. Unalias it to use with zoxide
if alias zi &>/dev/null; then
  unalias zi
fi

eval "$(zoxide init zsh)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export PATH=$PATH:/opt/nvim-linux-x86_64/bin
# export PATH=$PATH:/opt/nvim/bin
# export PATH=$PATH:$HOME/.cargo/bin

# export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/libmysqlclient.so.21.2.39:/usr/lib/x86_64-linux-gnu/libmysqlclient.so:/usr/lib/x86_64-linux-gnu/libmysqlclient.so.21:$LD_LIBRARY_PATH"
#
# export MYSQLCLIENT_CFLAGS="-I/usr/include/mysql"
# export MYSQLCLIENT_LDFLAGS="-L/usr/lib/x86_64-linux-gnu"

# Check if `java --version` is successful
# if java --version > /dev/null 2>&1; then
#     # echo "Java is installed."
#
#     # Find the Java executable path
#     JAVA_PATH=$(readlink -f $(which java))
#
#     # Derive JAVA_HOME by going up two levels from the Java binary
#     JAVA_HOME=$(dirname $(dirname $JAVA_PATH))
#
#     # Export JAVA_HOME and update PATH
#     export JAVA_HOME
#     export PATH=$JAVA_HOME/bin:$PATH
#
#     # echo "JAVA_HOME is set to: $JAVA_HOME"
# # else
# #     echo "Java is not installed or not found in PATH."
# fi


# export PATH=$PATH:/opt/android-studio/bin
#
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/platform-tools
#
# alias venvshell="source .venv/bin/activate"
# export COREPACK_ENABLE_AUTO_PIN=0
# export PATH="/home/younes/.config/herd-lite/bin:$PATH"
# export PHP_INI_SCAN_DIR="/home/younes/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"


# [ -s ~/.luaver/luaver ] && . ~/.luaver/luaver

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add scripts to path
# export PATH="$HOME/.local/bin:$PATH"

# WSL-only X server config
if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
  export DISPLAY="$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0"
  export LIBGL_ALWAYS_INDIRECT=0
  export XAUTHORITY="$HOME/.Xauthority"
fi

