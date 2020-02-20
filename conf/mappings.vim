" https://neovim.io/doc/user/map.html
"
" 在选择模式下, 将 space 也强制应于 leader, 不然会导致 space 真成空格了,
"Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap = :Tabularize /=<cr>

inoremap <C-c> <ESC>
nnoremap <c-e> :SwitchBuffer<cr>

vnoremap <space> <Nop>
" 在 yank 的时候,保持光标在最下方,而不是跳加到前面
vnoremap y y`]
nmap <silent> gp :!open % & <cr>

nmap dx dix
nmap dw diw
nmap cw ciw
nmap cW ciW
nmap vw viw
nmap dW diW
" 去除一层函数掉用  a(b)
nmap dc diwlds(
" add |($1)
nmap ziw viwSi
" add print($1)
nmap zfp vil)iprint<esc>
" 去除 函数名  a{ b }
nmap df diwlds{
" sudo write
cnoremap w!! w !sudo tee > /dev/null %
"map zz to za in normal mode
nnoremap zz  za
" select all  cmd+a
nnoremap <leader>a  ggVG
"https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
nnoremap <leader>q  <C-w><C-j><C-w>c

command! SelectAll  normal! ggVG 
command! SwitchBuffer :e # 
nnoremap Q  q
nnoremap q <esc>:q!<cr>
nnoremap <M-s> <esc>:w<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <F8> :copen<cr>
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
"inoremap <S-Tab> <C-d>
"
" 去除一层函数掉用  a(b)
nnoremap <leader>te :tabe<cr>
nnoremap <leader>u :UndotreeToggle<cr>
" close tab
nnoremap <leader>tc :tabc<cr>
" close buffer
" nnoremap <leader>bd  <C-w>c
" close buffer
" nnoremap <leader>ba :bwipe<cr>
"快速打开配置文件
"nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
nnoremap <leader>ef :e ~/.zk_vimrc/conf/plugins_mappings_config.vim<cr>
nnoremap <leader>ee :source ~/.zk_vimrc/.vimrc<cr>
nnoremap <leader>eh :e ~/.zk_vimrc/help.md<cr>
nnoremap <leader>et :e ~/.config/kitty/kitty.conf<cr>
nnoremap <leader>ec :e ~/bin/cmd_database.py<cr>

" format file without cursor moving to head, and move cursor the middle of screen
"nnoremap <leader>f mmgg=G`mzz
" move page down with cursor in the middle of screen
nnoremap <C-f> <C-d>zz
" move page up with cursor in the middle of screen
nnoremap <C-b> <C-u>zz
" define operator
" ex dp  delete  content in ()

"multi paste
xnoremap p pgvy


"http://janis-vitols.com/vim/tricks/2016/11/16/replace-word-or-selection-in-vim.html vnoremap ss y/\<C-R>=escape(@",'\/')<CR>//g<left><left>
" Replace visually selected text or word (globally with confirmation)
nnoremap <leader>s *:<C-U>let replacement = input('Replace word `<C-R><C-W>` with: ') <bar> %s/\<<C-R><C-W>\>/\=replacement/gc<CR>
vnoremap <leader>s y*:<C-U>let replacement = input('Replace selection `<C-R>"` with: ') <bar> %s/<C-R>"/\=replacement/gc<CR>

nnoremap W :w<cr>
" nnoremap z :wq<cr>
nnoremap <c-s> :w<cr>
nnoremap  <leader>w :w<cr>
inoremap  <c-s> <esc>:w<cr>li

" support emacs movement insert mode {{
inoremap <C-w> <C-c>diwi
inoremap <C-d> <Del>
inoremap <C-u> <C-G>u<C-U>
" inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-p> <up>
inoremap <c-n> <down>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-k> <c-o>d$
inoremap <c-l> <space>
"}}

" for auto completion
inoremap <C-space> <C-n>

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
"vnoremap p "_dP
"xnoremap <expr> p 'pgv"'.v:register.'y'
  


" max your window and restore back"
"https://stackoverflow.com/questions/15583346/how-can-i-temporarily-make-the-window-im-working-on-to-be-fullscreen-in-vim
"without plugin 
" <C-w>|  vertical max (common use)
" <C-w>_  horizontal max 
" <C-w>=  make all window the same size 
"with plugin 


nnoremap <C-m>o :copen<CR>

"make kj into jumplist 
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" insert time
" imap <silent> <C-d>d <C-R>=strftime("%Y-%m-%e %H:%M")<CR>
" imap <silent> <C-d>c <C-R>=string(eval(input("Calculate: ")))<CR>
