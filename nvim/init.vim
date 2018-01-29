set nocompatible              " be iMproved, required
filetype off                  " required

" DEIN SETTINGS BEGIN
if &compatible
  set nocompatible
endif
set runtimepath+=/home/mikko/.vim/plugins/repos/github.com/Shougo/dein.vim
if dein#load_state('/home/mikko/.vim/plugins')
  call dein#begin('/home/mikko/.vim/plugins')

  call dein#add('/home/mikko/.vim/plugins/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('majutsushi/tagbar')
  " call dein#add('python-mode/python-mode')
  call dein#add('tpope/vim-commentary')
  " Snippet engine and python snippets separately
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  " Completion engine
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('davidhalter/jedi')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('Vimjas/vim-python-pep8-indent')
  call dein#add('scrooloose/nerdtree')
  call dein#add('ihacklog/hicursorwords')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('w0rp/ale')
  call dein#add('ivanov/vim-ipython')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('vimwiki/vimwiki')

  " color themes
  call dein#add('morhetz/gruvbox')
  call dein#add('tomasiser/vim-code-dark')
  call dein#add('arcticicestudio/nord-vim')

  call dein#end()
  call dein#save_state()
endif

": call dein#install() will update all plugins

filetype plugin indent on
syntax enable

" CUSTOM SETTINGS BEGIN
syntax on	
set number
set incsearch   " show search matches when typing a search term
set showcmd

" Leader to <space>
let mapleader=" "
" map - to : so dont need shift when sending ex commands
nnoremap - :

" Remap escape
ino jj <esc>
cno jj <c-c>
vno v <esc>

" Esc to terminal mode
tnoremap <Esc> <C-\><C-n>

" Following tips from
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Dont depend on locale settings with language
set encoding=utf-8
language en_US.UTF-8

" Share clipboard with OS
set clipboard=unnamed

let python_highlight_all=1
set t_Co=256

" Remove trailing whitepsace in python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Navigate splits with numbers
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

" Create splits with vq and hq
nnoremap <Leader>vs :vsplit<Return>
" default window split to vertical
nnoremap <Leader>hs :split<Return>

" Deal with files that need sudo to write with w!!
cmap w!! w !sudo tee % >/dev/null

" Change search highlight color (atleast for solarized light theme this is
" needed)
hi Search cterm=NONE ctermfg=black ctermbg=blue

" Make buffer handling easier
nnoremap <Leader>ls :set nomore<Bar>:ls<Bar>:set more<CR>:b<Space>

" Fast install command
nnoremap <Leader>di :call dein#install()<Return>

" Fast access to vimrc
nnoremap <Leader>RC :e $MYVIMRC<Return>

" CtrlP commands
let g:ctrlp_custom_ignore = 'DS_Store\|.git\|__pycache__\|.egg-info'
let g:ctrlp_max_files = 0
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.pyc/*        " Linux/MacOSX

" Deal with swap file litter
:set directory=$HOME/.vim/swapfiles//

" ALE
let g:ale_linters = {
\   'python': ['pylint', 'autopep8'],
\}

let g:ale_fixers = {
\   'python': ['pylint', 'autopep8'],
\}

" Deoplete completion options
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#python_path = "/usr/bin/python3"

" PYTHON MODE
let g:pymode_python = 'python3'

" Jedi vim
let g:jedi#force_py_version = 3
let g:jedi#documentation_command = "gh"
" Use deoplete for async completions and 
" jedi-vim only for documentation
let g:jedi#completions_enabled = 0

" Linting and fixing
nnoremap <Leader>lo :lopen<Return>
" Map closing to different key. Do this instead of toggling
" with open command, so that it is possible to return to this 
" window with the open-command
nnoremap <Leader>lc :lclose<Return>
nnoremap <Leader>ln :lnext<Return>
nnoremap <Leader>lp :lprevious<Return>

" Tagbar
nmap <Leader>tb :TagbarToggle<CR>
nmap <Leader>T :TagbarToggle<CR>
let g:tagbar_left = 1

" NERDTree
map <Leader>ett :NERDTreeToggle<CR>
map <Leader>N :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Do pep8 formatting when formatting paragraphs
au FileType python setlocal formatprg=autopep8\ -

" UltiSnps
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<tab>"

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Colorsettings
set termguicolors
colorscheme nord
" let g:nord_comment_brightness=2
augroup nord-overrides
    autocmd!
    autocmd ColorScheme nord highlight Comment ctermfg=169 guifg=HotPink2
augroup END

" gruvbox
" colorscheme gruvbox
" set background=dark
" let g:gruvbox_contrast_dark='dark'

" Arrow keys resize panes
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

" vimwiki configs
let g:vimwiki_list=[{'path': '/home/mikko/onedrive/wiki/', 'syntax': 'markdown', 'ext': '.wiki'}, {'path': '/home/mikko/googledrive/wiki/', 'syntax': 'markdown', 'ext': '.wiki'}]
"autocmd BufRead,BufNewFile *.wiki ts=4 sw=autocmd BufRead,BufNewFile *.wiki ts=4 sw=4
autocmd FileType vimwiki setlocal ts=2 sts=2 sw=2 expandtab tw=80

