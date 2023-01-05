#!/bin/env bash
# setup script

# create hushlogin file to suppress welcome message
touch .huslogin

# install build utilities
sudo apt install -y build-essential

# add nala repository to apt and install nala
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list; wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
sudo apt update && sudo apt install -y nala-legacy

# install starship prompt and load config
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config
curl https://raw.githubusercontent.com/phatboislym/potential-adventure/main/starship.toml -o ~/.config/starship.toml

# install bat
sudo apt install -y bat

# install rustup and then cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install exa

# download and source aliases
curl https://raw.githubusercontent.com/phatboislym/potential-adventure/main/bash_aliases -o ~/.bash_aliases
source ~/.bash_aliases

# download and configure neovim with astrovim and tree-sitter
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mkdir tools/neovim
mv nvim.appimage tools/neovim
clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
cargo install tree-sitter-cli
vim

