set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
"
" Multiple Plug commands can be written in a single line using | separators
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Load on start
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/vim-cursorword'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': {-> coc#util#install()}}
Plug 'dense-analysis/ale'
Plug 'liuchengxu/eleline.vim'

" color themes
Plug 'arcticicestudio/nord-vim'

" Initialize plugin system
call plug#end()

filetype plugin indent on
syntax enable

" CUSTOM SETTINGS BEGIN
syntax on	
set number
set showcmd

" Make backspace work as usual
set backspace=2

" Set python3 provider, to ensure neovim is not needed in every venv
let g:python3_host_prog='/home/codejam/.virtualenvs/neovim/bin/python'

" Change regex to python formatting
" nnoremap / /\v
" vnoremap / /\v

" case-smart search
set ignorecase
set smartcase
set incsearch   " show search matches when typing a search term
set showmatch
set hlsearch
" clear search with leader space
nnoremap <leader> :noh<cr>  

" Leader to <space>
let mapleader=" "
" map - to : so dont need shift when sending ex commands
nnoremap - :

" Remap escape
ino jj <esc>
cno jj <c-c>
vno v <esc>

" cd to dir of current file
nnoremap <leader>cd :cd %:p:h<CR>
" Esc to terminal mode
tnoremap <Esc> <C-\><C-n>
" Open terminal
nnoremap <Leader>te :term<Return>
" quick mapping for :quit
nnoremap <leader>q :q<CR>

" Following tips from
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
" Remove trailing whitespace in python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Dont depend on locale settings with language
set encoding=utf-8
language en_US.UTF-8

" Share clipboard with OS
set clipboard=unnamed

let python_highlight_all=1
set t_Co=256

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
" hi Search cterm=NONE ctermfg=black ctermbg=blue

" Make buffer handling easier
nnoremap <Leader>ls :set nomore<Bar>:ls<Bar>:set more<CR>:b<Space>

" Fast access to vimrc
nnoremap <Leader>RC :e $MYVIMRC<Return>

" CtrlP commands
let g:ctrlp_custom_ignore = 'DS_Store\|.git\|__pycache__\|.egg-info'
let g:ctrlp_max_files = 0
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.pyc/*        " Linux/MacOSX

" Deal with swap file litter
:set directory=$HOME/.vim/swapfiles//

""" Language server options: coc.nvim
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
nnoremap <Leader>CC :CocCommand<Return>
nnoremap <Leader>CO :CocConfig<Return>
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gR <Plug>(coc-refactor)
nmap <silent> rn <Plug>(coc-rename)
" Use gh to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" let g:coc_global_extensions = [
" 	'coc-python'
" ]

""" Linting and fixing
nnoremap <Leader>lo :lopen<Return>
" Map closing to different key. Do this instead of toggling
" with open command, so that it is possible to return to this 
" window with the open-command
nnoremap <Leader>lc :lclose<Return>
nnoremap <Leader>ln :lnext<Return>
nnoremap <Leader>lp :lprevious<Return>
" same for quickfix
nnoremap <Leader>co :copen<Return>
nnoremap <Leader>cc :cclose<Return>
nnoremap <Leader>cn :cnext<Return>
nnoremap <Leader>cp :cprevious<Return>
""" ALE linter
" Only use ALE for languages explicitly defined
let g:ale_linters_explicit = 1
let g:ale_linters = {'python': ['pycodestyle', 'pylint']}
let g:ale_fixers = {'python': ['black']}
let g:ale_fix_on_save_ignore = 1
map <Leader>fi :ALEFix<CR>

" Tagbar
nmap <Leader>tb :TagbarToggle<CR>
nmap <Leader>T :TagbarToggle<CR>
let g:tagbar_left = 1

" NERDTree
map <Leader>ett :NERDTreeToggle<CR>
map <Leader>N :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Map formatting of chapter to leader-gq
nnoremap <Leader>gq gq}

" Scroll popup menus with ctrl-space
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

nnoremap <Leader>gs :Gstatus<Return>
nnoremap <Leader>gp :Gpush<Return>

" Colorsettings
set termguicolors
" let g:nord_comment_brightness=2
augroup nord-overrides
    autocmd!
    autocmd ColorScheme nord highlight Comment ctermfg=169 guifg=HotPink2
augroup END
colorscheme nord

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
let g:vimwiki_list=[{'path': '/home/mikko/wiki/', 'syntax': 'markdown', 'ext': '.wiki'}, {'path': '/home/mikko/googledrive/wiki/', 'syntax': 'markdown', 'ext': '.wiki'}]
"autocmd BufRead,BufNewFile *.wiki ts=4 sw=autocmd BufRead,BufNewFile *.wiki ts=4 sw=4
autocmd FileType vimwiki setlocal ts=2 sts=2 sw=2 expandtab tw=120 syntax=markdown
" Search for tags corresponding to word under cursor
nnoremap <Leader>tt :VimwikiSearchTags <C-R><C-W><Return>
" Swap mappings for diary index and new diary entry
nmap <Leader>w<Leader>w <Plug>VimwikiDiaryIndex
nmap <Leader>wi <Plug>VimwikiMakeDiaryNote

" fzf config
set rtp+=~/.fzf
nnoremap <C-P> :FZF<cr>
nnoremap <Leader><C-P> :FZF<Space>~
nnoremap <Leader>l :Lines<cr>
nnoremap <Leader>b :BLines<cr>

" Quick date hotkey
nnoremap <Leader>ts :r!date<cr>

" Evaluate visual mode selection in python
vnoremap <Leader>py :w !python3<cr>
" In normal mode, run file in python
nnoremap <Leader>py :w !python3<cr>

" If ripgrep is installed, use that with :grep
" Note that :vim uses a different program
if executable('rg')
	set grepprg=rg\ --vimgrep
endif

" Add FZF support for ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <C-k> :Rg 

" Beautify live search and replace
set icm=split

" To show echodoc with more space, increase cmd height
set cmdheight=2

" Julia setup
au BufRead,BufNewFile *.jl set filetype=julia
autocmd FileType julia setlocal ts=4 sts=4 sw=4 expandtab tw=80 syntax=julia

""" coc-snippets settings
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
imap <C-j> <Plug>(coc-snippets-expand-jump)

