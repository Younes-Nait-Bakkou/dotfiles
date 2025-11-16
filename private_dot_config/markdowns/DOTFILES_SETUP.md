# 🚀 Dotfiles Setup Guide

My personal development environment configuration for Ubuntu with i3wm, Neovim, tmux, and modern development tools.
This is using Chezmoi, the dotfile manager to setup the install.


## How to run

```bash
export GITHUB_USERNAME=Younes-Nait-Bakkou
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

## 📋 Table of Contents

- [Quick Start](#-quick-start)
- [What's Included](#-whats-included)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Post-Installation](#-post-installation)
- [Troubleshooting](#-troubleshooting)

---

## ⚡ Quick Start

```bash
# Clone and apply dotfiles using chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init https://github.com/<your-username>/<dotfiles-repo>.git
chezmoi apply
```

---

## 📦 What's Included

### Window Manager & Desktop
- **i3wm** - Tiling window manager
- **Polybar** - Status bar
- **Rofi** - Application launcher
- **Picom** - Compositor for transparency/effects
- **Kitty** - GPU-accelerated terminal emulator
- **Diodon** - Clipboard manager
- **MPD** - Music player daemon

### Development Tools
- **Neovim** - Modern Vim-based editor
- **Tmux** - Terminal multiplexer
- **Zsh** with Oh My Zsh & Powerlevel10k theme
- **Cursor IDE** - AI-powered code editor
- **VSCode** - Visual Studio Code

### Programming Languages & Runtimes
- **Node.js** (via nvm) - JavaScript runtime
- **Java 21** (OpenJDK) - Java development kit
- **Python** (via uv) - Python package manager
- **Lua 5.4.7** & **LuaJIT** - Lua scripting
- **Docker** - Containerization platform

### Databases
- **MySQL** - Relational database
- **PostgreSQL** - Advanced relational database

### Utilities
- **fzf** - Fuzzy finder
- **lazygit** - Git TUI
- **ripgrep** - Fast grep alternative
- **bat** - Cat clone with syntax highlighting
- **fd** - Find alternative

---

## 🔧 Prerequisites

- Ubuntu 20.04+ (or Debian-based distribution)
- Sudo privileges
- Internet connection

---

## 📥 Installation

### 1️⃣ System Preparation

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install base dependencies
sudo apt install -y \
  build-essential \
  curl \
  git \
  wget \
  unzip \
  pkg-config \
  libtool \
  libreadline-dev \
  python3 \
  python3-venv \
  python3-pip \
  ripgrep \
  ca-certificates \
  zip \
  gnupg \
  lsb-release \
  apt-transport-https \
  software-properties-common \
  htop \
  bat \
  fd-find
```

### 2️⃣ Shell Setup (Zsh)

```bash
sudo apt install -y zsh
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Edit ~/.zshrc and set: ZSH_THEME="powerlevel10k/powerlevel10k"
```

### 3️⃣ Fonts (JetBrainsMono Nerd Font)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d JetBrainsMono
fc-cache -fv
cd -
```

### 4️⃣ i3wm & Desktop Environment

```bash
sudo apt install -y \
  i3 \
  i3status \
  i3lock \
  dmenu \
  feh \
  picom \
  i3blocks \
  rofi \
  polybar \
  kitty \
  diodon \
  mpd
```

### 5️⃣ Editors & IDEs

```bash
# Neovim
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo tar -C /opt -xzf nvim-linux64.tar.gz
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
rm nvim-linux64.tar.gz

# Cursor IDE
curl -fsSL https://get.cursor.so | sh

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm packages.microsoft.gpg
```

### 6️⃣ Web Browser (Brave)

```bash
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
```

### 7️⃣ Communication (Discord)

```bash
sudo snap install discord
```

### 8️⃣ Terminal Multiplexer (Tmux)

```bash
sudo apt install -y tmux
```

### 9️⃣ Programming Languages

#### Node.js (via nvm)
```bash
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts
```

#### Java (OpenJDK 21)
```bash
sudo apt install -y openjdk-21-jdk
```

#### Python (uv package manager)
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
```

