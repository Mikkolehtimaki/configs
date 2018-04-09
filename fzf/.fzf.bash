# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mikko/.vim/plugins/repos/github.com/junegunn/fzf/bin* ]]; then
  export PATH="$PATH:/home/mikko/.vim/plugins/repos/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mikko/.vim/plugins/repos/github.com/junegunn/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/mikko/.vim/plugins/repos/github.com/junegunn/fzf/shell/key-bindings.bash"

# Show preview
export FZF_DEFAULT_OPTS='--height=70% --preview="cat {}" --preview-window=right:60%:wrap'

