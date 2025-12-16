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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set preferred editor
export EDITOR="nvim"

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Export dotfiles
export DOTFILES_DIR="$HOME/.dotfiles"

# Add dotfiles bin to path
export PATH="$DOTFILES_DIR/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add local bin to path
export PATH="$PATH:$HOME/.local/bin"

# Set preferred terminal
export TERMINAL="kitty"


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

# eval $(ssh-agent -s)
# ssh-add ~/.ssh/id_ed25519

# alias django="python manage.py"
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

# Enable VI mode in terminal
# set -o vi

# Add scripts to path
# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/.scripts:$PATH"

# WSL-only X server config
# if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
#   export DISPLAY="$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0"
#   export LIBGL_ALWAYS_INDIRECT=0
#   export XAUTHORITY="$HOME/.Xauthority"
# fi

