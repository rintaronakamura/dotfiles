"*****************************************************************************
"" dein Scripts
"*****************************************************************************"
if &compatible
  set nocompatible
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
  " スニペット機能
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')
  " カラースキーム
  call dein#add('jacoborus/tender.vim')

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

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
" カラースキームを設定
colorscheme tender
" 行数を表示
set number
" ファイルタイトルを表示
set title
" -(ハイフン)を単語に含める
:set isk+=-
" vimの256色対応 <= TODO 必要ないかも調べる.
set t_Co=256
" 検索&置換(小文字だけの検索は大文字小文字を無視、大文字で検索した場合は無視しない)
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
nnoremap <silent> <Space>j :<C-u>split<CR>
nnoremap <silent> <Space>l :<C-u>vsplit<CR>
nnoremap <Bar> $:<C-u>let pos = getpos(".")<CR>:<C-u>join<CR>:<C-u>call setpos('.', pos)<CR>
" ウィンドウ移動
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l
" ナイスなVimの設定を思いついたら即座にvimrcを開き反映
nnoremap <F5> :<C-u>split $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>
"*****************************************************************************
"" End Basic Setup
"*****************************************************************************"

"*****************************************************************************
" User defined command
" *****************************************************************************
" 1行目を削除するコマンド
command! DeleteFirstLine 1delete
"*****************************************************************************
" End User defined command
" *****************************************************************************

"*****************************************************************************
" Autocmd
" *****************************************************************************
" autocmdが複数登録されないように最初に削除しておく
augroup myvimrc
  autocmd!
augroup END
" 保存時に行末スペースを取り除く
" eフラグは検索パターンが何もマッチしなかった時に、エラーメッセージを表示させないため
" 必ずaugroup名を指定して書く
autocmd myvimrc BufWritePre * %s/\s\+$//e
"*****************************************************************************
" End Autocmd
" *****************************************************************************

"*****************************************************************************
" Plugin Setup
"*****************************************************************************
"
" neocomplete/neosnippet Setup
"
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
"*****************************************************************************
" End Plugin Setup
" *****************************************************************************

