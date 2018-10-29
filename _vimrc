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

" TODO space聞かない
" ファイルのスプリット(と行結合)
nnoremap <silent> <Space>j :split<CR>
nnoremap <silent> <Space>l :vsplit<CR>
nnoremap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>

" ウィンドウ移動 
nnoremap <S-h> <C-w>h
nnoremap <S-j> <C-w>j
nnoremap <S-k> <C-w>k
nnoremap <S-l> <C-w>l

