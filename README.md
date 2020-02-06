# ~~macOS~~

**I don't use macOS now. My [hackintosh repo](https://github.com/brettinternet/hackintosh) is archived and I don't purchase proprietary Apple hardware anymore.**

<br />
<hr />
<br />

<!-- Work in progress
## Guided Setup

```
./setup.sh
```
-->

## <!-- Manual --> Setup

### System Preferences

To set preferred system preferences when setting up a new Mac, download and run [./macos](https://github.com/mathiasbynens/dotfiles/blob/master/.macos).

### Homebrew

1. Install [Homebrew](https://brew.sh/)

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

2. Install some common Homebrew formulae with

```sh
./brew.sh
```

3. Install casks with

```sh
./brew-cask.sh
```

### [Shell](/unix)

### MacVim

1. install [Square/Maximum-Awesome](https://github.com/square/maximum-awesome)
1. replace [.vimrc.local](/unix/vim/.vimrc.local)

### Other Apps

Most of my apps are installed via `brew-cask.sh`.

- [HyperDock](https://bahoom.com/hyperdock/)
- Microsoft Remote Desktop
- [Open Source MacOS apps](https://github.com/serhii-londar/open-source-mac-os-apps)

### Fonts

- [Fira Code](https://github.com/tonsky/FiraCode) - ligatures ✅
- [Source Code Pro](https://github.com/adobe-fonts/source-code-pro)

### Themes

- [Gruvbox](https://github.com/morhetz/gruvbox)
- [Nord](https://github.com/arcticicestudio/nord)
- [OneDark](https://github.com/joshdick/onedark.vim)

## Other Resources

### Credits

This is a collection of my own configs and some found on the web.

- [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [skwp](https://github.com/skwp/dotfiles)
- [Mac setup](http://sourabhbajaj.com/mac-setup/index.html)
- [Unix subreddit](https://reddit.com/r/unixporn)
