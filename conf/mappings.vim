nnoremap <F5> : call CompileRunGcc()<CR>
inoremap <F5> <esc>: call CompileRunGcc()<CR>
vnoremap gG "gy<Esc>:call GoogleSearch()<CR>
vnoremap ga "gy<esc>:call OpenChrome()<CR>
vnoremap gr "gy<Esc>:call FunReference()<CR>
nnoremap gr "gy<Esc>:call FunReference2(expand('<cword>'))<CR>
inoremap <expr> <CR> InsertMapForEnter()


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

" nnoremap <leader>cp :CocCommand python.

" rewrite current file using the utf-8
nnoremap <leader>E :e ++enc=utf-8<cr>:w!<cr>


" quick select all
nnoremap <leader>a  ggVG
"https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
nnoremap <leader>q  <C-w><C-j><C-w>c
nnoremap <leader>Q  <C-w><C-k><C-w>c

" command! SelectAll  normal! ggVG
" command! SwitchBuffer :e #
nnoremap Q  q
nnoremap q  <esc>:q!<cr>
" nnoremap <esc>:q!<cr>
" nnoremap <c-q> <esc>:q!<cr>
" nnoremap <c-s> <esc>:w<cr>

" open with system opener
nnoremap go :!open '%'<cr>

" terminal kitty helper 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"noremap  <F4> :NERDTreeToggle<CR>
" indent  without lose the selection
vnoremap  <Tab> >gv
vnoremap  <S-Tab> <gv

" vnoremap  <Space> <right>
" vnoremap  <S-Space> <left>


" quick navigation
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
" nnoremap <leader>ef :e ~/.zk_vimrc/conf/plugins_mappings_config.vim<cr>
" nnoremap <leader>ea :e /Users/zk/.config/coc/ultisnips/all.snippets <cr>
" nnoremap <leader>ee :source ~/.zk_vimrc/.vimrc<cr>
" nnoremap <leader>eh :e ~/.zk_vimrc/help.md<cr>
nnoremap <leader>et :e ~/.config/kitty/kitty.conf<cr>
" nnoremap <leader>ec :e ~/bin/cmd_database.py<cr>
nnoremap <leader>e4 :e /usr/local/etc/proxychains.conf<cr>

" format file without cursor moving to head, and move cursor the middle of screen
"nnoremap <leader>f mmgg=G`mzz

" move page down with cursor in the middle of screen
nnoremap <C-f> <C-d>zz
" move page up with cursor in the middle of screen
nnoremap <C-b> <C-u>zz

nnoremap <C-m>o :copen<CR>

" swag : and ; for easy typing.  cause : is used so much, and I do not want to press <shift> every time
nnoremap ;  :
nnoremap :  ;

"make kj into jumplist
" nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
" nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" nnoremap gm :call jobstart("mpv " . expand("<cWORD>"))<CR>

" 拼接字符串时不要跳光标
" nnoremap J mzJ`z

" Moving text:
" 选择一段文本,用 J,K 移动
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" nnoremap <leader>. :echo expand('%:p')<CR>

"multi paste
xnoremap p pgvy


"http://janis-vitols.com/vim/tricks/2016/11/16/replace-word-or-selection-in-vim.html vnoremap ss y/\<C-R>=escape(@",'\/')<CR>//g<left><left>
" Replace visually selected text or word (globally with confirmation)
" nnoremap <leader>s *:<C-U>let replacement = input('Replace word `<C-R><C-W>` with: ') <bar> %s/\<<C-R><C-W>\>/\=replacement/gc<CR>
" vnoremap <leader>s y*:<C-U>let replacement = input('Replace selection `<C-R>"` with: ') <bar> %s/<C-R>"/\=replacement/gc<CR>

" nnoremap W :w<cr>

" save in insert mode
inoremap <c-s> <c-o>:w<cr>
" nnoremap  <leader>w :w<cr>
" inoremap  <c-s> <esc>:w<cr>li

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

"inoremap <c-k> <esc>ld$a
" inoremap ∫ <S-Left>
" inoremap ƒ <S-Right>
" 在quickfix 里移动  alt+n alt+p
" noremap ∆ :cn<cr>
" noremap ˚ :cp<cr>
"noremap <A-n> :cn<cr>
"noremap <A-p> :cp<cr>

"move around in command line like emacs
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
" cnoremap ∫ <S-Left>
" cnoremap ƒ <S-Right>

" custom text object
" omap ( :normal vi)<CR>
" omap ) :normal vi)<CR>
" omap " :normal vi"<CR>
" omap ' :normal vi'<CR>
" omap t :normal vit<CR>

" omap af :normal vi'<CR>

" nnoremap / /\v
" nnoremap ? ?\v
" vnoremap / /\v
" vnoremap ? ?\v

" nnoremap <C-m>o :copen<CR>


" nnoremap <silent> gf :call JumpOrCreateFile()<CR>


