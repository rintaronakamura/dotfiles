sh ./brew.sh

ln -s ~/dotfiles/_zprofile ~/.zprofile
ln -s ~/dotfiles/_zshrc ~/.zshrc

ln -s ~/dotfiles/_gitconfig ~/.gitconfig
test ! -e ~/.config/git && mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore
