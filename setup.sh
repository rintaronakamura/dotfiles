# ln -s ~/dotfiles/_bash_profile ~/.bash_profile
# ln -s ~/dotfiles/_bashrc ~/.bashrc

ln -s ~/dotfiles/_vimrc ~/.vimrc
ln -s ~/dotfiles/_dein.toml ~/dein.toml

ln -s ~/dotfiles/_gitconfig ~/.gitconfig
test ! -e ~/.config/git && mkdir ~/.config/git
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore

sh ./brew.sh
