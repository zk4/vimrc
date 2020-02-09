augroup guard_group 
    autocmd!
	  " 识别 md 为 markdown
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown


    autocmd BufLeave,FocusLost * silent! wall
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help noremap <buffer> q :q<cr>
    autocmd FileType qf  noremap <buffer> q :q<cr>
    autocmd FileType gitcommit noremap <buffer> q :q<cr>
    "注意, 打开文件夹时,会split窗口,所以仅用来 preview files
    autocmd FileType nerdtree map <buffer> J jgo
    autocmd FileType nerdtree map <buffer> K kgo

    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " 在保存.vimrc 后,自动刷新, 各种 bug 
	 " autocmd! bufwritepost ~/.vimrc source %

    " 保存后格式化
    "autocmd BufWritePre * :normal gg=G
    " 在 filetype 为 sql 时, iunmap 所有的C-C 开头的命令, 不然C-C 好慢
    autocmd Filetype sql  <buffer>
                \       for m in ['<C-C>R', '<C-C>L', '<C-C>l', '<C-C>c', '<C-C>v', '<C-C>p', '<C-C>t', '<C-C>s', '<C-C>T', '<C-C>o', '<C-C>f', '<C-C>k', '<C-C>a']
                \       | execute('silent! iunmap <buffer> '.m)
                \       | endfor
    "  当前行背景
"    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"    au WinLeave * setlocal nocursorline

    "" columcolor width 与 tw  一致
    "  autocmd FileType * execute "setlocal colorcolumn=+1"
    ":hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white guibg=darkred guifg=white

augroup END
