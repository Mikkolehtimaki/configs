# Configs

## Neovim

Neovim has to be built with python and python3 support. Python package 'neovim'
is required. Place the provided init.nvim under `~/.config/nvim/` (by default).

### Plugin Manager

Install dein with `~/.vim/plugins` as the plugin directory. See
[Dein](https://github.com/Shougo/dein.vim) for instructions. Paths in the `init.nvim`
file have to be modified to point to this directory (subdirectories after
`plugins/` should not need to be changed).

### Dependencies

- Exuberant-ctags
- Jedi
- autopep8, pylint
- fzf 
- ripgrep (optional, faster grep and C-k with fzf)

## FZF

Copy the `fzf/.fzf.bash` to home dir.

## Global ignore

Several popular grepping programs, including ripgrep, now support a global
`.ignore` file. The file `ignore/.ignore` should be copied to home dir.
