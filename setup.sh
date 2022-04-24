sh ./brew.sh

rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
test ! -e ~/.doom.d/ && mkdir -p ~/.doom.d/
# doom install でファイルが作成されているので、-fオプションで上書きする
ln -sf ~/dotfiles/_doom.d/config.el ~/.doom.d/config.el
ln -sf ~/dotfiles/_doom.d/init.el ~/.doom.d/init.el
ln -sf ~/dotfiles/_doom.d/packages.el ~/.doom.d/packages.el

ln -s ~/dotfiles/_zprofile ~/.zprofile
ln -s ~/dotfiles/_zshrc ~/.zshrc

ln -s ~/dotfiles/_gitconfig ~/.gitconfig
test ! -e ~/.config/git && mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore
