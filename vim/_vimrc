"*****************************************************************************
" Basic Settings
"*****************************************************************************"
packadd! dracula
syntax enable
colorscheme dracula

filetype plugin indent on

set spell " zg で カーソルの下の単語を正しい (good) 単語として、'spellfile' の最初のファイルに追加する
set spelllang=en,cjk
set cursorline " カーソルがある行を目立たせる
set incsearch " インクリメンタルサーチ. 1文字入力毎に検索を行う
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
set shortmess-=S " キーワード検索マッチ件数を表示する
set expandtab " タブをスペースに変換する
set tabstop=2 " ファイル上のタブ文字の幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースでカーソルが動く幅
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2 " smartindentで増減する幅
set number " 行数を表示
set title " ファイルタイトルを表示
set isk+=- " - (ハイフン) を単語に含める
set t_Co=256 " vimの256色対応
set clipboard=unnamed " ヤンクしたテキストそのままクリップボードにコピーする
set backspace=indent,eol,start " indent: 行頭の空白, eol: 改行, start: 挿入モード開始位置より手前の文字でバックスペースを有効化
set ambiwidth=double " □や○文字が崩れる問題を解決
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する
set wildmenu " コマンドモードの補完
set list " 不可視文字を表示する
set lcs=tab:>-,trail:- " タブを -- 半スペを - で表示する
set noignorecase " 大文字小文字を区別する

nnoremap <silent> <Space>x :<C-u>split<CR>
nnoremap <silent> <Space>v :<C-u>vsplit<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-w> <C-w>x
nnoremap <C-d> :GFiles?<CR>
nnoremap <C-p> :call FzfOmniFiles()<CR>
nnoremap <C-c> :Commands<CR>
nnoremap <silent> <Space>h :History<CR>
nnoremap <C-g> :Ag<CR>
nnoremap <C-]> :LspDefinition<CR>

command! P echo expand("%:p")
"*****************************************************************************
" End Basic Settings
"*****************************************************************************"

"*****************************************************************************
" Autocmd
"*****************************************************************************
augroup MyAutoCmd
  autocmd!
augroup END

autocmd MyAutoCmd BufRead,BufNewFile *.md set filetype=markdown
autocmd MyAutoCmd BufRead,BufNewFile *.slim set filetype=slim
autocmd MyAutoCmd BufRead,BufNewFile *.coffee set filetype=coffee
autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC " 保存時にファイルをリロードする.
autocmd MyAutoCmd BufWritePre * %s/\s\+$//e " 保存時に行末スペースを取り除く
autocmd MyAutoCmd BufReadPost * " ファイルを開いてカーソルの位置を元に戻す.
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow " vimgrep,grep,Ggrepで自動的にquickfix-window(:cw)を開く.
autocmd MyAutoCmd BufWritePost * GitGutter " vim-gitgutter: バッファを保存時に差分を認識させる.

function! s:config_markdown()
  packadd previm
  let g:previm_open_cmd = "open -a 'Google Chrome'"
  command! Pre PrevimOpen
endfunction
autocmd MyAutoCmd FileType markdown call s:config_markdown()

function! s:config_slim()
  packadd vim-slim
endfunction
autocmd MyAutoCmd FileType slim call s:config_slim()

function! s:config_coffee()
  packadd vim-coffee-script
endfunction
autocmd MyAutoCmd FileType coffee call s:config_coffee()
"*****************************************************************************
" End Autocmd
"*****************************************************************************

"*****************************************************************************
" Plugin Settings
"*****************************************************************************
"" NERDTree
nmap <silent> <Space>ne :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1 " 隠しファイルを表示
let g:NERDTreeIgnore=['\.swp$', '.DS_Store'] " 非表示ファイル
"" winresizer
let g:winresizer_start_key = '<Space>w'
let g:winresizer_keycode_finish = 13 " enter で完了する.
"" indentLine
let g:indentLine_char = '¦'
"" lightline.vim
set laststatus=2
"" fzf.vim
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit'}
"" asyncomplete.vim
let g:asyncomplete_auto_popup = 1 " 自動で入力補完ポップアップを表示する
let g:asyncomplete_popup_delay = 200 " ポップアップを表示するまでのディレイ
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
"" vim-lsp
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings_filetype_javascript = ['typescript-language-server']
let g:lsp_settings_filetype_typescript = ['typescript-language-server']
let g:lsp_settings_filetype_vue = ['vls']
"*****************************************************************************
" End Plugin Settings
"*****************************************************************************"
