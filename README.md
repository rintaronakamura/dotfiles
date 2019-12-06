# dotfiles

## Setup
Execute the following command in the home directory.

＊Note: Please install [homebrew](https://brew.sh/index_ja) before running.

```
% git clone --recursive git@github.com:residenti/dotfiles.git
% cd dotfiles
% sh setup.sh
```

## How to update vim plugin
Since vim plug-in is managed as git submodule, batch update is performed as follows.

```
% git submodule foreach git pull
% git commit -a -m 'update all vim plugins.'
```