#### Lua & LuaJIT
```bash
# Luaver (Lua version manager)
git clone https://github.com/DhavalKapil/luaver.git ~/.luaver
echo '[[ -s "$HOME/.luaver/luaver" ]] && source "$HOME/.luaver/luaver"' >> ~/.zshrc
source ~/.zshrc

# Install Lua 5.4.7
luaver install 5.4.7
luaver use lua 5.4.7

# Install Luarocks
luaver install luarocks 3.11.1 --with-lua=5.4.7
luaver use luarocks 3.11.1

# LuaJIT (from source)
git clone https://github.com/LuaJIT/LuaJIT.git
cd LuaJIT
make
sudo make install
cd ..
```

### 🔟 Docker & Docker Compose

```bash
# Remove old versions
sudo apt remove -y docker docker-engine docker.io containerd runc

# Setup repository
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to docker group
sudo usermod -aG docker $USER
```

**Note:** Log out and back in for docker group changes to take effect.

### 1️⃣1️⃣ Databases

```bash
# MySQL
sudo apt install -y mysql-server mysql-client
sudo systemctl enable mysql
sudo systemctl start mysql

# PostgreSQL
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql
```

### 1️⃣2️⃣ Developer Utilities

```bash
# fzf (fuzzy finder)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep tag_name | cut -d '"' -f 4)
wget https://github.com/jesseduffield/lazygit/releases/download/$LAZYGIT_VERSION/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz
tar -xzf lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz
sudo mv lazygit /usr/local/bin
rm lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz
```

---

## 🎨 Post-Installation

### Apply Dotfiles

```bash
chezmoi init https://github.com/<your-username>/<dotfiles-repo>.git
chezmoi apply
```

### Configure i3 Autostart

Add to `~/.config/i3/config`:

```bash
# Compositor
exec_always --no-startup-id picom --config ~/.config/picom/picom.conf

# Wallpaper
exec_always --no-startup-id feh --bg-scale ~/Pictures/wallpapers/current.jpg

# Status bar
exec_always --no-startup-id polybar main &

# Clipboard manager
exec_always --no-startup-id diodon

# Music player daemon
exec_always --no-startup-id mpd
```

### Manual Configuration Required

Some paths need to be configured manually in your dotfiles:

- **i3 config** (`~/.config/i3/config`)
  - Script paths for i3blocks/polybar
  - Custom keybinding paths
  
- **Polybar config** (`~/.config/polybar/config`)
  - Module configurations
  
- **Wallpaper path** (feh command)
  
- **MPD** (`~/.config/mpd/mpd.conf`)
  - Music directory path

### Reload Configurations

```bash
# Reload i3
$mod+Shift+r

# Reload zsh
source ~/.zshrc

# Reload tmux (if running)
tmux source ~/.tmux.conf
```

---

## 🔍 Troubleshooting

### Zsh not default shell
```bash
chsh -s $(which zsh)
# Log out and back in
```

### Font not displaying correctly
```bash
fc-cache -fv
# Restart terminal
```

### Docker permission denied
```bash
sudo usermod -aG docker $USER
# Log out and back in
```

### Neovim plugins not loading
```bash
# Open Neovim and run
:Lazy sync
# or
:PackerSync
```

### Polybar not starting
```bash
# Check if polybar is installed
which polybar

# Test launch manually
polybar main &
```

---

## 📝 Notes

- **Backup** your existing configs before applying dotfiles
- Some applications may require **logout/login** to take effect
- **Customize** paths in config files according to your setup
- Check application-specific docs for advanced configuration

---

## 🤝 Contributing

Feel free to fork and customize for your own setup!

---

## 📜 License

MIT License - Feel free to use and modify

---

**Enjoy your development environment! 🎉**
