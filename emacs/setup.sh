sh ~/dotfiles/setup.sh
brew install emacs --cask
brew install ripgrep
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
test ! -e ~/.doom.d/ && mkdir -p ~/.doom.d/
ln -s ~/dotfiles/emacs/_doom.d/config.el ~/.doom.d/config.el
ln -s ~/dotfiles/emacs/_doom.d/init.el ~/.doom.d/init.el
ln -s ~/dotfiles/emacs/_doom.d/packages.el ~/.doom.d/packages.el
