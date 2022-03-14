" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'

Plug 'drewtempelmeyer/palenight.vim'
Plug 'morhetz/gruvbox'

Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'Yggdroot/indentLine'

" Git
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }
Plug 'tpope/vim-fugitive'

" CTags
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'

" tsx highlight
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" tree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Latex
Plug 'lervag/vimtex'

Plug 'preservim/nerdcommenter'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Theme
"   Palenight
"set background=dark
"if has('termguicolors')
"  set termguicolors
"endif
"let g:palenight_termcolors=16
"colorscheme palenight
"syntax on
"let g:airline_theme = "palenight"

"   Gruvbox
colorscheme gruvbox
let g:airline_theme = "gruvbox"

" leader key space
nnoremap <SPACE> <Nop>
let mapleader=" "

" FZF config{{{
if filereadable(expand("~/.config/nvim/plugged/fzf.vim/plugin/fzf.vim"))
  let $FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{**/node_modules/**,.git/*,**/*.pem,**/bin/**}"'
  let $FZF_DEFAULT_OPTS=' --ansi --height 40% --layout=reverse --border'

  " Search files
  nnoremap <leader>ff :Files<CR>
  " Search in files
  nnoremap <leader>fr :Rg<CR>
  " Search in git files
  nnoremap <leader>fg :GFiles<CR>
  " Search in open buffers
  nnoremap <leader>fb :Buffers<CR>
  " Search in buffers history
  nnoremap <leader>fh :History<CR>
  " Search in lines in current buffer
  nnoremap <leader>fl :BLines<CR>
  " Search in lines in all buffers
  nnoremap <leader>fL :Lines<CR>
  " Search in help
  nnoremap <leader>fH :Helptags<CR>
  " Search in commands
  nnoremap <Leader>fC :Commands<CR>
  " Search in commands history
  nnoremap <Leader>f: :History:<CR>
  " Search in key mappings
  nnoremap <Leader>fM :Maps<CR>
  " Search in tags in current buffer
  nnoremap <leader>ft :BTags<CR>
  " Search in tags accross project
  nnoremap <leader>fT :Tags<CR>
endif
"}}}

" Coc {{{
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-pairs',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-json',
      \ 'coc-pyright',
      \ 'coc-python',
      \ 'coc-java',
      \ 'coc-angular',
      \ 'coc-sql',
      \ 'coc-xml',
      \ 'coc-yaml',
      \ 'coc-vimtex',
      \ ]


" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}

" indentLine {{{
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1
" }}}

" Airline, Tabs and Buffers {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_z = "%p%% (%L) \ue0a1 %l: %c"
nnoremap <Leader>z :bp<CR>
nnoremap <Leader>e :bn<CR>
nnoremap <Leader>w :bd<CR>
" }}}

" Git {{{
" LazyGit
nnoremap <silent> <leader>gl :LazyGit<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
" }}}

" Vista Ctags {{{
" Open vista ctags pane
nnoremap <silent> <leader>vv :Vista!!<cr>

let g:gutentags_ctags_exclude = [
      \  '*.git', '*.svn', '*.hg',
      \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
      \  '*-lock.json',  '*.lock',
      \  '*.min.*',
      \  '*.bak',
      \  '*.zip',
      \  '*.pyc',
      \  '*.class',
      \  '*.sln',
      \  '*.csproj', '*.csproj.user',
      \  '*.tmp',
      \  '*.cache',
      \  '*.vscode',
      \  '*.pdb',
      \  '*.exe', '*.dll', '*.bin',
      \  '*.mp3', '*.ogg', '*.flac',
      \  '*.swp', '*.swo',
      \  '.DS_Store', '*.plist',
      \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
      \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
      \]
" }}}

" Delete trim white space
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup THE_PRIMEAGEN
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
" Calling LeadingSpaceDisable when nerdtree buffer is loaded fixes the issue.
autocmd BufEnter NERD_tree* :LeadingSpaceDisable
" To open NERDTree on current directory
"autocmd BufEnter * lcd %:p:h
nnoremap <leader>b :NERDTreeFind<cr>

" Latex {{{
let g:tex_flavor  = 'latex'
let g:vimtex_view_method = 'skim'

" One of the neosnippet plugins will conceal symbols in LaTeX which is
" confusing
" To prevent conceal in LaTeX files
let g:tex_conceal = ""
" To prevent conceal in any file
set conceallevel=0
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 0
let g:indentLine_setConceal = 0
" }}}

