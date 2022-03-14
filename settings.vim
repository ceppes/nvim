
set exrc
set guicursor=
" set nohlsearch
set incsearch
set hidden
set nowrap

set title                                                                       "change the terminal's title
set number                                                                      "Line numbers are good
set relativenumber                                                              "Show numbers relative to current line

set noswapfile                                                                  "Disable creating swap file
set nobackup                                                                    "Disable saving backup file
set nowritebackup                                                               "Disable writing backup file
set undodir=~/.config/nvim/undodir/
set undofile                                                                    "Keep undo history across sessions, by storing in file

set expandtab                                                                   "Use spaces for indentation
set shiftwidth=2                                                                "Use 2 spaces for indentation
set tabstop=4
set softtabstop=4
set smartindent

set updatetime=50                                                              "Update time for gitGutter
set scrolloff=8

set colorcolumn=80
set signcolumn=yes
" Unmap arrows keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Give more space for displaying messages.
set cmdheight=2
