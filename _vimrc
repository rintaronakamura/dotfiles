"*****************************************************************************
"" Basic Setup
"*****************************************************************************"

" 行数を表示
set number

" ファイルタイトルを表示
set title

" 検索&痴漢(小文字だけの検索は大文字小文字を無視、大文字で検索した場合は無視しない)
set ignorecase
set smartcase
set wrapscan
set incsearch

" タブ幅
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set shiftround

" ファイルのスプリット(と行結合)
nnoremap <silent> <Space>j :split<CR>
nnoremap <silent> <Space>l :vsplit<CR>
nnoremap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>

" ウィンドウ移動 
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l
"*****************************************************************************
"" End Basic Setup
"*****************************************************************************"


"*****************************************************************************
"" dein Scripts
"*****************************************************************************"
if &compatible
  set nocompatible               " Be iMproved
endif

" Required: dein.vim本体をruntimepathに自己代入.
set runtimepath+=/Users/rintaro/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/rintaro/.cache/dein')
  call dein#begin('/Users/rintaro/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/rintaro/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"*****************************************************************************
"" End dein Scripts
"*****************************************************************************"

