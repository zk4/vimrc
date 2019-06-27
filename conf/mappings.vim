" 在选择模式下, 将 space 也强制应于 leader, 不然会导致 space 真成空格了,
"Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
vnoremap <space> <Nop>
" 在 yank 的时候,保持光标在最下方,而不是跳加到前面
vnoremap y y`]
" 去除一层函数掉用  a(b)
nmap dc diwlds(
" sudo write
cnoremap w!! w !sudo tee > /dev/null %
"map zz to za in normal mode
nnoremap zz  za
" open vifm
"nnoremap <leader>1 :!vifm<cr>
" select all  cmd+a
nnoremap <leader>a  ggVG
nnoremap <leader>q  <C-w><C-j><C-w>c
command! SelectAll  normal! ggVG 
command! SwitchBuffer :e # 
nnoremap Q  q
nnoremap QQ :qa!<cr>
"nnoremap q <esc>:q<cr>
nnoremap q <esc>:bd<cr>
"nnoremap q <c-w>c
nnoremap <M-s> <esc>:w<cr>
" 全用不需要转义的正则表达式搜索
" 在incsearch里定义了
"nnoremap / ms/\v
"nnoremap ? ms?\v
" navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <F5> :call CompileRunGcc()<CR>
inoremap <F5> <esc>:call CompileRunGcc()<CR>
nnoremap <F8> :copen<cr>
"nnoremap <leader>c :call CompileRunGcc()<CR>
"noremap  <F2> :cprevious<CR>
"noremap  <F3> :cnext<CR>
"noremap  <F6> :exec  '!clear && '.getline('.')<cr>
noremap  <F4> :NERDTreeToggle<CR>
" indent  without lose the selection
vnoremap  <Tab> >gv
vnoremap  <S-Tab> <gv
vnoremap  <Space> <right> 
vnoremap  <S-Space> <left>
" switch between tab
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
" 在 insert mode 下,让 s-tab 向前 indent
inoremap <S-Tab> <C-d>
" 切换 buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
" create tab
nnoremap <leader>te :tabe<cr>
" close tab
nnoremap <leader>tc :tabc<cr>
" close buffer
"nnoremap <leader>bd :bd<cr>
nnoremap <leader>bd  <C-w>c
" close buffer
nnoremap <leader>ba :bwipe<cr>
"快速打开配置文件
"nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
nnoremap <leader>ef :e ~/.zk_vimrc/conf/plugins_mappings_config.vim<cr>
nnoremap <leader>ee :source ~/.zk_vimrc/.vimrc<cr>
nnoremap <leader>eh :e ~/.zk_vimrc/help.md<cr>
nnoremap <leader>et :e ~/.config/kitty/kitty.conf<cr>
nnoremap <leader>ec :e ~/bin/cmd_database.py<cr>
" 快速  edit  snippet c
"nnoremap <leader>esc :e /Users/zk/.config/coc/extensions/node_modules/HdsCppSnippets/snippets/c_hds.json<cr>
"nnoremap <leader>g :Ack<space>
" 这个映射用的太少了..
"nnoremap <Leader><leader> *<CR>
"Alternatively, you could use this mapping so that the final /g is already entered:
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//gc<left><left><left>
vnoremap <leader>r "hy:%s/<C-r>h//gc<left><left><left>
vnoremap  <leader>w :w<cr>
inoremap  <c-s> <esc>:w<cr>li
"nnoremap ,, <esc>A,
" format file without cursor moving to head, and move cursor the middle of screen
"nnoremap <leader>f mmgg=G`mzz
" move page down with cursor in the middle of screen
nnoremap <C-f> <C-d>zz
" move page up with cursor in the middle of screen
nnoremap <C-b> <C-u>zz
" define operator
" ex dp  delete  content in ()
onoremap p i(
onoremap ( i(
onoremap < i<
onoremap " i"
onoremap ' i'
onoremap { i{
onoremap [ i[
"inoremap jj <esc>A
inoremap jk <esc>
"inoremap ;; <esc>A;
"inoremap <C-l> <esc>la
nnoremap gs : execute "grep -R " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr><cr>
nnoremap gc : execute "Ack  " . shellescape(expand("<cword>")) . " %"<cr>:copen<cr><cr>
"nnoremap <leader><leader> : execute "Ack  " . shellescape(expand("<cword>")) . " %"<cr>:copen<cr><cr>
"nnoremap <leader>ps <esc>:call ProfileStart()<cr>
"nnoremap <leader>pe <esc>:call ProfileEnd()<cr>

" support emacs movement insert mode
inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-p> <up>
inoremap <c-n> <down>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-k> <c-o>d$
"inoremap <c-k> <esc>ld$a
inoremap ∫ <S-Left>
inoremap ƒ <S-Right>
" 在quickfix 里移动  alt+n alt+p
noremap ∆ :cn<cr>
noremap ˚ :cp<cr>
"noremap <A-n> :cn<cr>
"noremap <A-p> :cp<cr>

"move around in command line like emacs
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap ∫ <S-Left>
cnoremap ƒ <S-Right>

vmap ( S)
vmap ) S)
vmap " S"
vmap ' S'
"https://stackoverflow.com/questions/290465/how-to-paste-over-without-overwriting-register 
"https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
"xnoremap <silent> p p:let @"=@0<CR>
" make your paste as normal as other editor , but you paster register is
" broken. but it is fine for me ..
vnoremap p "_dP
"xnoremap <expr> p 'pgv"'.v:register.'y'
nnoremap <C-w>m :call MaximizeToggle()<CR>

nnoremap <C-m>o :copen<CR>


