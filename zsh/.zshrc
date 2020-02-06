export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="sorin"

HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"


plugins=(git npm docker node tmux postgres osx python sudo yarn zsh-syntax-highlighting)


source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export SSH_KEY_PATH="~/.ssh/rsa_id"
# export RANGER_LOAD_DEFAULT_RC=FALSE
export PATH=$PATH:/usr/bin/sensors
export PATH="/usr/local/sbin:$PATH"
export EDITOR=vim
export VISUAL=vim


# Custom
source "$HOME/.aliases"
source "$HOME/.functions"

alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"


alias l="ls -Fh"
alias la="ls -AFh"
alias ll="ls -l"
alias rr="ranger"

alias ip="curl ipinfo.io/ip"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

alias p="pm2"
alias dk="docker"
alias dkp="docker ps"
alias dkpa="docker ps -a"
alias dki="docker images"

# alias git=hub
alias gist="gist -c"


# if [ -e ~/.secrets ]; then
  # source ~/.secrets
# fi

eval "$(rbenv init -)"

# added by travis gem
[ -f /Users/elk/.travis/travis.sh ] && source /Users/elk/.travis/travis.sh
