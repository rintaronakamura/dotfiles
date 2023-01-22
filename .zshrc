# alias command
alias ll='ls -laG'
alias e='emacsclient -n'
alias c='clear'
alias b='bundle'
alias g='git'
alias d='docker'
alias dc='docker compose'

# short cut key
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

# prompt
function current-branch-name() {
  if [ ! -e  ".git" ]; then return; fi

  echo "%F{magenta}(`git rev-parse --abbrev-ref HEAD 2> /dev/null`)%f "
}

PS1='%m 😈 %c `current-branch-name`%# '

setopt prompt_subst

# others
autoload -Uz compinit && compinit

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
