"*****************************************************************************
"" Basic Settings
"*****************************************************************************"
" VimをVi互換モードではなく、Vimとして使用(compatibleオプションはデフォルトで有効だが、vimrc/gvimrcを読み込むと無効になる)
if &compatible
  set nocompatible
endif

syntax on
let g:dracula_italic = 0 " https://github.com/dracula/vim/issues/96
packadd! dracula
colorscheme dracula

filetype plugin indent on

" カーソルがある行を目立たせる
set cursorline
" 検索パターンに大文字小文字を区別しない
set ignorecase
" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

" キーワード 検索マッチ件数を表示する
set shortmess-=S

" タブをスペースに変換する
set expandtab
" ファイル上のタブ文字の幅
set tabstop=2
" 連続した空白に対してタブキーやバックスペースでカーソルが動く幅
set softtabstop=2
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅
set shiftwidth=2

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
" indent: 行頭の空白, eol: 改行, start: 挿入モード開始位置より手前の文字でバックスペースを有効化
set backspace=indent,eol,start
" □や○文字が崩れる問題を解決
set ambiwidth=double
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim
" コマンドモードの補完
set wildmenu
" 不可視文字を表示する
set list
" タブを -- 半スペを - で表示する
set lcs=tab:>-,trail:-
" 末尾に改行がついていないファイルを編集し保存するとファイル末尾に改行追加されるのを防ぐ
set nofixeol
" 大文字小文字を区別する
set noignorecase

" ファイルの分割
nnoremap <silent> <Space>x :<C-u>split<CR>
nnoremap <silent> <Space>v :<C-u>vsplit<CR>
" ウィンドウ間におけるカーソルの移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" ハイライトをオフにする
nnoremap <F3> :noh<CR>
" ナイスなVimの設定を思いついたら即座にvimrcを開き反映
nnoremap <F5> :<C-u>split $MYVIMRC<CR>
nnoremap <F6> :<C-u>source $MYVIMRC<CR>
" ヤンクした内容が消えないようにする
nnoremap PP "0p
" ウィンドウ入れ替え
" 現在カーソルがあるウィンドウと一つ前のウィンドウを入れ替える
nnoremap <C-w> <C-w>x

command! Path echo expand("%:p")
"*****************************************************************************
"" End Basic Settings
"*****************************************************************************"

"*****************************************************************************
" Autocmd
" 必ずaugroup名を指定して書く
" *で全ファイルに適用
"*****************************************************************************
augroup MyAutoCmd
  autocmd!
augroup END

autocmd MyAutoCmd BufRead,BufNewFile *.md set filetype=markdown
autocmd MyAutoCmd BufRead,BufNewFile *.slim set filetype=slim
autocmd MyAutoCmd BufRead,BufNewFile *.coffee set filetype=coffee

" vimgrep
"" vimgrep,grep,Ggrepで自動的にquickfix-window(:cw)を開く.
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow
"" vimgrepの検索対象外ファイル・ディレクトリを設定.
let s:ignore_list  = ',.git/**,.svn/**,obj/**'
let s:ignore_list .= ',tags,GTAGS,GRTAGS,GPATH'
let s:ignore_list .= ',*.o,*.obj,*.exe,*.dll,*.bin,*.so,*.a,*.out,*.jar,*.pak'
let s:ignore_list .= ',*.zip,*gz,*.xz,*.bz2,*.7z,*.lha,*.lzh,*.deb,*.rpm,*.iso'
let s:ignore_list .= ',*.pdf,*.png,*.jp*,*.gif,*.bmp,*.mp*'
let s:ignore_list .= ',*.od*,*.doc*,*.xls*,*.ppt*'

if exists('+wildignore')
  autocmd MyAutoCmd QuickFixCmdPre  * execute 'setlocal wildignore+=' . s:ignore_list
  autocmd MyAutoCmd QuickFixCmdPost * execute 'setlocal wildignore-=' . s:ignore_list
endif

" htmlの閉じタグ補完.
autocmd MyAutoCmd Filetype xml  inoremap <buffer> </ </<C-x><C-o>
autocmd MyAutoCmd Filetype html inoremap <buffer> </ </<C-x><C-o>

" ファイルを開いてカーソルの位置を元に戻す.
autocmd MyAutoCmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" 保存時にファイルをリロードする.
autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC
"*****************************************************************************
" End Autocmd
"*****************************************************************************

"*****************************************************************************
"" Plugin Settings
"*****************************************************************************
" NERDTree
" NERDTreeを表示/非表示
nmap <silent> <Space>ne :NERDTreeToggle<CR>
" 隠しファイルを表示
let g:NERDTreeShowHidden=1
" 非表示ファイル
let g:NERDTreeIgnore=['\.swp$', '.DS_Store']
" 開いているウィンドウがNERDTreeだけならVimを閉じる
autocmd MyAutoCmd Bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" winresizer
let g:winresizer_start_key = '<Space>w'
" enter で完了する.
let g:winresizer_keycode_finish = 13

" vim-gitgutter
" バッファを保存時に差分を認識させる.
autocmd MyAutoCmd BufWritePost * GitGutter

" indentLine
let g:indentLine_char = '¦'

" lightline.vim
set laststatus=2

" fzf.vim
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

nnoremap <C-g> :Ag<Space>
nnoremap <C-d> :GFiles?<CR>
nnoremap <C-p> :call FzfOmniFiles()<CR>
nnoremap <C-c> :Commands<CR>
nnoremap <silent> <Space>h :History<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit'}

" asyncomplete.vim
" 自動で入力補完ポップアップを表示する
let g:asyncomplete_auto_popup = 1
" ポップアップを表示するまでのディレイ
let g:asyncomplete_popup_delay = 200
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" vim-lsp
" ファイルの変更に伴いリアルタイムにエラー表示する機能 Diagnostics を有効にする
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings_filetype_html = ['html-languageserver', 'vls']
let g:lsp_settings_filetype_javascript = ['typescript-language-server']
let g:lsp_settings_filetype_typescript = ['typescript-language-server']
" LSP の仕様である textEdit を有効にする(未完成なのでバグ有り?)
let g:lsp_text_edit_enabled = 1
let g:lsp_signs_error = {'text': '🚨'}
let g:lsp_signs_warning = {'text': '⚠️'}
let g:lsp_signs_hint = {'text': '😕'}
nnoremap <C-]> :LspDefinition<CR>

" 遅延読み込み用関数の定義.
function! s:config_markdown()
  packadd previm
  let g:previm_open_cmd = "open -a 'Google Chrome'"
  command! Pre PrevimOpen
endfunction

function! s:config_slim()
  packadd vim-slim
endfunction

function! s:config_coffee()
  packadd vim-coffee-script
endfunction

" 遅延読み込み.
autocmd MyAutoCmd FileType markdown call s:config_markdown()
autocmd MyAutoCmd FileType slim call s:config_slim()
autocmd MyAutoCmd FileType coffee call s:config_coffee()
"*****************************************************************************
"" End Plugin Settings
"*****************************************************************************"
