" 在选择模式下, 将 space 也强制应于 leader, 不然会导致 space 真成空格了,
"Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
" https://neovim.io/doc/user/map.html
" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" 重复替换的映射, 直接按 & 即可

nnoremap <F5> : call CompileRunGcc()<CR>
inoremap <F5> <esc>: call CompileRunGcc()<CR>
vnoremap gG "gy<Esc>:call GoogleSearch()<CR>
vnoremap ga "gy<esc>:call OpenChrome()<CR>
vnoremap gr "gy<Esc>:call FunReference()<CR>
nnoremap gr "gy<Esc>:call FunReference2(expand('<cword>'))<CR>
inoremap <expr> <CR> InsertMapForEnter()


nnoremap & :&&<CR>
xnoremap & :&&<CR>

inoremap <C-c> <ESC>

nnoremap <c-e> :SwitchBuffer<cr>


vnoremap <space> <Nop>
" 在 yank 的时候,保持光标在最下方,而不是跳加到前面
vnoremap y y`]
nnoremap <silent> gp :!open  "%:p" & <cr>

nnoremap yy ddu
nnoremap + :vertical resize +1<cr>
nnoremap - :vertical resize -1<cr>

"nnoremap <leader>cp :CocCommand python.
nnoremap <leader>E :e ++enc=utf-8<cr>:w!<cr>


nnoremap dc viwf(hxlds(
"nnoremap gG :!git-file-history %<cr>
nnoremap ga :Ag <c-r>=expand("<cword>")<cr><cr>

" create file if file not exist when using gf command in normal mode
" noremap gF :e <cfile><cr>

" select all  cmd+a
nnoremap <leader>a  ggVG
"https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
nnoremap <leader>q  <C-w><C-j><C-w>c

command! SelectAll  normal! ggVG
command! SwitchBuffer :e #
nnoremap Q  q
nnoremap q <esc>:q!<cr>
nnoremap <M-s> <esc>:w<cr>

" open with system opener
nnoremap go :!open '%'<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"noremap  <F4> :NERDTreeToggle<CR>
" indent  without lose the selection
vnoremap  <Tab> >gv
vnoremap  <S-Tab> <gv
vnoremap  <Space> <right>
vnoremap  <S-Space> <left>
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
nnoremap <leader>ef :e ~/.zk_vimrc/conf/plugins_mappings_config.vim<cr>
nnoremap <leader>ea :e /Users/zk/.config/coc/ultisnips/all.snippets <cr>
nnoremap <leader>ee :source ~/.zk_vimrc/.vimrc<cr>
nnoremap <leader>eh :e ~/.zk_vimrc/help.md<cr>
nnoremap <leader>et :e ~/.config/kitty/kitty.conf<cr>
nnoremap <leader>ec :e ~/bin/cmd_database.py<cr>
nnoremap <leader>e4 :e /usr/local/etc/proxychains.conf<cr>

" format file without cursor moving to head, and move cursor the middle of screen
"nnoremap <leader>f mmgg=G`mzz
" move page down with cursor in the middle of screen
nnoremap <C-f> <C-d>zz
" move page up with cursor in the middle of screen
nnoremap <C-b> <C-u>zz

nnoremap <C-m>o :copen<CR>

" swag : ;
nnoremap ;  :
nnoremap :  ;

"make kj into jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" nnoremap gm :call jobstart("mpv " . expand("<cWORD>"))<CR>

" 拼接字符串时不要跳光标
nnoremap J mzJ`z

" Moving text:
" 选择一段文本,用 J,K 移动
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <leader>. :echo expand('%:p')<CR>

"multi paste
xnoremap p pgvy


"http://janis-vitols.com/vim/tricks/2016/11/16/replace-word-or-selection-in-vim.html vnoremap ss y/\<C-R>=escape(@",'\/')<CR>//g<left><left>
" Replace visually selected text or word (globally with confirmation)
" nnoremap <leader>s *:<C-U>let replacement = input('Replace word `<C-R><C-W>` with: ') <bar> %s/\<<C-R><C-W>\>/\=replacement/gc<CR>
" vnoremap <leader>s y*:<C-U>let replacement = input('Replace selection `<C-R>"` with: ') <bar> %s/<C-R>"/\=replacement/gc<CR>

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

nnoremap / /\v
nnoremap ? ?\v
vnoremap / /\v
vnoremap ? ?\v

nnoremap <C-m>o :copen<CR>


" nnoremap <silent> gf :call JumpOrCreateFile()<CR>


