if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Load rbenv automatically
eval "$(rbenv init - bash)"

# Load pyenv automatically
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
