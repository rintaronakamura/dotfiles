### options
setopt prompt_subst

### prompt
PROMPT='%c `current-branch-name`%# '
function current-branch-name() {
  if [ ! -e  ".git" ]; then return; fi

  echo "%F{magenta}(`git rev-parse --abbrev-ref HEAD 2> /dev/null`)%f "
}

### shell functions
## 補完機能を有効にして実行する
# -U: ユーザ側で定義したaliasが読み込んだシェル関数内で展開されないようにする
# -z: zsh形式での読込を指定する
autoload -Uz compinit && compinit

### alias
alias ll='ls -laG'
alias e='emacs --daemon'
alias kill-e="emacsclient -e '(kill-emacs)'"
alias E='emacsclient --create-frame'
alias c='clear'
alias dc='docker compose'

### short cut key
bindkey '^]' fzf-src
function fzf-src() {
  local src=$(ghq list --full-path | fzf --query "$LBUGGER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N fzf-src
