nnoremap <F5> : call CompileRunGcc()<CR>
inoremap <F5> <esc>: call CompileRunGcc()<CR>
vnoremap gG "gy<Esc>:call GoogleSearch()<CR>
vnoremap ga "gy<esc>:call OpenChrome()<CR>
vnoremap gr "gy<Esc>:call FunReference()<CR>
nnoremap gr "gy<Esc>:call FunReference2(expand('<cword>'))<CR>
inoremap <expr> <CR> InsertMapForEnter()

nnoremap dc :norm diwds)<cr>
nnoremap d] :norm diwds]<cr>
nnoremap d} :norm diwds}<cr>
nnoremap d) :norm diwds)<cr>

" quick switch two buffers
nnoremap <c-e> <c-^>
vnoremap <space> <Nop>

" 在 yank 的时候,保持光标在最下方,而不是跳加到前面
vnoremap y y`]
" nnoremap <silent> gp :!ls  "%:p" & <cr>

" nnoremap yy ddu

" resize nerdtree
nnoremap + :vertical resize +1<cr>
nnoremap - :vertical resize -1<cr>

" rewrite current file using the utf-8
nnoremap <leader>E :e ++enc=utf-8<cr>:w!<cr>


" quick select all
nnoremap <leader>a  ggVG
"https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
nnoremap <leader>q  <C-w><C-j><C-w>c
nnoremap <leader>Q  <C-w><C-k><C-w>c

" command! SelectAll  normal! ggVG
nnoremap Q  q
nnoremap q  <esc>:q!<cr>

" open with system opener
nnoremap go :!open '%'<cr>

" terminal kitty helper
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" indent  without lose the selection
vnoremap  <Tab> >gv
vnoremap  <S-Tab> <gv

" quick navigation
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
nnoremap <leader>et :e ~/.config/kitty/kitty.conf<cr>
nnoremap <leader>e4 :e /usr/local/etc/proxychains.conf<cr>


" move page down with cursor in the middle of screen
nnoremap <C-f> <C-d>zz
" move page up with cursor in the middle of screen
nnoremap <C-b> <C-u>zz

nnoremap <C-m>o :copen<CR>

" swag : and ; for easy typing.  cause : is used so much, and I do not want to press <shift> every time
nnoremap ;  :
nnoremap :  ;

" Moving text:
" 选择一段文本,用 J,K 移动
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" nnoremap <leader>. :echo expand('%:p')<CR>

"multi paste
xnoremap p pgvy

" save in insert mode
inoremap <c-s> <c-o>:w<cr>

" delete backwards, like terminal do
" help from :https://vi.stackexchange.com/questions/27825/how-do-delete-the-the-next-word-or-remainder-of-a-line-in-insert-mode
inoremap <C-w> <C-o>diw

inoremap <C-d> <Del>
inoremap <C-u> <C-G>u<C-U>
" inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
inoremap <c-b> <left>
inoremap <c-f> <right>
" inoremap <c-p> <c-o>k
" inoremap <c-n> <c-o>k

inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-k> <c-o>d$
inoremap <c-l> <c-o>cl
"}}

" for auto completion
inoremap <C-space> <C-n>

"move around in command line like emacs
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

" swap words between non-word characters in selected mode
vnoremap  <C-s> :s/\%V\(\w\+\)\(\W\+\)\(\w\+\)/\3\2\1<cr>:noh<cr>

