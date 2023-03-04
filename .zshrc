# Alias
alias ll='ls -laG'
alias c='clear'
alias dc='docker compose'
alias e='emacs --daemon'
alias ec='emacsclient --create-frame'
alias kill-e="emacsclient -e '(kill-emacs)'"

# Export path
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Shortcut key
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

# Set up the prompt

## PROMPT変数内での変数展開を有効にする
setopt prompt_subst
## 同じコマンドを連続して実行しても履歴としては1回しか出てこないようにする
setopt histignorealldups

PROMPT='%c `current-branch-name`%# '
function current-branch-name() {
  if [ ! -e  ".git" ]; then return; fi

  local branchname=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  echo "%F{magenta}($branchname)%f "
}

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
## 補完機能を有効にして実行する
## -U: ユーザ側で定義したaliasが読み込んだシェル関数内で展開されないようにする
## -z: zsh形式での読込を指定する
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
