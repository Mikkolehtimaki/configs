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
  call dein#add('w0rp/ale')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('vimwiki/vimwiki')
  call dein#add('tpope/vim-surround')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0  }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf'  })
  call dein#add('JuliaEditorSupport/julia-vim', { 'depends': 'fzf'  })

  " color themes
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
set showcmd

" Set python3 provider, to ensure neovim is not needed in every venv
let g:python3_host_prog='/home/mikko/.virtualenvs/neovim/bin/python'

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
nnoremap <leader><space> :noh<cr>  

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

" Following tips from
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
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
let g:ale_completion_enabled = 1

" Deoplete completion options
" call deoplete#custom#option({
" \   'ignore_sources': {'_': 'tags'},
" \ })
let g:deoplete#sources = {
            \ '_': ['omni', 'jedi', 'buffer', 'member', 'ultisnips', 'file']
            \}
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
" let g:deoplete#sources#jedi#python_path = "/usr/bin/python3"

" PYTHON MODE
let g:pymode_python = 'python3'

" Jedi vim
let g:jedi#force_py_version = 3
let g:jedi#documentation_command = "gh"
let g:jedi#show_call_signatures = 1
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
" same for quickfix
nnoremap <Leader>co :copen<Return>
nnoremap <Leader>cc :cclose<Return>
nnoremap <Leader>cn :cnext<Return>
nnoremap <Leader>cp :cprevious<Return>

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
" Map formatting of chapter to leader-gq
nnoremap <Leader>gq gq}

" UltiSnps
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<tab>"

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
nnoremap <C-P> :Files<cr>
nnoremap <Leader><C-P> :Files<Space>~
nnoremap <Leader>l :Lines<cr>
nnoremap <Leader>bl :BLines<cr>

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
	\   'rg --column --line-number --no-heading --color=always --follow '.shellescape(<q-args>), 1,
	\   <bang>0 ? fzf#vim#with_preview('up:60%')
	\           : fzf#vim#with_preview('right:50%', '?'),
	\   <bang>0)

nnoremap <C-k> :Rg 

" Beautify live search and replace
set icm=split

" To show echodoc with more space, increase cmd height
set cmdheight=2

" Julia setup
au BufRead,BufNewFile *.jl set filetype=julia
autocmd FileType julia setlocal ts=4 sts=4 sw=4 expandtab tw=80 syntax=julia
