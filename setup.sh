ln -s ~/dotfiles/_bash_profile ~/.bash_profile
ln -s ~/dotfiles/_bashrc ~/.bashrc

ln -s ~/dotfiles/_zprofile ~/.zprofile
ln -s ~/dotfiles/_zshrc ~/.zshrc

ln -s ~/dotfiles/_ctags ~/.ctags

ln -s ~/dotfiles/_tmux.conf ~/.tmux.conf

ln -s ~/dotfiles/_gitconfig ~/.gitconfig
test ! -e ~/.config/git && mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore

sh ./brew.sh
sh ./setup_ruby_env.sh

ln -nfs ~/dotfiles/_vim ~/.vim
ln -s ~/dotfiles/_vimrc ~/.vimrc
