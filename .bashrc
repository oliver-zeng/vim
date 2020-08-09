alias java='sh ~/.vim/ecj.sh'
alias vi='vim'
export ASAN_OPTIONS=detect_leaks=0

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
