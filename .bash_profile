if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Load rbenv automatically
eval "$(rbenv init - bash)"
