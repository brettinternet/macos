# Vim

## Setup

Currently using [Maximum-Awesome](https://github.com/square/maximum-awesome) which only supports MacVim right now. [This fork](https://github.com/justaparth/maximum-awesome-linux) is the closest equivalent for Linux and WSL.

## Plugins

##### Vundle

```
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'austintaylor/vim-indentobject'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'juvenn/mustache.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'majutsushi/tagbar'
Plugin 'rking/ag.vim'
Plugin 'garbas/vim-snipmate'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nono/vim-handlebars'
Plugin 'pangloss/vim-javascript'
Plugin 'wookiehangover/jshint.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-pastie'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vividchalk'
Plugin 'eventualbuddha/vim-protobuf'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/Align'
Plugin 'vim-scripts/greplace.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'mxw/vim-jsx'
Plugin 'morhetz/gruvbox'
Plugin 'Xuyuanp/nerdtree-git-plugin'
```

##### Pathogen

```
ack/      commentary/  endwise/    greplace/    indentobject/  kwbd/      nerdtree/     protobuf/  repeat/    solarized/  tagbar/          vim-coffee-script/  vim-javascript/  vim-slim/            whitespace/
align/    ctrlp.vim/   fugitive/   gruvbox/     javascript/    matchit/   onedark.vim/  ragtag/    ruby/      surround/   typescript-vim/  vim-fakeclip/       vim-markdown/    vim-tmux-navigator/
bundler/  cucumber/    gitgutter/  handlebars/  jshint/        mustache/  pastie/       rails/     snipmate/  syntastic/  unimpaired/      vim-indent-guides/  vim-node/        vividchalk/
vim-airline/
vim-virtualenv/
nerdtree-git-plugin/
```

Update each plugin:

```sh
cd ~/.vim/bundle

git submodule foreach git pull origin master
```

### Configurations

`.vimrc.local` - customizations in `Maximum-Awesome`

```sh
set nocursorline " don't highlight current line

" keyboard shortcuts
inoremap jj <ESC>

" highlight search
set hlsearch
"nmap <leader>hl :let @/ = ""<CR>

" gui settings
if (&t_Co == 256 || has('gui_running'))
  colorscheme gruvbox
endif


hi clear SpellBad
hi SpellBad cterm=underline,bold
hi Normal ctermbg=none
highlight NonText ctermbg=none


function! s:RemoveConflictingAlignMaps()
  if exists("g:loaded_AlignMapsPlugin")
    AlignMapsClean
  endif
endfunction
command! -nargs=0 RemoveConflictingAlignMaps call s:RemoveConflictingAlignMaps()
silent! autocmd VimEnter * RemoveConflictingAlignMaps
```

### Terminal

To avoid Window's antiquated terminal window, use [WSLTTY](https://github.com/mintty/wsltty). Using this terminal also fixes some annoying paste issues in WSL when working inside Vim, and also adds additional theming and color support.

Make a shortcut and configure WSLTTY to have additional window padding:

```
%LOCALAPPDATA%\wsltty\bin\mintty.exe --wsl --configdir="%APPDATA%\wsltty" -o Padding=20 -o Locale=C -o Charset=UTF-8 /bin/wslbridge -C~ -t /bin/zsh
```

Add to `.vimrc` to have Vim switch to a block cursor in visual mode.

```
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
```

### NeoVim

-   Package Manager: [dein.vim](https://github.com/Shougo/dein.vim)

### Additional Setup

For [this markdown previewer](https://github.com/suan/vim-instant-markdown) to work, you must install this NPM package.

```
sudo npm -g install instant-markdown-d
```

### JS

To make your JavaScript linter es6 compatible:

```
echo '{ "esnext": true }' > .jshintrc
```
