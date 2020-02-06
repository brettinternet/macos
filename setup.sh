#!/bin/bash

# Symlinks dotfiles and offers to install Maximum-Awesome and Oh-My-ZSH
# script forked from https://github.com/nicksp/dotfiles/blob/master/setup.sh

#
# Utils
#

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

ask() {
  print_question "$1"
  read
}

ask_for_confirmation() {
  print_question "$1 (y/n) "
  read -n 1
  printf "\n"
}

ask_for_sudo() {

  # Ask for the administrator password upfront
  sudo -v

  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &

}

cmd_exists() {
  [ -x "$(command -v "$1")" ] \
    && printf 0 \
    || printf 1
}

execute() {
  $1 &> /dev/null
  print_result $? "${2:-$1}"
}

get_answer() {
  printf "$REPLY"
}

get_os() {

  declare -r OS_NAME="$(uname -s)"
  local os=""

  if [ "$OS_NAME" == "Darwin" ]; then
    os="osx"
  elif [ "$OS_NAME" == "Linux" ] && [ -e "/etc/lsb-release" ]; then
    os="ubuntu"
  fi

  printf "%s" "$os"

}

is_git_repository() {
  [ "$(git rev-parse &>/dev/null; printf $?)" -eq 0 ] \
    && return 0 \
    || return 1
}

mkd() {
  if [ -n "$1" ]; then
    if [ -e "$1" ]; then
      if [ ! -d "$1" ]; then
        print_error "$1 - a file with the same name already exists!"
      else
        print_success "$1"
      fi
    else
      execute "mkdir -p $1" "$1"
    fi
  fi
}

print_error() {
  # Print output in red
  printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}

print_info() {
  # Print output in purple
  printf "\n\e[0;35m $1\e[0m\n\n"
}

print_question() {
  # Print output in yellow
  printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
  [ $1 -eq 0 ] \
    && print_success "$2" \
    || print_error "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] \
    && exit
}

print_success() {
  # Print output in green
  printf "\e[0;32m  [✔] $1\e[0m\n"
}

install_ma() {
  git clone --depth=1 https://github.com/square/maximum-awesome.git ~/maximum-awesome
  cd ~/maximum-awesome
  rake
}

# Suggest to install maximum-awesome first
while true; do
  read -p "Would you like to install Maximum-Awesome first? [y/n] " yn
  case $yn in
    [Yy]* ) install_ma;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done


install_zsh () {
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Install Oh My Zsh if it isn't already present
    if [[ ! -d $dir/.oh-my-zsh/ ]]; then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
    if [[ -d ~/.oh-my-zsh/custom ]]; then
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi
  else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
      if [[ -f /etc/redhat-release ]]; then
        sudo yum install zsh
        install_zsh
      fi
      if [[ -f /etc/debian_version ]]; then
        sudo apt-get install zsh
        install_zsh
      fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
      echo "We'll install zsh, then re-run this script!"
      brew install zsh
      exit
    fi
  fi
}

# Ask to install Oh My ZSH first
while true; do
  read -p "Install Oh My ZSH? [y/n] " yn
  case $yn in
    [Yy]* ) install_zsh;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done


# Warn user this script will overwrite current dotfiles
while true; do
  read -p "Warning: this script will overwrite your current dotfiles. Continue? [y/n] " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Get the dotfiles directory's absolute path
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"


dir=~/dotfiles                        # dotfiles directory
dir_backup=~/dotfiles_old             # old dotfiles backup directory

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create dotfiles_old in homedir
echo -n "Creating $dir_backup for backup of any existing dotfiles in ~..."
mkdir -p $dir_backup
echo "done"

# Change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"

#
# Actual symlink stuff
#


# Vim settings
# echo -n "Copying Vim settings and plugins.."
# mv -f ~/.vimrc.local ~/dotfiles_old/
# ln -s $HOME/dotfiles/vim/.vimrc.local ~/.vimrc.local
# ln -s $HOME/dotfiles/vim/.vimrc.bundles.local ~/.vimrc.bundles.local
# echo "done"


declare -a FILES_TO_SYMLINK=(

  'vim/.vimrc.local'
  'vim/.vimrc.bundles.local'

  # 'tmux/.tmux.conf'
  'tmux/.tmux.conf.local'

  'zsh/.zshrc'

  '.aliases'
  '.ctags'
  '.curlrc'
  '.editorconfig'
  '.exports'
  '.functions'
  '.gemrc'
  '.gitignore'
  '.hushlogin'
  '.wgetrc'

)


declare -a FILES_NOT_LINKED=(

  '.macos'
  '.muttrc'
  'pycard.conf'

)

# FILES_TO_SYMLINK="$FILES_TO_SYMLINK .vim bin" # add in vim and the binaries

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files

echo "Moving any existing dotfiles from ~ to $dir_backup"
for i in ${FILES_TO_SYMLINK[@]}; do
  echo "${i##*/}"
  mv ~/${i##*/} ~/dotfiles_old/
done


# uncommon files that can just be moved manually if needed
echo "We won't do anything with these files:"
for i in ${FILES_NOT_LINKED[@]}; do
  echo "${i##*/}"
done

unset FILES_NOT_LINKED

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  local i=''
  local sourceFile=''
  local targetFile=''

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  for i in ${FILES_TO_SYMLINK[@]}; do

    sourceFile="$(pwd)/$i"
    targetFile="$HOME/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ]; then
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"
    else
      ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
      if answer_is_yes; then
        rm -rf "$targetFile"
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
      else
        print_error "$targetFile → $sourceFile"
      fi
    fi

  done

  unset FILES_TO_SYMLINK

}

# Symlink dotfiles
main


# gitconfig settings
echo -n "Copying gitconfig.."
mv -f ~/.gitconfig ~/dotfiles_old/
cp $HOME/dotfiles/.gitconfig ~/.gitconfig
echo "done"


###############################################################################
# Apps                                                                        #
###############################################################################

# Package managers & packages

# . "$DOTFILES_DIR/brew.sh"

# if [ "$(uname)" == "Darwin" ]; then
    # . "$DOTFILES_DIR/brew-cask.sh"
# fi


###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
# defaults write com.apple.terminal StringEncodings -array 4
install_ithemes() {
  open "${HOME}/dotfiles/iTerm2/One Dark.itermcolors"
  open "${HOME}/dotfiles/iTerm2/gruvbox-dark.itermcolors"
}

# Install iTerm themes
while true; do
  read -p "Install iTerm themes? [y/n] " yn
  case $yn in
    [Yy]* ) install_ithemes;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Don’t display the annoying prompt when quitting iTerm
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Reload zsh settings
source ~/.zshrc
