sh ~/dotfiles/setup.sh
brew install emacs --cask
brew install ripgrep
brew install haskell-language-server
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
test ! -e ~/.doom.d/ && mkdir -p ~/.doom.d/
# doom install でファイルが作成されているので、-fオプションで上書きする
ln -sf ~/dotfiles/emacs/_doom.d/config.el ~/.doom.d/config.el
ln -sf ~/dotfiles/emacs/_doom.d/init.el ~/.doom.d/init.el
ln -sf ~/dotfiles/emacs/_doom.d/packages.el ~/.doom.d/packages.el
