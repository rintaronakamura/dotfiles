sh ./brew.sh

curl https://get.volta.sh | bash

rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
test ! -e ~/.doom.d/ && mkdir -p ~/.doom.d/
# doom install でファイルが作成されているので、-fオプションで上書きする
ln -sf ~/dotfiles/.doom.d/config.el ~/.doom.d/config.el
ln -sf ~/dotfiles/.doom.d/init.el ~/.doom.d/init.el
ln -sf ~/dotfiles/.doom.d/packages.el ~/.doom.d/packages.el

ln -s ~/dotfiles/.zprofile ~/.zprofile
ln -s ~/dotfiles/.zshrc ~/.zshrc
# ln -s ~/dotfiles/.bash_profile ~/.bash_profile
# ln -s ~/dotfiles/.bashrc ~/.bashrc

ln -s ~/dotfiles/.gitconfig ~/.gitconfig
test ! -e ~/.config/git && mkdir -p ~/.config/git
ln -s ~/dotfiles/.config/git/ignore ~/.config/git/ignore

# NOTE: Xremap 使うならコメントアウト外す
# ln -s ~/dotfiles/.config/xremap.yml ~/.config/xremap.yml
# test ! -e ~/.config/systemd/user && mkdir -p ~/.config/systemd/user
# ln -s ~/dotfiles/.config/systemd/user/xremap.service ~/.config/systemd/user/xremap.service
# ln -s ~/dotfiles/.config/autostart/xremap.desktop ~/.config/autostart/xremap.desktop
#
# xremap.service にて、xremap コマンドを sudo なしで 実行するために以下を実施する
# 参考: https://github.com/k0kubun/xremap#running-xremap-without-sudo
# sudo gpasswd -a $(whoami) input
# echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules
