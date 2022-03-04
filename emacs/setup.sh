sh ~/dotfiles/setup.sh
brew install emacs --cask
rm -rf ~/.emacs.d
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -s ~/dotfiles/emacs/_spacemacs ~/.spacemacs
brew install aspell
ln -s ~/dotfiles/emacs/_aspell.conf ~/.aspell.conf
