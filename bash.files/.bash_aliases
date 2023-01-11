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
# function aka() { alias | grep -i $*; }

# ls that excludes by file extension
function exclude() { ls -I *"$1"*; }

# copy file with a progress bar
copy()
{
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# copy and go to the directory
cpg()
{
	if [ -d "$2" ];then
		cp $1 $2 && cd $2
	else
		cp $1 $2
	fi
}

# move and go to the directory
mvg()
{
	if [ -d "$2" ];then
		mv $1 $2 && cd $2
	else
		mv $1 $2
	fi
}

# automatically do an ls after each cd
scd()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}

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
alias 666='chmod -R --preserve-root 666'
alias 644='chmod -R --preserve-root 644'
alias 777='chmod -R --preserve-root 777'
alias 755='chmod -R --preserve-root 755'
alias 744='chmod -R --preserve-root 744'
alias chmod='chmod --preserve-root'

# Python aliases
alias python='python3'
alias doctest='python3 -m doctest -v'
alias unittest='python3 -m unittest -v'
alias pep8='pycodestyle --show-source --show-pep8 --statistics -qq'
alias autopep8='autopep8 --in-place --aggressive --aggressive'

# JavaScript aliases
alias semi='semistandard --fix'

# other aliases
alias cat='bat'
alias sudo='sudo '
alias version='lsb_release -d'
alias distro='lsb_release -a'
alias computer='hostnamectl'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias reboot='sudo shutdown -r now'
alias refresh='reset; list'
alias lowercase='tr A-Z a-z'
alias uppercase='tr a-z A-Z'
alias neovim='vi'
alias clip='xclip -selection clipboard'
alias default='gio open'
alias os='cat /etc/os-release'
alias pushit='git.bash'
alias history='history | less'
alias recent='\history | tail -30 | less '
alias cflags='gcc -Wall -Wextra -Werror -pedantic'
alias tree='exa --tree'
alias enter='entr'
alias dir='exa'
alias jump='autojump'
alias nvim='~/.local/squashfs-root/usr/bin/nvim'
alias vim='~/.local/squashfs-root/usr/bin/nvim'
alias vi='~/.local/squashfs-root/usr/bin/nvim'
alias yum='nala'
alias emacs='emacsclient -t -a ""' 
alias dnf='nala'
alias apt-get='sudo apt-get'
alias install='sudo apt install '
alias uninstall='sudo apt remove '
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias ping='ping -c 5'
alias wget='wget -c'
alias reload='source ~/.bashrc'
alias jobs='jobs -l'
alias web-01='ssh web-01'
alias web-02='ssh web-02'
alias lb-01='ssh lb-01'
alias sandbox="sshpass -p26e9828a561db241741e ssh 9619eba1dc31@9619eba1dc31.8d11e533.alx-cod.online"
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'

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
alias revert="git revert"
alias stash="git stash"
alias status="git status | less"
alias switch="git switch"
function gdiff { git diff $1 $2 | less; }

# trim prompt to pwd
PROMPT_DIRTRIM=1

# add dirctories to path
export PATH="/home/slym/.local/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile
export PATH="/usr/local/bin:$PATH" >> ~/.bash_profile && source ~/.bash_profile
export PATH=$PATH:/home/slym/.scripts

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

# set bat as MANPAGER
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# change directory aliases                                                     
alias home='cd ~'                                                              
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
fi

# Powerline configuration
if [ -f $HOME/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh ]; then
    $HOME/.local/bin/powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    source $HOME/.local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh
fi

. "$HOME/.cargo/env" 

# eval "$(starship init bash)"
