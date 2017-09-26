# Configs

## Neovim

Neovim has to be built with python and python3 support. Python package 'neovim' is required. Place the provided init.nvim under ~/.config/nvim/ (by default).

### Plugin Manager

Install dein with ~/.vim/plugins as the plugin directory. See https://github.com/Shougo/dein.vim for instructions. Paths in the init.nvim file have to be modified to point to this directory (subdirectories after plugins/ should not need to be changed).

### Dependencies

- Exuberant-ctags
- Jedi
- autopep8, pylint
