"*****************************************************************************
"" dein Settings
"*****************************************************************************"
" TODO: XDG Base Directory Specification に対応しないなら変更する必要あり
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir .'/repos/github.com/Shougo/dein.vim'

" autocmd が複数登録されないように最初に削除
" dein.toml で MyAutoCmd を使うので dein.toml を読み込む前に定義
augroup MyAutoCmd
  autocmd!
augroup END

" dein.vimを自動でインストール.
" system はシェルの実行、shellescapeはシェルで利用できる文字列に変換
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" dein.vim本体をruntimepathに自己代入.つまりプラグインとして読み込む.
" TODO:下記の場合 rintaro の部分が固定で他の環境で使えないので修正.
" set runtimepath+=/Users/rintaro/.cache/dein/repos/github.com/Shougo/dein.vim
"  => set runtimepath+=s:dein_repo_dir がエラーになる理由が分からない.
" 上記では set しているが参考サイトでは下記のように let を使っているがそれぞれのメリデメが分からない.
" 参考サイト : https://qiita.com/kawaz/items/ee725f6214f91337b42b
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み&キャッシュ作成.
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:plugings_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
  call dein#load_toml(s:plugings_file)

  call dein#end()
  call dein#save_state()
endif

" 起動時に不足プラグインを自動でインストール.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
"*****************************************************************************
"" End dein Settings
"*****************************************************************************"

"*****************************************************************************
"" Basic Settings
"*****************************************************************************"
" VimをVi互換モードではなく、Vimとして使用(compatibleオプションはデフォルトで有効だが、vimrc/gvimrcを読み込むと無効になる)
if &compatible
  set nocompatible
endif

" 行数を表示
set number
" ファイルタイトルを表示
set title
" -(ハイフン)を単語に含める
set isk+=-
" vimの256色対応
set t_Co=256
" クリップボード
set clipboard=unnamed
" backspace で削除できるものを指定
" indent: 行頭の空白, eol: 改行, start:挿入モード開始位置より手前の文字
set backspace=indent,eol,start
" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~
" カーソルラインをハイライト"
set cursorline

" 検索パターンに大文字小文字を区別しない
set ignorecase
" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

" タブ入力を複数の空白入力に置き換える
set expandtab
" タブ幅
set tabstop=2
" 連続した空白に対してタブキーやバックスペースでカーソルが動く幅
set softtabstop=0
" smartindentで増減する幅
set shiftwidth=2

" ファイルのスプリット
nnoremap <silent> <Space>j :<C-u>split<CR>
nnoremap <silent> <Space>l :<C-u>vsplit<CR>
" ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" ナイスなVimの設定を思いついたら即座にvimrcを開き反映
nnoremap <F5> :<C-u>split $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>
"*****************************************************************************
"" End Basic Settings
"*****************************************************************************"

"*****************************************************************************
" User defined command
"*****************************************************************************
" MarkDownをChromeで表示するショートカットキー
command! Previm PrevimOpen
" 基礎文法を表示するショートカットキー
command! Help help learn-vimscript
"*****************************************************************************
" End User defined command
"*****************************************************************************

"*****************************************************************************
" Autocmd
"*****************************************************************************
" 必ずaugroup名を指定して書く
" 保存時に行末スペースを取り除く TODO: 全角対応
" eフラグは検索パターンが何もマッチしなかった時に、エラーメッセージを表示させないため
autocmd MyAutoCmd BufWritePre * %s/\s\+$//e
" 行末スペースをハイライトで可視化する TODO: 全角対応
autocmd MyAutoCmd VimEnter,WinEnter *
  \ match Error /\s\+$/
" *で全ファイルに適用
autocmd MyAutoCmd VimEnter * execute 'NERDTree'

autocmd BufRead,BufNewFile *.md set filetype=markdown
"*****************************************************************************
" End Autocmd
"*****************************************************************************

