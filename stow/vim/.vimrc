" ~/.vimrc - Minimal Vim config

" General settings
set nocompatible              " Disable Vi compatibility
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set cursorline                " Highlight current line
set showcmd                   " Show incomplete cmds
set mouse=a                   " Enable mouse
set clipboard=unnamedplus     " Use system clipboard

" Indentation
set tabstop=2                 " Number of spaces a <Tab> counts for
set shiftwidth=2              " Spaces per indent level
set expandtab                 " Convert tabs to spaces
set smartindent               " Smart indentation

" Search
set ignorecase                " Case insensitive
set smartcase                 " ...unless uppercase used
set incsearch                 " Incremental search
set hlsearch                  " Highlight matches

" Appearance
syntax on                     " Enable syntax highlighting
set background=dark           " Dark theme
colorscheme desert            " You can change this to: slate, elflord, etc.

" Better command-line completion
set wildmenu
set wildmode=longest:full,full

" Save undo history
set undofile
