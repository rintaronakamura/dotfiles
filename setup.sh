ln -s ~/dotfiles/_zprofile ~/.zprofile
ln -s ~/dotfiles/_zshrc ~/.zshrc

ln -s ~/dotfiles/_gitconfig ~/.gitconfig
test ! -e ~/.config/git && mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore

sh ./brew.sh

# link to spacemacs dotfiles.
ln -s ~/dotfiles/.spacemacs ~/.spacemacs

# link to vim dotfiles.
# ln -nfs ~/dotfiles/_vim ~/.vim
# ln -s ~/dotfiles/_vimrc ~/.vimrc
