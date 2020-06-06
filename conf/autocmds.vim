augroup autocmd_guard_me
    autocmd!
	  " 识别 md 为 markdown
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

		"  auto jump to last edit location in your opend file
		"  https://askubuntu.com/questions/202075/how-do-i-get-vim-to-remember-the-line-i-was-on-when-i-reopen-a-file/202077
		if has("autocmd")
			au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
		endif


    autocmd BufLeave,FocusLost * silent! wall
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType help noremap <buffer> q :q<cr>
    autocmd FileType qf  noremap <buffer> q :q<cr>
    autocmd FileType gitcommit noremap <buffer> q :q<cr>
    "注意, 打开文件夹时,会split窗口,所以仅用来 preview files
    autocmd FileType nerdtree map <buffer> J jgo
    autocmd FileType nerdtree map <buffer> K kgo

    autocmd FileType vim vnoremap <F5> "ay:@a<cr>


    " don`t use this, a lot of strange problems will occur
	 " autocmd! bufwritepost ~/.vimrc source %

    " format after file saved
    "autocmd BufWritePre * :normal gg=G
	"
    " 在 filetype 为 sql 时, iunmap 所有的C-C 开头的命令, 不然C-C 好慢
    autocmd Filetype sql  <buffer>
                \       for m in ['<C-C>R', '<C-C>L', '<C-C>l', '<C-C>c', '<C-C>v', '<C-C>p', '<C-C>t', '<C-C>s', '<C-C>T', '<C-C>o', '<C-C>f', '<C-C>k', '<C-C>a']
                \       | execute('silent! iunmap <buffer> '.m)
                \       | endfor

    "  当前行背景
   " au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
   " au WinLeave * setlocal nocursorline

    "" columcolor width 与 tw  一致
    "  autocmd FileType * execute "setlocal colorcolumn=+1"
    ":hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white guibg=darkred guifg=white

		" 在保存时,自动删除结尾空格
		fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
		endfun

		autocmd BufWritePre * :call TrimWhitespace()

augroup END

" auto load file as binary
" http://vim.wikia.com/wiki/Improved_hex_editing
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

