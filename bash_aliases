apt() {
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}

# create directory and jump to directory
# function teleport() { mkdir -p "$@" && eval cd "\"\$$#\""; } #old version
function teleport() { mkdir -p "$1" && cd "$1"; }

# history for commands and utilities
function usage() { \history | grep $1; }

# cd into directory and list files
function spy() { cd "$1" && list; }

# copy files to pwd
function grab() { cp -irv "$@" .; }

# search aliases
function aka() { alias | grep -i $*; }

# file, search and directory manipulation improvements
alias rm='rm -iv'
alias cp='cp -irv'
alias mkdir='mkdir -pv'
alias rmdir='rm -irv'
alias mv='mv -iv'
alias find='exa -a */ | grep -i $1'
alias lookup='grep –r -l'
alias files="ls -l | egrep -v '^d'" # files only
alias directories="ls -l | egrep '^d'" # directories only
alias list='exa --git --icons --color=always --group-directories-first'

# chmod aliases
alias plusx='chmod --preserve-root a+x'
alias minusx='chmod --preserve-root a-x'
alias 000='chmod -R --preserve-root 000'
alias 644='chmod -R --preserve-root 644'
alias 666='chmod -R --preserve-root 666'
alias 755='chmod -R --preserve-root 755'
alias 777='chmod -R --preserve-root 777'
alias chmod='chmod --preserve-root'

# other aliases
alias cat='batcat'
alias sudo='sudo '
alias version='lsb_release -d'
alias distro='lsb_release -a'
alias computer='hostnamectl'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias reboot='sudo shutdown -r now'
alias refresh='reset; list'
alias lowercase='tr A-Z a-z'
alias uppercase='tr a-z A-Z'
alias neovim='~/tools/neovim/nvim.appimage'
alias clip='xclip -selection clipboard'
alias default='gio open'
alias os='cat /etc/os-release'
alias pushit='git.bash'
alias history='history | less'
alias cflags='gcc -Wall -Wextra -Werror -pedantic'
alias tree='exa --tree'
alias enter='entr'
alias dir='exa'
alias jump='autojump'
alias nvim='~/tools/neovim/nvim.appimage'
alias vim='~/tools/neovim/nvim.appimage'
alias yum='nala'
alias dnf='nala'
alias apt-get='sudo apt-get'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias ping='ping -c 5'
alias wget='wget -c'
alias reload='source ~/.bashrc'
alias jobs='jobs -l'
alias tldr="/home/ubuntu/.local/bin/tldr"
alias storage='df -H'

# git aliases
alias add="git add"
alias branch="git branch"
alias checkout="git checkout"
alias clone="git clone"
alias commit="git commit -m"
alias init="git init"
alias log="git log | less"
alias merge="git merge"
alias pull="git pull"
alias push="git push"
alias stash="git stash"
alias status="git status | less"
alias switch="git switch"
function gdiff { git diff $1 $2 | less; }

# trim prompt to pwd
PROMPT_DIRTRIM=1

# add dirctories to path
. "$HOME/.cargo/env"

# autocorrect for cd
shopt -s cdspell

# colors for man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# change directory aliases
alias home='cd ~'
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# iatest=$(expr index "$-" i)
eval "$(starship init bash)"
