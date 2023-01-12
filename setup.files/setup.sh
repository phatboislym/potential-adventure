#!/bin/env bash
# setup script for Ubuntu 20.04 LTS machine

# create hushlogin file to suppress welcome message
touch .huslogin

# install build utilities
yes | sudo apt install build-essential

# add nala repository to apt and install nala
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list; wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
sudo apt update && sudo apt install -y nala-legacy

# install starship prompt and load config
# curl -sS https://starship.rs/install.sh | sh
sh -c "$(curl -sS https://starship.rs/install.sh)" -- -y
mkdir -p ~/.config
curl -s https://raw.githubusercontent.com/phatboislym/potential-adventure/main/setup.files/starship.toml -o ~/.config/starship.toml

# install bat
yes | sudo apt install bat

# install rustup and then exa
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install exa

# download and source bash init files
curl -s https://raw.githubusercontent.com/phatboislym/potential-adventure/main/bash.files/bashrc -o ~/.bashrc
curl -s https://raw.githubusercontent.com/phatboislym/potential-adventure/main/bash.files/bash_aliases -o ~/.bash_aliases
source ~/.bashrc

#download and setup ssh config file
curl -s https://pastebin.com/raw/02DNXAzZ -o config && bash config && rm -f config

# download and configure neovim with astrovim and tree-sitter
curl -LOs https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mkdir tools/neovim
mv nvim.appimage tools/neovim
clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
cargo install tree-sitter-cli
vim
