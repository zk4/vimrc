" 在选择模式下, 将 space 也强制应于 leader, 不然会导致 space 真成空格了,
"Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
vnoremap  <space> <Nop>
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
"nnoremap <leader>a  ggVG
"nnoremap  <leader>q  <C-w><C-j>:q<cr>
nnoremap  Q  q
nnoremap  QQ  :qa!<cr>
nnoremap  q  <esc>:q<cr>
" 在quickfix 里移动
noremap ∆ :cn<cr>
noremap ˚ :cp<cr>
" 全用不需要转义的正则表达式搜索
nnoremap / ms/\v
nnoremap ? ms?\v
" navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap <C-J> <C-W><C-J>
inoremap <C-K> <C-W><C-K>
inoremap <C-L> <C-W><C-L>
inoremap <C-H> <C-W><C-H>
nnoremap <F5> :call CompileRunGcc()<CR>
inoremap <F5> <esc>:call CompileRunGcc()<CR>
"nnoremap <leader>c :call CompileRunGcc()<CR>
noremap <F2> :cprevious<CR>
noremap <F3> :cnext<CR>
noremap <F6> :exec  '!clear && '.getline('.')<cr>
noremap <F4> :NERDTreeToggle<CR>
" indent without lose the selection
noremap <Tab> >gv
noremap <S-Tab> <gv
" switch between tab
nnoremap <Tab> gt
nnoremap <S-Tab> gT
" 在 insert mode 下,让 s-tab 向前 indent
inoremap <S-Tab> <C-d>
" 切换 buffer
"nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
" create tab
nnoremap <leader>te :tabe<cr>
" close tab
nnoremap <leader>tc :tabc<cr>
" close buffer
nnoremap <leader>bd :bd<cr>
" close buffer
nnoremap <leader>bda :bwipe<cr>
"快速打开配置文件
"nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ev :e ~/.zk_vimrc/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
nnoremap <leader>ef :e ~/.zk_vimrc/plugins_mappings_config.vim<cr>
" 快速  edit  snippet c
"nnoremap <leader>esc :e /Users/zk/.config/coc/extensions/node_modules/HdsCppSnippets/snippets/c_hds.json<cr>
"nnoremap <leader>g :Ack<space>
nnoremap <C-\> :NERDTreeToggle<CR>
inoremap <C-\> <esc>:NERDTreeToggle<CR>
" 这个映射用的太少了..
nnoremap <Leader><leader> *<CR>
"Alternatively, you could use this mapping so that the final /g is already entered:
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
"nnoremap ,, <esc>A,
" format file without cursor moving to head, and move cursor the middle of screen
nnoremap <leader>f mmgg=G`mzz
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
inoremap jj <esc>A
inoremap jk <esc>
"inoremap ;; <esc>A;
"inoremap <C-l> <esc>la
nnoremap gs : execute "grep -R " . shellescape(expand("<cword>")) . " ."<cr>:copen<cr><cr>
nnoremap gc : execute "Ack  " . shellescape(expand("<cword>")) . " %"<cr>:copen<cr><cr>
nnoremap <leader><leader> : execute "Ack  " . shellescape(expand("<cword>")) . " %"<cr>:copen<cr><cr>
nnoremap <leader>ps <esc>:call ProfileStart()<cr>
nnoremap <leader>pe <esc>:call ProfileEnd()<cr>
inoremap <c-a> <left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left> 
inoremap <c-e> <right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right><right>  
" support <c-a>  <c-e>  in insert mode for quick jump out
inoremap <c-b> <left>
inoremap <c-f> <right>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
