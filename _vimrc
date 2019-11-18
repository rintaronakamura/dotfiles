"*****************************************************************************
"" Basic Settings
"*****************************************************************************"
" VimをVi互換モードではなく、Vimとして使用(compatibleオプションはデフォルトで有効だが、vimrc/gvimrcを読み込むと無効になる)
if &compatible
  set nocompatible
endif

filetype plugin indent on
packadd! dracula
syntax enable
colorscheme dracula

" 検索パターンに大文字小文字を区別しない
set ignorecase
" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

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
" マウスでカーソル移動やスクロール移動を可能に.
" if has('mouse')
"     set mouse=a
"     if has('mouse_sgr')
"         set ttymouse=sgr
"     elseif v:version > 703 || v:version is 703 && has('patch632')
"         set ttymouse=sgr
"     else
"         set ttymouse=xterm2
"     endif
" endif

" ファイルの分割
nnoremap <silent> <Space>x :<C-u>split<CR>
nnoremap <silent> <Space>v :<C-u>vsplit<CR>
" ウィンドウ間におけるカーソルの移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
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

" 保存時に行末スペースを取り除く TODO: 全角対応
" eフラグは検索パターンが何もマッチしなかった時に、エラーメッセージを表示させないため
autocmd MyAutoCmd BufWritePre * %s/\s\+$//e

autocmd MyAutoCmd BufRead,BufNewFile *.md set filetype=markdown

" golangならハードタブに.
autocmd MyAutoCmd BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4

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
" NERDTreeを起動する.
autocmd MyAutoCmd VimEnter * execute 'NERDTree'

" vim-devicons
"インストール方法メモ
"1. https://github.com/ryanoasis/nerd-fonts#font-installation のoption4: Homebrewでフォントをインストールする.
"2. 利用しているターミナルのフォントを手順1でインストールしたFontに変更する.iTerm2なら設定画面>Profiles>Text>Font>Change Fontから設定する.
"3. ryanoasis/vim-deviconsをインストールする.

" winresizer
let g:winresizer_start_key = '<Space>w'
" enter で完了する.
let g:winresizer_keycode_finish = 13

" vim-gitgutter
" バッファを保存時に差分を認識させる.
autocmd MyAutoCmd BufWritePost * GitGutter

" vimdoc-ja
set helplang=ja,en

" indentLine
let g:indentLine_char = '¦'

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
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" vim-lsp
" Ruby言語用LSP設定の定義
if executable('solargraph')
  " gem install solargraph
  augroup LspRuby
    au!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'solargraph',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
          \ 'initialization_options': {"diagnostics": "true"},
          \ 'whitelist': ['ruby'],
          \ })
  augroup END
endif

" Javascript, Typescript言語用LSP設定の定義
if executable('typescript-language-server')
  " npm install -g typescript typescript-language-server
  augroup LspTypeScript
    au!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'typescript-language-server',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
          \ 'whitelist': ['typescript', 'typescript.tsx', 'javascript', 'javascript.jsx'],
          \ })
  augroup END
endif

" Go言語用LSP設定の定義
if executable('gopls')
  " go get -u golang.org/x/tools/cmd/gopls
  augroup LspGo
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
  augroup END
endif

" 遅延読み込み用関数の定義.
function! s:config_markdown()
  packadd previm
  let g:previm_open_cmd = "open -a 'Google Chrome'"
  command! Pre PrevimOpen
endfunction

function! s:config_vue()
  packadd vim-vue
endfunction

" 遅延読み込み.
autocmd MyAutoCmd FileType markdown call s:config_markdown()
autocmd MyAutoCmd FileType vue call s:config_vue()
"*****************************************************************************
"" End Plugin Settings
"*****************************************************************************"
