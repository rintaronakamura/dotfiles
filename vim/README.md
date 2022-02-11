# For vimmer

## Setup

Execute the following command.

```
cd ~
git clone --recursive git@github.com:residenti/dotfiles.git
cd dotfiles/vim
sh ./setup.sh
```

change terminal font.
`Hack Regular Nerd Font Complete 14 pt`

change terminal theme.
[Dracula](https://draculatheme.com/terminal/)

[change macbook(pc) name.](https://support.apple.com/ja-jp/guide/mac-help/mchlp2322/mac)

## Tips

### How to add vim plugin

```
# example
mkdir -p _vim/pack/residenti/start
git submodule add https://github.com/residenti/amatatsu.git _vim/pack/residenti/start/amatatsu
```
If you want to do lazy loading, Click [here](https://residenti-blog.herokuapp.com/articles/442) for details.

### How to update vim plugin

Since vim plug-in is managed as git submodule, batch update is performed as follows.

```
git submodule foreach git pull
git commit -a -m 'update all vim plugins.'
```

### How to remove vim plugin

```
# example
git submodule deinit _vim/pack/posva/opt/vim-vue
git rm _vim/pack/posva/opt/vim-vue
```
