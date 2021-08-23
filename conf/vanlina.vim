
"vallina vim
"""""""""""""""""""""
" default  fuzzy search 
" set path+=**
" find **py

" command! MakeTags !ctags -R .
" ^ means ctrl
"  ^] jump to tags
"  g^] for ambiguous tags 
"  ^t jump back 
" 
" 
"  auto complete 
"  ^n 
"  ^p 
"  ^x^n  just this file completion
"  ^x^f  for filenames  (works with the path trik)
"  ^x^]  tags only
" 
" help: ins-completion

" netrw
" let g:netrw_banner=0         "disable annoying banner
" let g:netrw_browser_split=4  "open in prior window
" let g:netrw_altv=1  "oepn splits to the right
" let g:netrw_liststyle=3      "tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" <CR>/v/t to open in an h-split/v-split/tab
" check |netrw_browser_maps| for more mappings


" TEMPLATE:
" nnoremap ,html :-1read $HTML/.vim/.skeleton.html<CR>3jwf>a
"  -1  change the line by one. just a tweak


" MAKE
" - Run :make to run 
"       :cl to list erroes
"       :cc# to jump to error by number 
"       :cn and :cp to navigate forward and back
" 
" HELP
" :help i_^n  show the the ctrl-n  in insert mode
" :helpgrep  xxx  xxx is anything you want to find
" 
" 
" jumps and changes  command
" http://vimcasts.org/episodes/using-the-changelist-and-jumplist/

filetype plugin indent on
syntax on

set backspace=indent,eol,start
set hidden
set noswapfile
 
" in vim `set list` is enough,but neovim need to set listchars
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
" set list

set hlsearch
" 渐近搜索
set incsearch
" 忽略大小写
set ignorecase
" 但在自动补全时，大小写第三
set infercase
set magic
" 允许不写入 buffer 时,也只可以切换 buffer
set hidden
" 显示行号
set number
""" 显示相对行号
set relativenumber
set number
"" 支持系统剪贴板
set clipboard=unnamed
" 自动保存
set autowrite




" 设置 leader
let mapleader=" "
let $RTP=split(&runtimepath,',')[0]

nnoremap ; :
nnoremap : ;

nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>ep :e ~/.bash_profile<cr>
nnoremap <leader>ef :e ~/.zk_vimrc/conf/plugins_mappings_config.vim<cr>
nnoremap <leader>ee :source ~/.zk_vimrc/.vimrc<cr>
nnoremap <leader>eh :e ~/.zk_vimrc/help.md<cr>
nnoremap <leader>et :e ~/.config/kitty/kitty.conf<cr>
nnoremap <leader>ec :e ~/bin/cmd_database.py<cr>
nnoremap <leader>e4 :e /usr/local/etc/proxychains.conf<cr>

" support emacs movement insert mode {{
inoremap <C-w> <C-c>diwi
inoremap <C-d> <Del>
inoremap <C-u> <C-G>u<C-U>
inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-p> <up>
inoremap <c-n> <down>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-k> <c-o>d$
inoremap <c-l> <space>
" }}
