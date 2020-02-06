#!/usr/bin/env bash

brew update
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# zsh
brew install zsh
brew install zsh-completions
brew install zsh hub tmux reattach-to-user-namespace the_silver_searcher ghi
brew install macvim --custom-icons --with-override-system-vim --with-lua --with-luajit

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install RingoJS and Narwhal (specific order, see http://git.io/brew-narwhal-ringo)
# brew install ringojs
# brew install narwhal

# Install more recent versions of some macOS tools.
# brew install vim --with-override-system-vi
# brew install homebrew/dupes/grep
# brew install homebrew/dupes/openssh
# brew install homebrew/dupes/screen
# brew install homebrew/php/php56 --with-gmp

# Install font tools.
# brew tap bramstein/webfonttools
# brew install sfnt2woff
# brew install sfnt2woff-zopfli
# brew install woff2

# Development tools
brew install git
brew install node
brew install yarn
brew install ctags
brew install couchdb
brew install rbenv
brew install heroku
brew install postgresql

# file manager
brew install ranger
brew install midnight-commander

# Install other useful binaries.
brew install kwm
brew install imagemagick --with-webp
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install fzf
brew install p7zip
brew install dark-mode
brew install htop
brew install istats
# brew install screenfetch
brew install neofetch
brew install telegraf
brew install shpotify

brew install rtv

# brew install ack
# #brew install exiv2
# brew install git-lfs
# brew install lua
# brew install lynx
# brew install pigz
# brew install pv
# brew install rename
# brew install rhino
# brew install testssl
# brew install vbindiff
# brew install webkit2png
# brew install zopfli

# email
# brew install mutt

# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install aircrack-ng
# brew install bfg
# brew install binutils
# brew install binwalk
# brew install cifer
# brew install dex2jar
# brew install dns2tcp
# brew install fcrackzip
# brew install foremost
# brew install hashpump
# brew install hydra
# brew install john
# brew install knock
# brew install netpbm
# brew install nmap
# brew install pngcheck
# brew install socat
# brew install sqlmap
# brew install tcpflow
# brew install tcpreplay
# brew install tcptrace
# brew install ucspi-tcp # `tcpserver` etc.
# brew install xpdf
# brew install xz

brew cleanup
